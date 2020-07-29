import 'package:bre_admin/model/customer_model.dart';
import 'package:bre_admin/util/server_side.dart';
import 'package:flutter/material.dart';

import 'app_bar.dart';
import 'card.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController controller = new TextEditingController();
  final ServerSide serverSide = ServerSide();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: controller.text.length == 0
            ? null
            : Container(
                child: FutureBuilder<List<Customer>>(
                future: serverSide.fetchSearchData(controller.text.toString()),
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data.length == 0) {
                    return Center(child: Text('No Data Available'));
                  }
                  return ListView(
                    children: snapshot.data
                        .map((data) => CustomerCard(
                              id: data.id,
                              bankName: data.bankName,
                              overDue: data.overDue,
                              model: data.make,
                              vehicleNumber: data.vehicleNumber,
                              customerName: data.customerName,
                              loanNumber: data.loanNo,
                              phoneNumber: data.phoneNumber,
                            ))
                        .toList(),
                  );
                },
              )),
        appBar: PreferredSize(
            child: SearchAppBar(
              controller: controller,
              back: Icon(Icons.arrow_back),
            ),
            preferredSize: Size(MediaQuery.of(context).size.width, 65)),
      ),
    );
  }
}
