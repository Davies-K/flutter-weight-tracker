import 'package:cloud_firestore/cloud_firestore.dart';

class Weight {
  final String value;
  final Timestamp? reference;

  Weight({this.reference, required this.value});
}
