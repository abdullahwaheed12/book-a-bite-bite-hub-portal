import 'package:bite_hub/controllers/general_controller.dart';
import 'package:bite_hub/pages/bites/widgets/biteDetails.dart';
import 'package:bite_hub/utils/global.dart';
import 'package:bite_hub/utils/responsive.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../component/custom_text.dart';
import '../../../constants.dart';
import '../../../constants/style.dart';
import 'biteBagDetails.dart';
import 'dart:convert';
import 'package:universal_html/html.dart' as html;
import 'package:csv/csv.dart';

/// Example without datasource

class Person {
  String orderid;
  String price;
  String menu;
  String dp;
  String bitehub;
  String quantity;
  Color color;
  Person(
      {required this.color,
      required this.orderid,
      required this.price,
      required this.quantity,
      required this.menu,
      required this.dp,
      required this.bitehub});
}

List<String> _buttonNames = [
  "All Status",
  "New Order",
  "On Progress",
  "Delivered"
];

int _currentSelectedButton = 0;
int _currentSelectedButton1 = 1;

class BiteBagTable extends StatefulWidget {
  @override
  State<BiteBagTable> createState() => _BiteBagTableState();
}

class _BiteBagTableState extends State<BiteBagTable> {
  List<String> _banner = [
    "Sr.",
    "Image",
    "Name",
    "BiteHub",
    "Price",
    "Discount",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 6),
              color: active.withOpacity(.1),
              blurRadius: 12)
        ],
        // border: Border.all(color: lightGrey, width: .5),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () async {
                  generateCSV();
                },
                child: Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                      color: customThemeColor,
                      borderRadius: BorderRadius.circular(50)),
                  child: Center(
                    child: Text(
                      'Export',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 60,
            color: Global.deepOrange,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    _banner.length,
                    (index) => index == 0
                        ? SizedBox(
                            width: 50,
                            child: Text(
                              _banner[index],
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        : Expanded(
                            child: Center(
                              child: Text(
                                _banner[index],
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                  )
                  //
                  ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('biteBags').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.docs.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Text(
                        'Record not found',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunito(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    );
                  } else {
                    return Wrap(
                      children:
                          List.generate(snapshot.data!.docs.length, (index) {
                        if (snapshot.data!.docs[index].get('restaurant_id') ==
                            Get.find<GeneralController>()
                                .boxStorage
                                .read('id')) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () async {
                                QuerySnapshot query = await FirebaseFirestore
                                    .instance
                                    .collection('restaurants')
                                    .where("id",
                                        isEqualTo: snapshot.data!.docs[index]
                                            .get('restaurant_id'))
                                    .get();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (builder) => BiteDetailsPage(
                                              productModel:
                                                  snapshot.data!.docs[index],
                                              restModel: query.docs[0],
                                            )));
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: SizedBox(
                                  height: 70,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      SizedBox(
                                        width: 50,
                                        child: Text(
                                          '${index + 1}',
                                          style:
                                              TextStyle(color: Colors.black54),
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Container(
                                            width: 60,
                                            height: 60,
                                            decoration: const BoxDecoration(
                                                color: Colors.grey,
                                                shape: BoxShape.circle),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                              child: Image.network(
                                                '${snapshot.data!.docs[index].get('image')}',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                'Bite Bag',
                                                style: TextStyle(
                                                    color: Colors.black54),
                                              ),
                                              Text(
                                                '${snapshot.data!.docs[index].get('id')}',
                                                style: TextStyle(
                                                    color: Colors.black54),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            '${snapshot.data!.docs[index].get('restaurant')}',
                                            style: TextStyle(
                                                color: Colors.black54),
                                          ),
                                        ),
                                      ),
                                      // Text(
                                      // _persons[index].name,
                                      // style: TextStyle(
                                      // color: Colors.black87,
                                      // fontWeight: FontWeight.w700
                                      // ),
                                      // ),
                                      Expanded(
                                        child: Center(
                                          child: Container(
                                            color: Colors.white,
                                            height: 15,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '${snapshot.data!.docs[index].get('dis_price')}',
                                                  style: TextStyle(
                                                      color: Colors.black54),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  'x${snapshot.data!.docs[index].get('quantity')}',
                                                  style: TextStyle(
                                                      color: Colors.black54),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),

                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            '${snapshot.data!.docs[index].get('discount')}%',
                                            style: TextStyle(
                                                color: Colors.black54),
                                          ),
                                        ),
                                      ),

                                      // IconButton(
                                      //     onPressed: () {},
                                      //     icon: Icon(
                                      //       Icons.more_horiz_outlined,
                                      //       color: Colors.black,
                                      //     )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return SizedBox();
                        }
                      }
                              //         ListTile(
                              //   leading: Text(
                              //     _persons[index].menu,
                              //     style: TextStyle(color: Colors.white),
                              //   ),
                              //   title: Text(
                              //     _persons[index].name,
                              //     style: TextStyle(color: Colors.white),
                              //   ),
                              //   trailing: Text(_persons[index].price)
                              // ),
                              ),
                    );
                  }
                } else {
                  return Text(
                    'Record not found',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  );
                }
              }),
        ],
      ),
    );
  }

  Future<void> generateCSV() async {
    // we will declare the list of headers that we want
    List<String> rowHeader = [
      "Sr.",
      "Name",
      "BiteHub",
      "quantity",
      "Discount",
    ];
    // here we will make a 2D array to handle a row
    List<List<dynamic>> rows = [];
    //First add entire row header into our first row
    rows.add(rowHeader);

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('biteBags').get();

    int? indexPrivate = 1;
    for (var element in querySnapshot.docs) {
      if (element.get('restaurant_id') ==
          Get.find<GeneralController>().boxStorage.read('id')) {
        List<dynamic> dataRow = [];
        dataRow.add('$indexPrivate');
        dataRow.add('Bite Bag');
        dataRow.add('${element.get('restaurant')}');
        dataRow.add('${element.get('dis_price')} x ${element.get('quantity')}');
        dataRow.add('${element.get('discount').toString()}%');
        //lastly add dataRow to our 2d list
        rows.add(dataRow);
        setState(() {
          indexPrivate = indexPrivate! + 1;
        });
      }
    }
    //now convert our 2d array into the csvlist using the plugin of csv
    String csv = const ListToCsvConverter().convert(rows);
    //this csv variable holds entire csv data
    //Now Convert or encode this csv string into utf8
    final bytes = utf8.encode(csv);
    //NOTE THAT HERE WE USED HTML PACKAGE
    final blob = html.Blob([bytes]);
    //It will create downloadable object
    final url = html.Url.createObjectUrlFromBlob(blob);
    //It will create anchor to download the file
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = 'biteBag.csv';
    //finally add the csv anchor to body
    html.document.body!.children.add(anchor);
    // Cause download by calling this function
    anchor.click();
    //revoke the object
    html.Url.revokeObjectUrl(url);
  }
}
