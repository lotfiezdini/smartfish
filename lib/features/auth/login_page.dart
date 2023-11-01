import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:windy/features/auth/register_page.dart';
import 'package:windy/features/auth/reset_password_page.dart';

import '../components/form_input_field_with_icon.dart';
import '../components/label_button.dart';
import '../components/primary_button.dart';
import '../components/utils.dart';
import '../components/validator.dart';
import 'auth_controller.dart';

class LoginPage extends StatelessWidget {
   LoginPage({Key? key}) : super(key: key);
  final AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('Bienvenue'),
                  verticalSpaceSmall,
                  Text('Connectez vous'),
                  verticalSpacingXLarge,
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
                      labelText: "Connexion",
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          authController.signInWithEmailAndPassword(context);
                        }
                      }),
                  verticalSpaceMedium,
                  LabelButton(
                    labelText: "Mot de passe oublié?",
                    onPressed: () => Get.to(ResetPasswordPage()),
                  ),
                  LabelButton(
                    labelText: "Créer nouveau compte",
                    onPressed: () => Get.to(RegisterPage()),
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
