import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:windy/features/auth/auth_controller.dart';
import 'package:windy/features/components/form_input_field_with_icon.dart';
import 'package:windy/features/components/primary_button.dart';
import 'package:windy/features/components/utils.dart';
import 'package:windy/features/components/validator.dart';
import 'package:windy/features/main/home/add/add_user_controller.dart';
import 'package:windy/models/enums/port_model.dart';
import 'package:windy/models/enums/user_type.dart';

class AddUserPage extends StatelessWidget {
   AddUserPage({Key? key}) : super(key: key);
  final AddUserController addController = Get.put(AddUserController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold( appBar: AppBar(
      leading: const SizedBox(),
      title: Text("Utilisateurs"),
      centerTitle: true,
    ),
    body: SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            verticalSpacingXLarge,
            Obx(
                  ()=> Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Type d'utilisateur:"),
                  DropdownButton(

                    // Initial Value
                    value: addController.userType.value,

                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items
                    items: UserType.values.map((UserType item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item.name),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: addController.updateUserType,
                  ),
                ],
              ),
            ),
            verticalSpaceSmall,
            FormInputFieldWithIcon(
              controller: addController.fullnameController,
              iconPrefix: Icons.person,
              labelText: "Nom & Prénom",
              validator: Validator().name,
              onChanged: (value) => null,
              onSaved: (value) =>
              addController.fullnameController.text = value!,
            ),
            verticalSpaceSmall,
            Obx(
                  ()=> Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Port:"),
                  DropdownButton(

                    // Initial Value
                    value: addController.port.value,

                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items
                    items: PortModel.values.map((PortModel item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item.name),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: addController.updatePort,
                  ),
                ],
              ),
            ),
            verticalSpaceMedium,
            FormInputFieldWithIcon(
              controller: addController.emailController,
              iconPrefix: Icons.email,
              labelText: "Adresse email",
              validator: Validator().email,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) => null,
              onSaved: (value) =>
              addController.emailController.text = value!,
            ),
            verticalSpaceMedium,
            FormInputFieldWithIcon(
              controller: addController.passwordController,
              iconPrefix: Icons.lock,
              labelText: "Mot de passe",
              validator: Validator().password,
              obscureText: true,
              onChanged: (value) => null,
              onSaved: (value) =>
              addController.passwordController.text = value!,
              maxLines: 1,
            ),

            verticalSpaceMedium,
            PrimaryButton(
                labelText: "Ajouter Utlisateur",
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                   //to hide the keyboard - if any
                    addController.createUser();
                  }
                }),],
        ),
      ),
    ),);
  }
}
