import 'dart:async';
import 'dart:convert';

import 'package:bre_admin/model/customer_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'card.dart';
import 'insert_screen.dart';

class HomeScreen extends StatefulWidget {
  final String toast;
  HomeScreen({this.toast});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController controller = new TextEditingController();
  bool search = false;
  bool load = false;
  bool alert = false;
  checkDialgog() async {
    if (widget.toast != null) {
      setState(() {
        alert = true;
      });
      Duration duration = Duration(seconds: 2);
      return new Timer(duration, reloadUi);
    } else {
      print('No');
      await getUserDetails();
    }
  }

  reloadUi() async {
    setState(() {
      alert = false;
    });
    await getUserDetails();
  }

  // Get json result and convert it to model. Then add
  Future<Null> getUserDetails() async {
    final response = await http.get(url);

    final responseJson = json.decode(response.body);
    print(responseJson.toString());
    setState(() {
      load = true;
      for (Map user in responseJson) {
//        checkToastValue();
        _userDetails.add(Customer.fromMap(user));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    //  checkToastValue();
    checkDialgog();
    // getUserDetails();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
//    setState(() {
//      getUserDetails();
//    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: new Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AddData(
                      index: 0,
                    )));
          },
          backgroundColor: Colors.orange.withOpacity(.7),
          child: Icon(
            Icons.add,
            color: Colors.blue[900],
            size: 40,
          ),
        ),
        appBar: search == false
            ? new AppBar(
                backgroundColor: Colors.deepOrange,
                title: new Text('BRE ADMIN'),
                elevation: 0.0,
                automaticallyImplyLeading: false,
                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                        onTap: () {
                          setState(() {
                            search = true;
                          });
                        },
                        child: Icon(Icons.search)),
                  ),
                ],
              )
            : null,
        body: alert == true
            ? Center(
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(15)),
                  child: Text(widget.toast),
                ),
              )
            : load == false
                ? Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : new Column(
                    children: <Widget>[
                      search == true
                          ? new Container(
                              //  color: Theme.of(context).primaryColor,
                              child: new Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                        flex: 1,
                                        child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                search = false;
                                              });
                                              controller.clear();

                                              onSearchTextChanged('');
                                            },
                                            child: Icon(Icons.arrow_back))),
                                    Flexible(
                                      flex: 6,
                                      child: new Card(
                                        elevation: 4,
                                        color: Colors.black12,
                                        child: new ListTile(
                                          leading: new Icon(Icons.search),
                                          title: new TextField(
                                            controller: controller,
                                            decoration: new InputDecoration(
                                                hintText: 'Search',
                                                border: InputBorder.none),
                                            onChanged: onSearchTextChanged,
                                          ),
                                          trailing: new IconButton(
                                            icon: new Icon(Icons.cancel),
                                            onPressed: () {
                                              controller.clear();
                                              onSearchTextChanged('');
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container(),
                      DataFetch(
                        data: controller.text.toString(),
                      )
                    ],
                  ),
      ),
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _userDetails.forEach((userDetail) {
      if (userDetail.vehicleNumber.contains(text) ||
          userDetail.customerName.contains(text)
          ||

          userDetail.bankName.contains(text)) _searchResult.add(userDetail);
    });

    setState(() {});
  }
}

List<Customer> _searchResult = [];

List<Customer> _userDetails = [];

final String url = 'https://esportsgame.000webhostapp.com/crud/crud/fetch.php';

class DataFetch extends StatefulWidget {
  String data;
  DataFetch({this.data});
  @override
  _DataFetchState createState() => _DataFetchState();
}

class _DataFetchState extends State<DataFetch> {
  Future<Null> getUserDetails() async {
    final response = await http.get(url);

    final responseJson = json.decode(response.body);
    print(responseJson.toString());
    setState(() {
      //  load = true;
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
    _userDetails.clear();
    _searchResult.clear();
    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return new Expanded(
      child: _searchResult.length != 0 || widget.data.isNotEmpty
          ? new ListView.builder(
              itemCount: _searchResult.length,
              itemBuilder: (context, i) {
                return new CustomerCard(
                  id: _searchResult[i].id,
                  customerName: _searchResult[i].customerName,
                  vehicleNumber: _searchResult[i].vehicleNumber,
                  phoneNumber: _searchResult[i].phoneNumber,
                  overDue: _searchResult[i].overDue,
                  bankName: _searchResult[i].bankName,
                  model: _searchResult[i].make,
                  loanNumber: _searchResult[i].loanNo,
                );
              },
            )
          : new ListView.builder(
              itemCount: _userDetails.length,
              itemBuilder: (context, index) {
                return new CustomerCard(
                  id: _userDetails[index].id,
                  customerName: _userDetails[index].customerName,
                  vehicleNumber: _userDetails[index].vehicleNumber,
                  phoneNumber: _userDetails[index].phoneNumber,
                  overDue: _userDetails[index].overDue,
                  bankName: _userDetails[index].bankName,
                  model: _userDetails[index].make,
                  loanNumber: _userDetails[index].loanNo,
                );
              },
            ),
    );
  }
}
