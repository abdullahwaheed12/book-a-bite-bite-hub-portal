import 'package:bite_hub/controllers/general_controller.dart';
import 'package:bite_hub/pages/overview/widgets/available_orders.dart';
import 'package:bite_hub/pages/overview/widgets/overview_cards_lage.dart';
import 'package:bite_hub/pages/overview/widgets/overview_cards_medium.dart';
import 'package:bite_hub/pages/overview/widgets/overview_vards_small.dart';
import 'package:bite_hub/pages/overview/widgets/revenue_section_large.dart';
import 'package:bite_hub/pages/overview/widgets/revenue_section_small.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../component/custom_text.dart';
import '../../constants/controller.dart';
import '../../constants/style.dart';
import '../../helpers/responsiveness.dart';

int? totalBites = 0;
int? totalOrders = 0;
int? totalCustomers = 0;

class OverviewPage extends StatefulWidget {
  const OverviewPage({Key? key}) : super(key: key);

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    QuerySnapshot queryBites = await FirebaseFirestore.instance
        .collection('products')
        .where('restaurant_id',
            isEqualTo: Get.find<GeneralController>().boxStorage.read('id'))
        .get();
    setState(() {
      totalBites = queryBites.docs.length;
    });
    QuerySnapshot queryOrders = await FirebaseFirestore.instance
        .collection('orders')
        .where('restaurant_id',
            isEqualTo: Get.find<GeneralController>().boxStorage.read('id'))
        .get();
    setState(() {
      totalOrders = queryOrders.docs.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => Row(
            children: [
              Container(
                // color: Colors.red,
                margin: EdgeInsets.only(
                  top: ResponsiveWidget.isSmallScreen(context) ? 56 : 40,
                ),
                child: Text(
                  menuController.activeItem.value,
                  style: TextStyle(
                      fontFamily: "Nunito",
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: active),
                ),
              ),
            ],
          ),
        ),
        Expanded(
            child: ListView(
          children: [
            if (ResponsiveWidget.isLargeScreen(context) ||
                ResponsiveWidget.isMediumScreen(context))
              if (ResponsiveWidget.isCustomSize(context))
                OverviewCardsMediumScreen()
              else
                OverviewCardsLargeScreen()
            else
              OverviewCardsSmallScreen(),
            if (!ResponsiveWidget.isSmallScreen(context))
              RevenueSectionLarge()
            else
              RevenueSectionSmall(),
            RecentOrder(),
          ],
        )),
      ],
    );
  }
}
