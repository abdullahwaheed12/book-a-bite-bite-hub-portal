import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../constants/style.dart';
import '../routing/routes.dart';

class MenuController extends GetxController {
  static MenuController instance = Get.find();
  var activeItem = DashboardPageDisplayName.obs;
  var hoverItem = ''.obs;

  changeActiveItemTo(String itemName) {
    activeItem.value = itemName;
  }

  onHover(String itemName) {
    if (!isActive(itemName)) hoverItem.value = itemName;
  }

  isActive(String itemName) => activeItem.value == itemName;
  isHovering(String itemName) => hoverItem.value == itemName;

  Widget? returnIconFor(String itemName) {
    switch (itemName) {
      case DashboardPageDisplayName:
        return _customIcon(Icons.dashboard, itemName);
      case OrdersPageDisplayName:
        return _customIcon(Icons.bookmark_border_sharp, itemName);
      // case CustomersPageDisplayName:
      //   return _customIcon(Icons.people_alt_rounded, itemName);
      case BitesPageDisplayName:
        return _customIcon(Icons.fastfood_outlined, itemName);
      // case BiteHubPageDisplayName:
      //   return _customIcon(Icons.restaurant_menu_outlined, itemName);
      // case CouponsPageDisplayName:
      //   return _customIcon(Icons.note, itemName);
      case ReviewsPageDisplayName:
        return _customIcon(Icons.reviews, itemName);
      case AccountsPageDisplayName:
        return _customIcon(Icons.account_balance_wallet, itemName);
      // case MailsPageDisplayName:
      //   return _customIcon(Icons.mail, itemName);
      // case NotificationsPageDisplayName:
      //   return _customIcon(Icons.notifications_active, itemName);
      // case PaymentsPageDisplayName:
      //   return _customIcon(Icons.payment, itemName);
      case ReportsPageDisplayName:
        return _customIcon(Icons.report, itemName);
      case AuthenticationDisplayName:
        return _customIcon(Icons.exit_to_app, itemName);
      default:
        return _customIcon(Icons.exit_to_app, itemName);
    }
  }

  Widget? _customIcon(IconData icon, String itemName) {
    if (isActive(itemName))
      return Icon(
        icon,
        size: 22,
        color: active,
      );
    return Icon(icon, color: isHovering(itemName) ? active : lightGrey);
  }
}
