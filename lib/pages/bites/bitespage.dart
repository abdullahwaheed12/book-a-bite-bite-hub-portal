import 'package:bite_hub/pages/bites/widgets/clients_table.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../component/custom_text.dart';
import '../../constants/controller.dart';
import '../../constants/style.dart';
import '../../helpers/responsiveness.dart';

class BitesPage extends StatelessWidget {
  const BitesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => Row(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: ResponsiveWidget.isSmallScreen(context) ? 56 : 40,
                  ),
                  child: Text(
                     menuController.activeItem.value,
                    style: TextStyle(
                        fontFamily: "Nunito",
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: active
                    ),
                  ),
                ),
              ],
            )),
        Expanded(
          child: ListView(
            children: [
              BitesTable(),
            ],
          ),
        ),
      ],
    );
  }
}
