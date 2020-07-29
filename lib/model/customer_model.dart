// To parse this JSON data, do
//
//     final customer = customerFromJson(jsonString);
import 'package:http/http.dart' as http;
import 'dart:convert';

List<Customer> customerFromJson(String str) =>
    List<Customer>.from(json.decode(str).map((x) => Customer.fromMap(x)));

String customerToJson(List<Customer> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Customer {
  String id;
  String bankName;
  String loanNo;
  String customerName;
  String vehicleNumber;
  String make;
  String overDue;
  String phoneNumber;

  Customer({
    this.id,
    this.bankName,
    this.loanNo,
    this.customerName,
    this.vehicleNumber,
    this.make,
    this.overDue,
    this.phoneNumber,
  });
  final String url =
      'https://esportsgame.000webhostapp.com/crud/crud/search.php';
  List<Customer> _userDetails;

  Future<Null> getUserDetails() async {
    final response = await http.get(url);

    final responseJson = json.decode(response.body);
    print(responseJson.toString());

    // load = true;
    for (Map user in responseJson) {
//        checkToastValue();
      _userDetails.add(Customer.fromMap(user));
    }
  }

  factory Customer.fromMap(Map<String, dynamic> json) => Customer(
        id: json["id"],
        bankName: json["bank_name"],
        loanNo: json["loan_no"],
        customerName: json["customer_name"],
        vehicleNumber: json["vehicle_number"],
        make: json["make"],
        overDue: json["over_due"],
        phoneNumber: json["phone_number"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "bank_name": bankName,
        "loan_no": loanNo,
        "customer_name": customerName,
        "vehicle_number": vehicleNumber,
        "make": make,
        "over_due": overDue,
        "phone_number": phoneNumber,
      };
}
