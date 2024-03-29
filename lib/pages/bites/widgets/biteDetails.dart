import 'package:bite_hub/constants/controller.dart';
import 'package:bite_hub/constants/style.dart';
import 'package:bite_hub/helpers/responsiveness.dart';
import 'package:bite_hub/utils/responsive.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class Status {
  String name;
  String orderid;
  String date;
  String price;
  String customer;
  Color color;
  Status(
      {required this.name,
      required this.color,
      required this.orderid,
      required this.date,
      required this.price,
      required this.customer});
}

class BiteDetailsPage extends StatefulWidget {
  const BiteDetailsPage({Key? key, this.productModel, this.restModel})
      : super(key: key);

  final DocumentSnapshot? productModel;
  final DocumentSnapshot? restModel;
  @override
  State<BiteDetailsPage> createState() => _BiteDetailsPageState();
}

class _BiteDetailsPageState extends State<BiteDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
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
                    color: active),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 30, 0),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: customThemeColor),
                  child: const Center(
                    child: Text(
                      'Back',
                      style: TextStyle(
                          fontFamily: "Nunito",
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            )
          ],
        )),
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: ResponsiveWidget.isSmallScreen(context) ? 56 : 40,
              ),
              child: Text(
                "Details",
                style: TextStyle(
                    fontFamily: "Nunito",
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: active),
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView(
            children: [
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 500,
                        // height: 550,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          // border: Border.all(color: active.withOpacity(.4), width: .5),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 6),
                                color: active.withOpacity(.1),
                                blurRadius: 12)
                          ],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: Text(
                                    'Bite',
                                    style: TextStyle(
                                        fontFamily: "Nunito",
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: active),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: 300,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            offset: Offset(0, 6),
                                            color: active.withOpacity(.1),
                                            blurRadius: 4)
                                      ],
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        '${widget.productModel!.get('image')}',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Center(
                                  child: Text(
                                    '${widget.productModel!.get('name')}',
                                    style: TextStyle(
                                        fontFamily: "Nunito",
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black45),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: active,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          boxShadow: [
                                            BoxShadow(
                                                color: active.withOpacity(0.3))
                                          ]),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          '\$${widget.productModel!.get('dis_price')}',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: active,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            '0',
                                            style: TextStyle(
                                                fontFamily: "Nunito",
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black45),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Column(
                                  children: [
                                    widget.productModel!
                                                .get('name')
                                                .toString() !=
                                            ''
                                        ? SizedBox()
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20.0),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'Bag Items',
                                                      style: TextStyle(
                                                          fontFamily: "Nunito",
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Colors.black54),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '${widget.productModel!.get('items')}',
                                                      style: TextStyle(
                                                          fontFamily: "Nunito",
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Colors.black38),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Category',
                                            style: TextStyle(
                                                fontFamily: "Nunito",
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black54),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: List.generate(
                                            widget.productModel!
                                                .get('category')
                                                .length, (i) {
                                          return Padding(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Text(
                                              '${widget.productModel!.get('category')[i]},',
                                              style: TextStyle(
                                                  fontFamily: "Nunito",
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black38),
                                            ),
                                          );
                                        })),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Chefs Note',
                                            style: TextStyle(
                                                fontFamily: "Nunito",
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black54),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${widget.productModel!.get('chef_note')}',
                                            style: TextStyle(
                                                fontFamily: "Nunito",
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black38),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: Column(
                          children: [
                            Container(
                              width: 500,
                              // height: 530,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                // border: Border.all(color: active.withOpacity(.4), width: .5),
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 6),
                                      color: active.withOpacity(.1),
                                      blurRadius: 12)
                                ],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Center(
                                      child: Text(
                                        'Bite Hub',
                                        style: TextStyle(
                                            fontFamily: "Nunito",
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: active),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Name",
                                          style: TextStyle(
                                              fontFamily: "Nunito",
                                              fontSize: 17,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.grey),
                                        ),
                                        SelectableText(
                                          "${widget.restModel!.get('name')}",
                                          style: TextStyle(
                                              fontFamily: "Nunito",
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: active),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Phone No.",
                                          style: TextStyle(
                                              fontFamily: "Nunito",
                                              fontSize: 17,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.grey),
                                        ),
                                        SelectableText(
                                          "${widget.restModel!.get('phone')}",
                                          style: TextStyle(
                                              fontFamily: "Nunito",
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: active),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Website",
                                          style: TextStyle(
                                              fontFamily: "Nunito",
                                              fontSize: 17,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.grey),
                                        ),
                                        SelectableText(
                                          "${widget.restModel!.get('website_address')}",
                                          style: TextStyle(
                                              fontFamily: "Nunito",
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: active),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Address",
                                          style: TextStyle(
                                              fontFamily: "Nunito",
                                              fontSize: 17,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.grey),
                                        ),
                                        Expanded(
                                          child: SelectableText(
                                            "${widget.restModel!.get('address')}",
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                                fontFamily: "Nunito",
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: active),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              )

              // OrderWidget(),
            ],
          ),
        ),
      ],
    );
  }
}
