import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
 late final String id;
 late final String name;
 late final String email;

  UserModel({required this.id, required this.name, required this.email});

  UserModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    this.id = doc.id;
    this.name = doc['name'];
    this.email = doc['email'];
  }

  
}
