import 'dart:math';

import 'package:bre_admin/util/server_side.dart';
import 'package:flutter/material.dart';

class SearchAppBar extends StatefulWidget {
  TextEditingController controller;
  Widget back;
  SearchAppBar({this.controller, this.back});
  @override
  _SearchAppBarState createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  bool clearTextBox = false;
  final ServerSide serverSide = ServerSide();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      color: Color(0xFFffcef3),
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Center(
        child: TextFormField(
          controller: widget.controller,
          onChanged: (val) {
            setState(() {});
            if (val.length == 0) {
              clearTextBox = false;
            } else {
              clearTextBox = true;
            }
          },
          decoration: InputDecoration(
              hoverColor: Colors.red,
              focusColor: Colors.green,
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.red)),
              hintText: 'Search',
              labelText: 'Vehicle Number',
              suffixIcon: clearTextBox == false
                  ? widget.back
                  : GestureDetector(
                      onTap: () {
                        setState(() {});
                        clearTextBox = false;
                        widget.controller.text = '';
                      },
                      child: Icon(Icons.clear),
                    ),
              labelStyle: TextStyle(color: Color(0xffee5a5a)),
              prefixIcon: GestureDetector(
                child: Icon(Icons.search),
                onTap: () async {
                  await serverSide.fetchSearchData(widget.controller.text);
                },
              ),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(25))),
        ),
      ),
    );
  }
}
