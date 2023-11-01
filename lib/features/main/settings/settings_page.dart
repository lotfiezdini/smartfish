import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:windy/features/auth/auth_controller.dart';
import 'package:windy/features/auth/login_page.dart';
import 'package:windy/features/auth/reset_password_page.dart';
import 'package:windy/features/components/form_input_field_with_icon.dart';
import 'package:windy/features/components/label_button.dart';
import 'package:windy/features/components/primary_button.dart';
import 'package:windy/features/components/utils.dart';
import 'package:windy/features/components/validator.dart';
import 'package:windy/models/user_model.dart';


class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);
  final AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    authController.fullnameController.text =
        authController.firestoreUser.value!.fullName!;
    authController.emailController.text =
        authController.firestoreUser.value!.email!;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Modifier Données"),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                const PopupMenuItem<int>(value: 0, child: Text("Logout"))
              ];
            },
            onSelected: (value) {
              switch (value) {
                case 0:
                  {
                    authController.signOut();
                    Get.offAll(LoginPage());
                    break;
                  }
              }
            },
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(height: 48.0),
                  FormInputFieldWithIcon(
                    controller: authController.fullnameController,
                    iconPrefix: Icons.person,
                    labelText: "Nom & Prenom",
                    validator: Validator().name,
                    onChanged: (value) => null,
                    onSaved: (value) =>
                        authController.fullnameController.text = value!,
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
                  PrimaryButton(
                      labelText: 'Modifier ',
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          SystemChannels.textInput
                              .invokeMethod('TextInput.hide');
                          UserModel _updatedUser = UserModel(
                              id: authController.firestoreUser.value!.id,
                              fullName: authController.fullnameController.text,
                              email: authController.emailController.text,);

                      /*    _updateUserConfirm(context, _updatedUser,
                              authController.firestoreUser.value!.email);*/
                        }
                      }),
                  verticalSpaceMedium,
                  LabelButton(
                    labelText: "mot de passe oublié",
                    onPressed: () => Get.to(ResetPasswordPage()),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _updateUserConfirm(
      BuildContext context, UserModel updatedUser, String oldEmail) async {
    final AuthController authController = AuthController.to;
    final TextEditingController _password = new TextEditingController();
    return Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        title: Text(
          "Entrer votre mot de passe",
        ),
        content: FormInputFieldWithIcon(
          controller: _password,
          iconPrefix: Icons.lock,
          labelText: "Mot de passe",
          validator: (value) {
            String pattern = r'^.{6,}$';
            RegExp regex = RegExp(pattern);
            if (!regex.hasMatch(value!))
              return "Mot de passe Invalid";
            else
              return null;
          },
          obscureText: true,
          onChanged: (value) => null,
          onSaved: (value) => _password.text = value!,
          maxLines: 1,
        ),
        actions: <Widget>[
          TextButton(
            child: const Text(
              'Annuler',
            ),
            onPressed: () {
              Get.back();
            },
          ),
          TextButton(
            child: const Text('Enregistrer'),
            onPressed: () async {
              Get.back();
              await authController.updateUser(
                  context, updatedUser, oldEmail, _password.text);
            },
          )
        ],
      ),
    );
  }
}
