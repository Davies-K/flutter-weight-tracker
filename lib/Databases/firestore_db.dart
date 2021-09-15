import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plendify/Models/weight.dart';

class FireStoreDB {
  String dbName = "weightCollection";

  late FirebaseFirestore weightDB;

  FireStoreDB() {
    weightDB = FirebaseFirestore.instance;
  }

  Future<void> postWeight(Weight w, String userId) async {
    try {
      await weightDB.collection(dbName).add({
        "user": userId,
        "value": w.value,
        "createdAt": FieldValue.serverTimestamp()
      });
    } catch (e) {}
  }

  Future<void> updateWeight(String value, Timestamp ref, String userId) async {
    try {
      var docSnapshot = await weightDB
          .collection(dbName)
          .where("createdAt", isEqualTo: ref)
          .where("user", isEqualTo: userId)
          .get();
      for (var doc in docSnapshot.docs) {
        await doc.reference.update({"value": value});
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteWeight(Weight w, String userId) async {
    try {
      var docSnapshot = await weightDB
          .collection(dbName)
          .where("createdAt", isEqualTo: w.reference!)
          .where("user", isEqualTo: userId)
          .get();
      for (var doc in docSnapshot.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      rethrow;
    }
  }
}
