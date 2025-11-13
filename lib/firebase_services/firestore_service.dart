import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class FirestoreService<T> {
  final FirebaseFirestore _firestore;
  final String collection;
  final T Function(Map<String, dynamic> json) fromJson;
  final Map<String, dynamic> Function(T model) toJson;

  FirestoreService({
    required this.collection,
    required this.fromJson,
    required this.toJson,
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  // Add new Document to the Collection and return doc ID
  Future<String> create(T data) async {
    try {
      final docRef = await _firestore.collection(collection).add(toJson(data));
      return docRef.id;
    } catch (e) {
      log("Create failed: $e");
      rethrow;
    }
  }

  // Get specific Doc using id
  Future<T?> get(String id) async {
    log('Fetching document with ID: $id from collection: $collection');
    final docSnapshot = await _firestore.collection(collection).doc(id).get();
    if (!docSnapshot.exists) {
      log('Document not found with ID: $id');
      return null;
    }
    final data = {...docSnapshot.data()!, 'id': docSnapshot.id};
    log('Retrieved document data: $data');
    return fromJson(data);
  }

  // Get All Documents
  Future<List<T?>> getAll() async {
    final querySnapshot = await _firestore.collection(collection).get();
    log(
      'Raw Firestore data: ${querySnapshot.docs.map((doc) => doc.data()).toList()}',
    );

    final documents = querySnapshot.docs.map((doc) {
      final docData = doc.data();
      if (docData.isEmpty) return null;
      final data = {...docData, 'id': doc.id};
      log('Processing document: $data');
      return fromJson(data);
    }).toList();

    log('Processed documents: $documents');
    return documents;
  }

  // Filter Docs
  Future<List<T?>> getWhere(String field, dynamic isEqualTo) async {
    final querySnapshot = await _firestore
        .collection(collection)
        .where(field, isEqualTo: isEqualTo)
        .get();

    final documents = querySnapshot.docs.map((doc) {
      final docData = doc.data();
      if (docData.isEmpty) return null;
      final data = {...docData, 'id': doc.id};
      return fromJson(data);
    }).toList();

    return documents;
  }

  // Update Doc using its ID and the models
  Future<void> update(String id, T data) async {
    log('Updating document with ID: $id in collection: $collection');
    try {
      final jsonData = toJson(data);
      log('Update data: $jsonData');
      await _firestore.collection(collection).doc(id).update(jsonData);
    } catch (e) {
      log("Updated failed: $e");
    }
  }

  // Update Doc using its ID and the mapping data
  Future<void> updateRaw(String id, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collection).doc(id).update(data);
    } catch (e) {
      log('Failed to update document $id: $e');
    }
  }

  // Delete Doc using its ID
  Future<void> delete(String id) async {
    try {
      await _firestore.collection(collection).doc(id).delete();
    } catch (e) {
      log("Delete failed: $e");
    }
  }

  Future<void> uploadImageToFirestore() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      // قراءة الصورة كـ bytes
      Uint8List imageBytes = await image.readAsBytes();

      // تحويلها إلى Base64
      String base64String = base64Encode(imageBytes);

      // حفظها في Firestore
      await FirebaseFirestore.instance.collection('images').add({
        'image': base64String,
        'timestamp': DateTime.now(),
      });
    }
  }
}
