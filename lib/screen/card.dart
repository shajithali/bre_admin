import 'package:flutter/material.dart';

import 'insert_screen.dart';

class CustomerCard extends StatefulWidget {
  final String id;
  final String customerName;
  final String loanNumber;
  final String phoneNumber;
  final String vehicleNumber;
  final String bankName;
  final String model;
  final String overDue;
  CustomerCard(
      {this.id,
      this.overDue,
      this.bankName,
      this.model,
      this.vehicleNumber,
      this.customerName,
      this.phoneNumber,
      this.loanNumber});
  @override
  _CustomerCardState createState() => _CustomerCardState();
}

class _CustomerCardState extends State<CustomerCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(widget.id);
      },
      onLongPress: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddData(
                  index: 1,
                  id: widget.id,
                  bankName: widget.bankName,
                  loanNumber: widget.loanNumber,
                  customerName: widget.customerName,
                  vehicleNumber: widget.vehicleNumber,
                  model: widget.model,
                  overDue: widget.overDue,
                  phoneNumber: widget.phoneNumber,
                )));
      },
      child: Container(
        //margin: EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Card(
            elevation: 5,
            color: Color(0xffa6acec),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  cardText('Customer Name', '${widget.customerName}'),
                  cardText('Loan Number', '${widget.loanNumber}'),
                  cardText('Contact Number', '${widget.phoneNumber}'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  cardText(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(label),
        Text(value),
      ],
    );
  }
}
