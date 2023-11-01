import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:windy/models/enums/port_model.dart';
import 'package:windy/models/enums/user_type.dart';

import '../components/form_input_field_with_icon.dart';
import '../components/label_button.dart';
import '../components/primary_button.dart';
import '../components/utils.dart';
import '../components/validator.dart';
import 'auth_controller.dart';
import 'login_page.dart';

class RegisterPage extends StatelessWidget {
   RegisterPage({Key? key}) : super(key: key);
  final AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
  return  Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  //  LogoGraphicHeader(),
                  Text('Creer vote compte'),
                  verticalSpacingXLarge,
                  Obx(
                    ()=> Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Type d'utilisateur:"),
                        DropdownButton(

                          // Initial Value
                          value: authController.userType.value,

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
                          onChanged: authController.updateUserType,
                        ),
                      ],
                    ),
                  ),
                  verticalSpaceSmall,
                  FormInputFieldWithIcon(
                    controller: authController.fullnameController,
                    iconPrefix: Icons.person,
                    labelText: "Nom & Prénom",
                    validator: Validator().name,
                    onChanged: (value) => null,
                    onSaved: (value) =>
                    authController.fullnameController.text = value!,
                  ),
                  verticalSpaceSmall,
                  FormInputFieldWithIcon(
                    controller: authController.addressController,
                    iconPrefix: Icons.person,
                    labelText: "Adresse",
                    validator: Validator().name,
                    onChanged: (value) => null,
                    onSaved: (value) =>
                    authController.fullnameController.text = value!,
                  ),
                  verticalSpaceMedium,
                  Obx(
                        ()=> Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Port:"),
                        DropdownButton(

                          // Initial Value
                          value: authController.port.value,

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
                          onChanged: authController.updatePort,
                        ),
                      ],
                    ),
                  ),
                  verticalSpaceMedium,
                  FormInputFieldWithIcon(
                    controller: authController.emailController,
                    iconPrefix: Icons.email,
                    labelText: "Adresse email",
                    validator: Validator().email,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => null,
                    onSaved: (value) =>
                    authController.emailController.text = value!,
                  ),
                  verticalSpaceMedium,
                  FormInputFieldWithIcon(
                    controller: authController.passwordController,
                    iconPrefix: Icons.lock,
                    labelText: "Mot de passe",
                    validator: Validator().password,
                    obscureText: true,
                    onChanged: (value) => null,
                    onSaved: (value) =>
                    authController.passwordController.text = value!,
                    maxLines: 1,
                  ),

                  verticalSpaceMedium,
                  PrimaryButton(
                      labelText: "Creer Compte",
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          SystemChannels.textInput.invokeMethod(
                              'TextInput.hide'); //to hide the keyboard - if any
                          authController.registerWithEmailAndPassword(context);
                        }
                      }),
                  verticalSpaceMedium,
                  LabelButton(
                    labelText: "Connexion",
                    onPressed: () => Get.to(LoginPage()),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
