import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:windy/models/enums/port_model.dart';
import 'package:windy/models/enums/user_type.dart';
import 'package:windy/models/user_model.dart';

class AddUserController extends GetxController {
  TextEditingController fullnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Rxn<UserType> userType = Rxn(UserType.officer);
  Rxn<PortModel> port = Rxn(PortModel.rades);

  updateUserType(UserType? type) {
    if (type != null) {
      userType.value = type;
      update();
    }
  }

  updatePort(PortModel? port) {
    if (port != null) {
      this.port.value = port;
      update();
    }
  }

  createUser() async {
    FirebaseApp app = await Firebase.initializeApp(
        name: 'Secondary', options: Firebase.app().options);

    try {
      final result = await FirebaseAuth.instanceFor(app: app)
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
      UserModel _newUser = UserModel(
          id: result.user!.uid,
          email: result.user!.email!,
          fullName: fullnameController.text,
          address: addressController.text,
          port: port.value?.name,
          type: userType.value ?? UserType.officer);
      _createUserFirestore(_newUser, result.user!);

    } on FirebaseAuthException catch (e) {
      // Do something with exception. This try/catch is here to make sure
      // that even if the user creation fails, app.delete() runs, if is not,
      // next time Firebase.initializeApp() will fail as the previous one was
      // not deleted.
    }

    await app.delete();
  }

  //create the firestore user in users collection
  void _createUserFirestore(UserModel user, User _firebaseUser) {
    _db.doc('/users/${_firebaseUser.uid}').set(user.toJson());
    update();
  }
}
