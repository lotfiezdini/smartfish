import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:windy/features/main/main_controller.dart';

class MainPage extends StatelessWidget {
   MainPage({Key? key}) : super(key: key);
  final MainController controller = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: Get.nestedKey(1),
        initialRoute: "/home",
        onGenerateRoute: controller.onGenerateRoute,

      ),
      bottomNavigationBar: Obx(
            () => BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Accueil',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'Historique',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Parameters',
            ),
          ],
          currentIndex: controller.currentIndex.value,
          selectedItemColor: Colors.blueAccent,
          onTap: controller.changePage,
        ),
      ),
    );
  }
}
