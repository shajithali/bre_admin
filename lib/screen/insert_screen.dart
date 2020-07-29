import 'package:bre_admin/util/server_side.dart';
import 'package:bre_admin/widget/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:toast/toast.dart';

import 'home_screen.dart';

class AddData extends StatefulWidget {
  final int index;
  final String id;
  final String customerName;
  final String loanNumber;
  final String phoneNumber;
  final String vehicleNumber;
  final String bankName;
  final String model;
  final String overDue;
  AddData(
      {this.id,
      this.index,
      this.overDue,
      this.bankName,
      this.model,
      this.vehicleNumber,
      this.customerName,
      this.phoneNumber,
      this.loanNumber});
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> with TickerProviderStateMixin {
  bool load = false;
  void confirm() {
    AlertDialog alertDialog = new AlertDialog(
      content: new Text("Are you sure want to delete '${widget.customerName}'"),
      actions: <Widget>[
        new RaisedButton(
          onPressed: () async {
            dynamic ss = await serverSide.deleteData(widget.id);
            print(ss.toString());
            if (ss.toString() == "S") {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => HomeScreen(
                        toast: 'Data Deleted Successfully',
                      )));
            } else {
              Navigator.pop(context);
            }
          },
          child: Text('DELETE'),
          color: Colors.red,
        ),
        new RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('CANCEL'),
          color: Colors.green,
        ),
      ],
    );
    showDialog(
      context: context,
      child: alertDialog,
    );
  }

  FocusNode bF = FocusNode();
  FocusNode cF = FocusNode();
  FocusNode lF = FocusNode();
  FocusNode vF = FocusNode();
  FocusNode mF = FocusNode();
  FocusNode pF = FocusNode();
  FocusNode oF = FocusNode();
  final ServerSide serverSide = ServerSide();
  TextEditingController bankName = TextEditingController();
  TextEditingController loanNumber = TextEditingController();
  TextEditingController customerName = TextEditingController();
  TextEditingController vehicyleNumber = TextEditingController();
  TextEditingController model = TextEditingController();
  TextEditingController overDue = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  String title;
  String id;
  String btnName;
  Color btnColor;
  double _scale;
  AnimationController _controller;

  @override
  void initState() {
    // TODO: implement
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
    if (widget.index == 0) {
      title = 'Add New Loan Details';
      btnName = 'ADD';
      btnColor = Colors.green;
      bankName.text = '';
      loanNumber.text = '';
      customerName.text = '';
      vehicyleNumber.text = '';
      model.text = '';
      overDue.text = '';
      phoneNumber.text = '';
    } else if (widget.index == 1) {
      title = "Update Loan Details";
      btnName = 'UPDATE';
      id = widget.id;
      btnColor = Colors.green;
      bankName.text = widget.bankName;
      loanNumber.text = widget.loanNumber;
      customerName.text = widget.customerName;
      vehicyleNumber.text = widget.vehicleNumber;
      model.text = widget.model;
      overDue.text = widget.overDue;
      phoneNumber.text = widget.phoneNumber;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;

    return Scaffold(
        appBar: widget.index != 0
            ? AppBar(
                title: Text(title),
                actions: <Widget>[
                  GestureDetector(
                    onTap: () {
                      confirm();
                      // serverSide.deleteData(widget.id);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  )
                ],
              )
            : AppBar(
                backgroundColor: Color(0xff1f4287),
                title: Text(title),
              ),
        body: Container(
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(25),
            image: DecorationImage(
              image: AssetImage('assets/images/pic.jpg'),
              colorFilter: ColorFilter.mode(
                  Colors.grey.withOpacity(0.6), BlendMode.color),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            children: <Widget>[
              Flexible(
                fit: FlexFit.tight,
                flex: 8,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(color: Colors.grey.withOpacity(0.7)),
                      ]),
                  margin: EdgeInsets.fromLTRB(8, 8, 6, 2),
                  child: Form(
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        SizedBox(
                          height: 6,
                        ),
                        TextFieldLoan(
                          labelName: "Bank Name",
                          controller: bankName,
                          textInputType: TextInputType.text,
                          currentFocus: bF,
                          nextFocus: cF,
                        ),
                        TextFieldLoan(
                          textInputType: TextInputType.text,
                          currentFocus: cF,
                          nextFocus: lF,
                          labelName: "Customer Name",
                          controller: customerName,
                        ),
                        TextFieldLoan(
                          textInputType: TextInputType.number,
                          currentFocus: lF,
                          nextFocus: vF,
                          labelName: "Loan Number",
                          controller: loanNumber,
                        ),
                        TextFieldLoan(
                          textInputType: TextInputType.text,
                          currentFocus: vF,
                          nextFocus: mF,
                          labelName: "Vehicle Number",
                          controller: vehicyleNumber,
                        ),
                        TextFieldLoan(
                          textInputType: TextInputType.text,
                          currentFocus: mF,
                          nextFocus: oF,
                          labelName: "Model Name",
                          controller: model,
                        ),
                        TextFieldLoan(
                          textInputType:
                              TextInputType.numberWithOptions(decimal: true),
                          currentFocus: oF,
                          nextFocus: pF,
                          labelName: "Over Due",
                          controller: overDue,
                        ),
                        TextFieldLoan(
                          textInputType: TextInputType.number, currentFocus: pF,
                          //  nextFocus: cF,
                          labelName: "Phone Number",
                          controller: phoneNumber,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(bottom: 13, top: 5),
                  child: GestureDetector(
                    onTapDown: _onTapDown,
                    onTapUp: _onTapUp,
                    child: Transform.scale(
                      scale: _scale,
                      child: _animatedButtonUI,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
//        Column(
//          // alignment: Alignment.bottomCenter,
//          children: <Widget>[
//            Container(
//              height: MediaQuery.of(context).size.height + 20,
//              //padding: EdgeInsets.only(top: 7),
//              child: Form(
//                child: ListView(
//                  children: <Widget>[
////                Padding(
////                  padding:
////                      const EdgeInsets.only(left: 2.0, right: 2.0, top: 5.0),
////                  child: TextFormField(
////                    controller: bankName,
////                    decoration: InputDecoration(
////                      hintText: 'Bank Name',
////                      labelText: 'Bank Name',
////                      border: OutlineInputBorder(
////                        borderRadius: BorderRadius.circular(35),
////                      ),
////                    ),
////                  ),
////                ),
//
//                    TextFieldLoan(
//                      labelName: 'Bank Name',
//                      hint: "",
//                      currentFocus: bF,
//                      nextFocus: lF,
//                      textInputType: TextInputType.text,
//                      controller: bankName,
//                    ),
//                    TextFieldLoan(
//                      currentFocus: lF,
//                      nextFocus: cF,
//                      textInputType: TextInputType.number,
//                      hint: "",
//                      labelName: "Loan Number",
//                      controller: loanNumber,
//                    ),
//                    TextFieldLoan(
//                      textInputType: TextInputType.text,
//                      labelName: 'Customer Name',
//                      controller: customerName,
//                    ),
//
//                    TextFieldLoan(
//                      textInputType: TextInputType.text,
//                      controller: vehicyleNumber,
//                      labelName: "vehicle Number",
//                    ),
//                    TextFieldLoan(
//                      textInputType: TextInputType.text,
//                      controller: model,
//                      labelName: 'Model Name',
//                    ),
//                    TextFieldLoan(
//                      textInputType: TextInputType.number,
//                      controller: overDue,
//                      labelName: "Over Due",
//                    ),
//                    TextFieldLoan(
//                      textInputType: TextInputType.phone,
//                      controller: phoneNumber,
//                      labelName: 'Phone Number',
//                    ),
//                  ],
//                ),
//              ),
//            ),
////            Container(
////              padding: EdgeInsets.only(left: 60, right: 60),
////              width: 55,
////              child: RaisedButton(
////                elevation: 5,
////                shape: StadiumBorder(),
////                color: Colors.greenAccent,
////                onPressed: () async {
////                  if (widget.index == 1) {
////                    await serverSide.updateData(
////                        widget.id,
////                        bankName.text.toString(),
////                        loanNumber.text.toString(),
////                        customerName.text.toString(),
////                        vehicyleNumber.text.toString(),
////                        model.text.toString(),
////                        overDue.text.toString(),
////                        phoneNumber.text.toString());
////                  } else if (widget.index == 0) {
////                    dynamic res = await serverSide.insertData(
////                        bankName.text.toString(),
////                        loanNumber.text.toString(),
////                        customerName.text.toString(),
////                        vehicyleNumber.text.toString(),
////                        model.text.toString(),
////                        overDue.text.toString(),
////                        phoneNumber.text.toString());
////
////                    print(res);
////                    if (res == 'S') {
////                      bankName.text = '';
////                      customerName.text = '';
////                      loanNumber.text = '';
////                      phoneNumber.text = '';
////                      model.text = '';
////                      overDue.text = '';
////                      vehicyleNumber.text = '';
//////                            await Fluttertoast.showToast(
//////                                msg: "This is Center Short Toast",
//////                                toastLength: Toast.LENGTH_SHORT,
//////                                gravity: ToastGravity.CENTER,
//////                                timeInSecForIosWeb: 1,
//////                                backgroundColor: Colors.red,
//////                                textColor: Colors.white,
//////                                fontSize: 16.0);
////
////                      Navigator.of(context).push(MaterialPageRoute(
////                          builder: (context) => HomeScreen(
////                                toast: 'Data Added Successfully',
////                              )));
////                    }
////                  }
////                },
////                child: Text(btnName),
////              ),
////            )
//            load == true
//                ? AlertDialog(
//                    title: Center(
//                      child: Container(
//                        height: 34,
//                        width: 30,
//                        child: CircularProgressIndicator(
//                          backgroundColor: Colors.red,
//                        ),
//                      ),
//                    ),
//                  )
//                : RaisedButton(
//                    color: btnColor,
//                    onPressed: () async {
//                      setState(() {
//                        load = true;
//                      });
//                      if (widget.index == 1) {
//                        print(id);
//                        dynamic ss = await serverSide.updateData(
//                            id,
//                            bankName.text.toString(),
//                            loanNumber.text.toString(),
//                            customerName.text.toString(),
//                            vehicyleNumber.text.toString(),
//                            model.text.toString(),
//                            overDue.text.toString(),
//                            phoneNumber.text.toString());
//                        setState(() {
//                          load = false;
//                        });
//                        print(ss);
//                        if (ss == "S") {
//                          Navigator.of(context).push(MaterialPageRoute(
//                              builder: (context) => HomeScreen(
//                                    toast: 'Data Update Successfully',
//                                  )));
//                        } else {
//                          Toast.show(
//                            'Data Update Failed',
//                            context,
//                            duration: Toast.LENGTH_SHORT,
//                            gravity: Toast.CENTER,
//                            backgroundColor: Colors.red,
//                          );
//                        }
//                      } else if (widget.index == 0) {
//                        dynamic res = await serverSide.insertData(
//                            bankName.text.toString(),
//                            loanNumber.text.toString(),
//                            customerName.text.toString(),
//                            vehicyleNumber.text.toString(),
//                            model.text.toString(),
//                            overDue.text.toString(),
//                            phoneNumber.text.toString());
//
//                        print(res);
//                        if (res == 'S') {
//                          bankName.text = '';
//                          customerName.text = '';
//                          loanNumber.text = '';
//                          phoneNumber.text = '';
//                          model.text = '';
//                          overDue.text = '';
//                          vehicyleNumber.text = '';
////                            await Fluttertoast.showToast(
////                                msg: "This is Center Short Toast",
////                                toastLength: Toast.LENGTH_SHORT,
////                                gravity: ToastGravity.CENTER,
////                                timeInSecForIosWeb: 1,
////                                backgroundColor: Colors.red,
////                                textColor: Colors.white,
////                                fontSize: 16.0);
//
//                          Navigator.of(context).push(MaterialPageRoute(
//                              builder: (context) => HomeScreen(
//                                    toast: 'Data Added Successfully',
//                                  )));
//                        }
//                      }
//                    },
//                    child: Text(btnName),
//                  ),
//          ],
//        ),);
  }

  Widget get _animatedButtonUI => Container(
        height: 70,
        width: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.0),
            boxShadow: [
              BoxShadow(
                color: Color(0x80000000),
                blurRadius: 30.0,
                offset: Offset(0.0, 5.0),
              ),
            ],
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF0000FF),
                Color(0xFFFF3500),
              ],
            )),
        child: Center(
          child: Text(
            btnName,
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
      );

  void _onTapDown(TapDownDetails details) async {
    _controller.forward();

    if (widget.index == 1) {
      dynamic ss = await serverSide.updateData(
          widget.id,
          bankName.text.toString(),
          loanNumber.text.toString(),
          customerName.text.toString(),
          vehicyleNumber.text.toString(),
          model.text.toString(),
          overDue.text.toString(),
          phoneNumber.text.toString());
      print(ss);
      if (ss == "S") {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => HomeScreen(
                  toast: 'Data Update Successfully',
                )));
      } else {
        Toast.show(
          'Data Update Failed',
          context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.CENTER,
          backgroundColor: Colors.red,
        );
      }
    } else if (widget.index == 0) {
      dynamic res = await serverSide.insertData(
          bankName.text.toString(),
          loanNumber.text.toString(),
          customerName.text.toString(),
          vehicyleNumber.text.toString(),
          model.text.toString(),
          overDue.text.toString(),
          phoneNumber.text.toString());

      print(res);
      if (res == 'S') {
        bankName.text = '';
        customerName.text = '';
        loanNumber.text = '';
        phoneNumber.text = '';
        model.text = '';
        overDue.text = '';
        vehicyleNumber.text = '';
//                            await Fluttertoast.showToast(
//                                msg: "This is Center Short Toast",
//                                toastLength: Toast.LENGTH_SHORT,
//                                gravity: ToastGravity.CENTER,
//                                timeInSecForIosWeb: 1,
//                                backgroundColor: Colors.red,
//                                textColor: Colors.white,
//                                fontSize: 16.0);

        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => HomeScreen(
                  toast: 'Data Added Successfully',
                )));
      } else {
        print('Error');
      }
    }
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }
}
