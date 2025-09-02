import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signIn({
    required String email,
    required String password,
  }) async {
    final UserCredential userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);

    await _updateFcmToken(userCredential.user!.uid);
    return userCredential.user!.uid;
  }

  Future<String> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);

    final String uid = userCredential.user!.uid;

    await _firestore.collection('users').doc(uid).set({
      'name': name,
      'email': email,
      // 'password': password,
      'userId': uid,
    });

    await _updateFcmToken(uid);
    return uid;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> _updateFcmToken(String? id) async {
    if (id == null) return;

    final String? token = await _firebaseMessaging.getToken();
    if (token != null) {
      try {
        await _firestore.collection('users').doc(id).set({
          'token': token,
        }, SetOptions(merge: true));
      } catch (_) {
        // Silently ignore token update failures to avoid blocking auth flow
      }
    }
  }

  Future<String> signInWithGoogle() async {
    // Trigger the authentication flow
    GoogleSignIn googleSignIn = GoogleSignIn.instance;

    await googleSignIn.initialize(
      serverClientId:
          '1091133489164-tk1fgq97jem7mmgka9s0b7pn9hgl61ol.apps.googleusercontent.com',
    );

    final GoogleSignInAccount googleUser = await googleSignIn.authenticate();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    final UserCredential userCredential = await FirebaseAuth.instance
        .signInWithCredential(credential);

    final String uid = userCredential.user!.uid;

    // Save user info in Firestore (merge in case they already exist)
    await _firestore.collection('users').doc(uid).set({
      'name': googleUser.displayName,
      'email': googleUser.email,
      'userId': uid,
    }, SetOptions(merge: true));

    // Update the FCM token
    await _updateFcmToken(uid);

    return userCredential.user!.uid;
  }
}
