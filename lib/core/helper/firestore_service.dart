import 'package:cloud_firestore/cloud_firestore.dart';

abstract class RemoteDataService {
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    String? documentId,
  });
  Future<dynamic> getData({
    required String path,
    String? documentId,
    Map<String, dynamic>? query,
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
  Future<dynamic> getData({
    required String path,
    String? documentId,
    Map<String, dynamic>? query,
  }) async {
    if (documentId != null) {
      DocumentSnapshot data =
          await firestore.collection(path).doc(documentId).get();
      return data.data() as Map<String, dynamic>;
    } else {
      Query<Map<String, dynamic>> data = firestore.collection(path);
      if (query != null) {
        var orderBy = query['orderBy'];
        var limit = query['limit'];
        var descending = query['descending'];

        if (orderBy != null) {
          data = data.orderBy(orderBy, descending: descending);
        }
        if (limit != null) {
          data = data.limit(limit);
        }
      }
      var result = await data.get();
      return result.docs.map((e) => e.data()).toList();
    }
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
