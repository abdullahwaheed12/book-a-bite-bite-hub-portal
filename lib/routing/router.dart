import 'package:bite_hub/pages/bitebag/bitebagPage.dart';
import 'package:bite_hub/routing/routes.dart';
import 'package:flutter/material.dart';

import '../pages/Coupons/coupons.dart';
import '../pages/bitehub/bitehubpage.dart';
import '../pages/bites/bitespage.dart';
import '../pages/customers/customers.dart';

import '../pages/mails/mails.dart';
import '../pages/myAccount/myAccount.dart';
import '../pages/orders/orders.dart';
import '../pages/overview/overview.dart';
import '../pages/payments/payment.dart';
import '../pages/pushNotifications/notifications.dart';
import '../pages/reports/reports.dart';
import '../pages/reviews/reviews.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case DashboardPageRoute:
      return _getPageRoute(OverviewPage());
    case OrdersPageRoute:
      return _getPageRoute(OrderPage());
    // case CustomersPageRoute:
    //   return _getPageRoute(CustomersPage());
    case BitesPageRoute:
      return _getPageRoute(BitesPage());
    case BiteBagPageRoute:
      return _getPageRoute(BiteBagPage());
    // case BiteHubPageRoute:
    //   return _getPageRoute(BiteHubPage());
    // case CouponsPageRoute:
    //   return _getPageRoute(CouponsPage());
    case ReviewsPageRoute:
      return _getPageRoute(ReviewsPage());
    case AccountsPageRoute:
      return _getPageRoute(AccountsPage());
    // case MailsPageRoute:
    //   return _getPageRoute(MailsPage());
    // case NotificationsPageRoute:
    //   return _getPageRoute(NotificationsPage());
    // case PaymentsPageRoute:
    //   return _getPageRoute(PaymentsPage());
    case ReportsPageRoute:
      return _getPageRoute(ReportsPage());

    default:
      return _getPageRoute(OverviewPage());
  }
}

Route<dynamic>? _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
