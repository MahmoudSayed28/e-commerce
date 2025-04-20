import 'package:cloud_firestore/cloud_firestore.dart';

abstract class RemoteDataService {
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    String? documentId,
  });
  Future<Map<String, dynamic>> getData({
    required String path,
    required String uId,
  });
  Future<bool> isDataExist({required String path, required String documentId});
}

class FirestoreService implements RemoteDataService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    String? documentId,
  }) async {
    documentId != null
        ? await firestore.collection(path).doc(documentId).set(data)
        : await firestore.collection(path).add(data);
  }

  @override
  Future<Map<String, dynamic>> getData({
    required String path,
    required String uId,
  }) async {
    DocumentSnapshot data = await firestore.collection(path).doc(uId).get();
    return data.data() as Map<String, dynamic>;
  }

  @override
  Future<bool> isDataExist({
    required String path,
    required String documentId,
  }) async {
    var data = await firestore.collection(path).doc(documentId).get();
    return data.exists;
  }
}
