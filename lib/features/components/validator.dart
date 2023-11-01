// matching various patterns for kinds of data
import 'package:get/get.dart';

class Validator {
  Validator();

  String? email(String? value) {
    String pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!))
      return "Adresse mail non valide";
    else
      return null;
  }

  String? password(String? value) {
    String pattern = r'^.{6,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!))
      return "Mot de passe non valide";
    else
      return null;
  }

  String? cin(String? value) {
    String pattern = r'^[0-9].{7}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!))
      return "Votre cin non valide";
    else
      return null;
  }

  String? name(String? value) {
    String pattern = r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!))
      return "nom et prenom non valide";
    else
      return null;
  }

  String? number(String? value) {
    String pattern = r'^[0-9].{7}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!))
      return "votre numero non valide";
    else
      return null;
  }



  String? notEmpty(String? value) {
    String pattern = r'^\S+$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!))
      return 'validator.notEmpty'.tr;
    else
      return null;
  }
}