import 'package:bite_hub/controllers/general_controller.dart';
import 'package:bite_hub/login_signup/welcomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bite_hub/component/side_menu_item.dart';
import '../constants/controller.dart';
import '../constants/style.dart';
import '../helpers/responsiveness.dart';
import '../routing/routes.dart';
import 'custom_text.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Container(
      // color: Colors.red,
      child: ListView(
        children: [
          if (ResponsiveWidget.isSmallScreen(context))
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    // SizedBox(width: _width / 28),
                    Image.asset("assets/Logo.png"),

                    // Flexible(
                    //   child: CustomText(
                    //     text: "Dash",
                    //     size: 20,
                    //     fontWeight: FontWeight.bold,
                    //     color: active,
                    //   ),
                    // ),
                    // SizedBox(width: _width / 28),
                  ],
                ),
              ],
            ),
          SizedBox(
            height: 3,
          ),

          // Divider(
          //   color: lightGrey.withOpacity(.1),
          // ),
          Column(
            children: [
              Image.asset(
                'assets/Logo.png',
                height: 100,
                width: 100,
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: sideMenuItems
                    .map((item) => SideMenuItem(
                        itemName: item.name,
                        onTap: () {
                          if (item.route == '/auth') {
                            Get.find<GeneralController>()
                                .firebaseAuthentication
                                .signOut();
                            menuController
                                .changeActiveItemTo(DashboardPageDisplayName);
                            Get.offAll(WelcomePage());
                          } else if (!menuController.isActive(item.name)) {
                            menuController.changeActiveItemTo(item.name);
                            if (ResponsiveWidget.isSmallScreen(context))
                              Get.back();
                            navigationController.navigateTo(item.route);
                          }
                        }))
                    .toList(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
