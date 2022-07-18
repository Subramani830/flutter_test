import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_session/flutter_session.dart';

class OrderDetailPage extends StatefulWidget {
  //const OrderDetailPage({Key? key}) : super(key: key);
  final String docName;
  const OrderDetailPage({Key? key, required this.docName}) : super(key: key);

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {


  String supplier = '';
  String trDate = '';
  String scDate = '';
  String totalQty = '';
  String grandTotal = '';
  List items = [];
  bool isLoading = false;

  @override
  void initState(){
    super.initState();
    fetchOrders();
  }

  fetchOrders() async{
    setState(() {
      isLoading = true;
    });
    print("fetch.......?"+widget.docName.toString());
    String basicAuth = "token 7c8964dcbfd0d56:71a57dff3e276c8";
    //request.headers.addAll(headers);
    var headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": basicAuth,
    };
    var url = 'http://192.168.83.177:8000/api/resource/Purchase Order/'+widget.docName.toString();
    var request = http.Request('GET', Uri.parse(url));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final apiRespStr = await response.stream.bytesToString();
      print(apiRespStr);
      var items = json.decode(apiRespStr)['data'];
      //print(items);
      setState(() {
        supplier = items['supplier'].toString();
        trDate = items['transaction_date'].toString();
        scDate = items['schedule_date'].toString();
        totalQty = items['total_qty'].toString();
        grandTotal = items['grand_total'].toString();
        items = items['items'];
        isLoading = false;
      });
      print(items[0]['item_code']);
    }else{
      setState(() {
        isLoading = false;
        //orders = [];
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/pages.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title:  Text(
                widget.docName.toString()
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(0.5),
            child: Column(
              children: <Widget>[
                Card(
                  elevation: 2,
                  color: Colors.blueGrey.withOpacity(0.4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(25),
                    child: Column(
                      children: [
                        Text(
                          "Supplier: "+supplier,
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          "Transaction Date: "+ trDate,
                            textAlign: TextAlign.left,
                        ),
                        Text(
                            "Schedule Date: "+ scDate
                        ),
                        Text(
                            "Total Qty: "+ totalQty
                        ),
                        Text(
                            "Grand Total: "+ grandTotal
                        )
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 2,
                  color: Colors.blueGrey.withOpacity(0.4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    //color: Colors.white,
                    padding: const EdgeInsets.all(20.0),
                    child: Table(
                      border: TableBorder.all(color: Colors.black),
                      children: [
                        TableRow(children: [
                          Text(' Item Code'),
                          Text(' Qty'),
                          Text(' Rate'),
                          Text(' Total Amt')
                        ]),
                        TableRow(children: [
                          Text('Cell 4'),
                          Text('Cell 5'),
                          Text('Cell 6'),
                          Text('Total ')
                        ]),
                        TableRow(children: [
                          Text('Cell 4'),
                          Text('Cell 5'),
                          Text('Cell 6'),
                          Text('Total ')
                        ])
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}


// class OrderDetailPage1 extends StatelessWidget {
//   final String docName;
//   const OrderDetailPage1({Key? key, required this.docName}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         image: DecorationImage(
//             image: AssetImage('assets/pages.png'), fit: BoxFit.cover),
//       ),
//       child: Scaffold(
//           backgroundColor: Colors.transparent,
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           title:  Text(
//             docName.toString()
//           ),
//         ),
//           body: Padding(
//             padding: const EdgeInsets.all(0.5),
//             child: Column(
//               children: const [
//                 Card(
//                   child: Text(
//                       "Supplier:  "
//                   ),
//                 ),
//                 // const Text(
//                 //   "Supplier    test"
//                 // ),
//               ],
//             ),
//           )
//       ),
//     );
//   }
// }
