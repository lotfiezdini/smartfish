import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:windy/features/auth/auth_controller.dart';
import 'package:windy/features/components/utils.dart';
import 'package:windy/features/main/home/add/add_user_page.dart';
import 'package:windy/features/main/home/home_controller.dart';
import 'package:windy/features/main/home/user_item.dart';

class HomePage extends StatelessWidget {
   HomePage({Key? key}) : super(key: key);
  final controller = Get.put(HomeController());
  final authController = AuthController.to;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        title: Text("Utilisateurs"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (value) => controller.filterUsers(value),
            decoration: const InputDecoration(
              labelText: 'Search',
              suffixIcon: Icon(Icons.search),
            ),
          ),
          verticalSpaceTiny,
          Expanded(child: Obx(
                  () => controller.filteredUsers.isEmpty && controller.isLoading ? const Center(
                child: CircularProgressIndicator(),
              ) : controller.filteredUsers.isEmpty ? const Center(
                child: Text("aucun utilisateur"),
              ) :  ListView.builder(
                  itemCount: controller.filteredUsers.length ,
                  padding: EdgeInsets.all(16),
                  itemBuilder: (context, index) {
                    return    UserItem(
                      item: controller.filteredUsers[index],
                    );
                  })

          )),
        ],
      ),
      floatingActionButton: Obx(
            () => authController.admin.isTrue
            ? FloatingActionButton(
          onPressed: () {
            Get.to(() => AddUserPage());
          },
          child: const Icon(Icons.add_circle_outline_rounded, size: 48),
        )
            : const SizedBox(),
      ),
    );
  }
}
