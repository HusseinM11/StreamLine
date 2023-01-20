import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:streamline/constants/firebase_constants.dart';
import 'package:streamline/model/user.dart';

class UserController extends GetxController {
  Rx<UserModel> _userModel = UserModel().obs;

  UserModel get user => _userModel.value;
  set user(UserModel value) => this._userModel.value = value;

  void clear() {
    _userModel.value = UserModel();
  }

  Future<bool> createNewUser(UserModel user) async {
    try {
      await firebaseFirestore.collection("users").doc(user.id).set({
        "name": user.name,
        "email": user.email,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<UserModel> getUser(String uid) async {
    try {
      DocumentSnapshot _doc =
          await firebaseFirestore.collection("users").doc(uid).get();

      return UserModel.fromDocumentSnapshot(_doc);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  
  Future<void> updateEmail(String email) async {
    try {
      await auth.currentUser!.updateEmail(email);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  //function to update name in firestore
  Future<void> updateName(String name) async {
    try {
      await firebaseFirestore
          .collection("users")
          .doc(auth.currentUser!.uid)
          .update({"name": name});
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
