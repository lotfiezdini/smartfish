import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:windy/models/enums/user_type.dart';
import 'package:windy/models/user_model.dart';

class UserService {
  static const collectionKey = "users";
  final _fireStore = FirebaseFirestore.instance;

  Stream<List<UserModel>> streamUsers(String? port) {
    return _fireStore
        .collection(collectionKey)
        .where("type", isNotEqualTo: UserType.officer.name)
        .where("port", isEqualTo: port)
        .snapshots()
        .map((event) {
      List<UserModel> Users = [];
      Users.addAll(
          event.docs.map((e) => UserModel.fromJson(e.data())).toList());

      return Users;
    });
  }

  Stream<List<UserModel>> streamAllUsers(String? port) {
    return _fireStore
        .collection(collectionKey)
        .where("port", isEqualTo: port)
        .snapshots()
        .map((event) {
      List<UserModel> Users = [];
      Users.addAll(
          event.docs.map((e) => UserModel.fromJson(e.data())).toList());

      return Users;
    });
  }
}
