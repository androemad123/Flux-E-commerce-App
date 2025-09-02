import 'dart:developer';

import 'package:depi_graduation/firebase_services/firebase_auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthDataSource {
  Future<String> login(String email, String password);
  Future<String> register(String name, String email, String password);
  Future<String> signInWithGoogle();
}

class AuthDataSourceImpl implements AuthDataSource {
  // final ApiService apiService;
  final FirebaseAuthServices authServices;
  AuthDataSourceImpl({required this.authServices});
  @override
  Future<String> login(String email, String password) async {
    final userCredential = await authServices.signIn(
      email: email,
      password: password,
    );
    return userCredential;
  }

  @override
  Future<String> register(String name, String email, String password) async {
    final response = await authServices.signUp(
      name: name,
      email: email,
      password: password,
    );
    log("response from register : $response");
    return response;
  }

  @override
  Future<String> signInWithGoogle() async {
    final uid = await authServices.signInWithGoogle();
    return uid;
  }
}
