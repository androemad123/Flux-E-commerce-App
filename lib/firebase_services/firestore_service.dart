import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

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

  Future<String> create(T data) async {
    final docRef = await _firestore.collection(collection).add(toJson(data));
    return docRef.id;
  }

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

  Future<List<T>> getAll() async {
    final querySnapshot = await _firestore.collection(collection).get();
    log(
      'Raw Firestore data: ${querySnapshot.docs.map((doc) => doc.data()).toList()}',
    );

    final documents =
        querySnapshot.docs.map((doc) {
          final data = {...doc.data(), 'id': doc.id};
          log('Processing document: $data');
          return fromJson(data);
        }).toList();

    log('Processed documents: $documents');
    return documents;
  }

  Future<List<T>> getWhere(String field, dynamic isEqualTo) async {
    final querySnapshot =
        await _firestore
            .collection(collection)
            .where(field, isEqualTo: isEqualTo)
            .get();

    final documents =
        querySnapshot.docs.map((doc) {
          final data = {...doc.data(), 'id': doc.id};
          return fromJson(data);
        }).toList();

    return documents;
  }

  Future<void> update(String id, T data) async {
    log('Updating document with ID: $id in collection: $collection');
    final jsonData = toJson(data);
    log('Update data: $jsonData');
    await _firestore.collection(collection).doc(id).update(jsonData);
  }
Future<void> updateRaw(String id, Map<String, dynamic> data) async {
  await _firestore.collection(collection).doc(id).update(data);
}

  Future<void> delete(String id) async {
    await _firestore.collection(collection).doc(id).delete();
  }
}
