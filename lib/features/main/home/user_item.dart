
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:windy/features/auth/auth_controller.dart';

import '../../../models/user_model.dart';


class UserItem extends StatelessWidget {
  final UserModel item ;
  const UserItem({Key? key, required this.item,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Colors.white60,
      child: ListTile(
        contentPadding: EdgeInsets.all(8),
        onTap: () {

        },
        leading: Column(
          children: [
            const Text("Nom : ",
                style: TextStyle(fontSize: 10)),
            Text("${item.fullName}"),
          ],
        ),
        subtitle: Column(
          children: [
            Row(
              children: [
                const Text("Addresse : ",
                    style: TextStyle(fontSize: 12)),
                Text("${item.address}"),
              ],
            ),
            Row(
              children: [
                const Text("Port: ",
                    style: TextStyle(fontSize: 12)),
                Text("${item.port}"),
              ],
            )
          ],
        ),
        trailing: Obx(
              () => AuthController.to.admin.isTrue
              ? IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                //  onRemoveItemClicked(item.id);
                },
              )
              : const SizedBox(),
        ),
      ),
    );
  }
}
