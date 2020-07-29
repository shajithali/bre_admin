import 'package:flutter/material.dart';

class TextFieldLoan extends StatefulWidget {
  FormFieldValidator validator;
  String labelName;
  String hint;
  TextEditingController controller;
  FocusNode currentFocus;
  FocusNode nextFocus;
  TextInputType textInputType;

  TextFieldLoan(
      {this.labelName,
      this.hint,
      this.textInputType,
      this.controller,
      this.currentFocus,
      this.nextFocus});

  @override
  _TextFieldLoanState createState() => _TextFieldLoanState();
}

class _TextFieldLoanState extends State<TextFieldLoan> {
  fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 81,
      // margin: EdgeInsets.only(top: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 2, left: 30.0, right: 12.0),
            alignment: Alignment.centerLeft,
            child: Text(
              widget.labelName,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 14),
            ),
          ),
          Container(
            height: 58,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: ListTile(
                title: TextFormField(
                  keyboardType: widget.textInputType,
                  controller: widget.controller,
                  focusNode: widget.currentFocus,
                  enableSuggestions: false,
                  onSaved: (val) {
                    print('s');
                  },
                  onFieldSubmitted: (val) {
                    fieldFocusChange(
                        context, widget.currentFocus, widget.nextFocus);
                  },
                  decoration: InputDecoration(
                      hintText: widget.hint,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.greenAccent),
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
