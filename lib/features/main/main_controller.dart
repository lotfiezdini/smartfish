import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:windy/features/main/historique/historical_page.dart';
import 'package:windy/features/main/settings/settings_page.dart';

import 'home/home_page.dart';




class MainController extends GetxController {
  static MainController get to => Get.find();
  var currentIndex = 0.obs ;

  final pages = <String>["/home", "/historical", "/settings",];

  void changePage(int index) {
    currentIndex.value = index ;
    Get.toNamed(pages[index],id: 1);
  }

  Route? onGenerateRoute (RouteSettings settings) {
    if(settings.name =="/home") {
      return GetPageRoute(
          settings: settings,
          page: ()=>HomePage()
      );
    }

    if(settings.name =="/historical") {
      return GetPageRoute(
          settings: settings,
          page: ()=>HistoricalPage()
      );
    }

    if(settings.name =="/settings") {

      return GetPageRoute(
          settings: settings,
          page: ()=>SettingsPage()
      );
    }
  }

}