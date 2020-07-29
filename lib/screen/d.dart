import 'dart:convert';

import 'package:bre_admin/model/customer_model.dart';
import 'package:bre_admin/util/server_side.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'card.dart';

class D extends StatefulWidget {
  @override
  _DState createState() => _DState();
}

class _DState extends State<D> {
  final String url =
      'https://esportsgame.000webhostapp.com/crud/crud/search.php';
  List<Customer> _userDetails;
  var _s = Customer();
  var _server = ServerSide();

  // Get json result and convert it to model. Then add
  Future<Null> getUserdDetails() async {
    final response = await http.get(url);

    final responseJson = json.decode(response.body);
    print(responseJson.toString());
    setState(() {
      // load = true;
      for (Map user in responseJson) {
//        checkToastValue();
        _userDetails.add(Customer.fromMap(user));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: FutureBuilder(
          future: _server.fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, index) {
                  Customer customer = snapshot.data[index];
                  return new CustomerCard(
                    id: customer.id,
                    customerName: customer.customerName,
                    vehicleNumber: customer.vehicleNumber,
                    phoneNumber: customer.phoneNumber,
                    overDue: customer.overDue,
                    bankName: customer.bankName,
                    model: customer.make,
                    loanNumber: customer.loanNo,
                  );
                },
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
    ));
  }
}
