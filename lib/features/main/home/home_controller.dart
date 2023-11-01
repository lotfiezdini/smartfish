
import 'package:get/get.dart';
import 'package:windy/features/services/user_service.dart';
import 'package:windy/models/user_model.dart';

import '../../auth/auth_controller.dart';

class HomeController extends GetxController {
 final service = Get.find<UserService>();

 RxList<UserModel> filteredUsers = <UserModel>[].obs;
 List<UserModel> counters = List.empty(growable: true);
 var isLoading = true; //
  String? port ;

 @override
 onReady() {
  handleRoleChange(AuthController.to.admin.value);
  port = AuthController.to.firestoreUser.value?.port;
  super.onReady();
 }

 getUsers() {
  print("getUsers");
  service.streamUsers(port).listen((event) {
   filteredUsers.value = event;
   counters = event;
   isLoading = false;
  });
 }

 handleRoleChange(bool isAdmin) {
  print("");
  if (isAdmin) {
   getAllUsers();
  } else {
   getUsers();
  }
 }

 getAllUsers() {
  print("getAllUsers");
  service.streamAllUsers(port).listen((event) {
   filteredUsers.value = event;
   counters = event;
   isLoading = false;
  });
 }



 void filterUsers(String query) {
  List<UserModel> results = [];
  if (query.isEmpty) {
   results.addAll(counters);
  } else {
   results = counters
       .where((element) =>
   element.fullName
       .toString()
       .toLowerCase()
       .contains(query.toLowerCase()) )
       .toList();
  }
  filteredUsers.value = results;
 }
}

