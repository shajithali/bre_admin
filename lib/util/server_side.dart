import 'dart:convert';
import 'package:bre_admin/model/customer_model.dart';
import 'package:http/http.dart' as http;

class ServerSide {
  Future insertData(
      String bankName,
      String loanNumber,
      String customerName,
      String vehicleNumber,
      String model,
      String overDue,
      String phoneNumber) async {
    try {
      var result = await http
          .post("https://esportsgame.000webhostapp.com/crud/crud//insert.php", body: {
        "value": 'post',
        "bankName": bankName,
        "loanNumber": loanNumber,
        "customerName": customerName,
        "vehicleNumber": vehicleNumber,
        "model": model,
        "overDue": overDue,
        "phoneNumber": phoneNumber
      });
      var message = await jsonDecode(result.body.toString());
      print(message);
      if (message.toString() ==
          '{success: true, message: Data Inserted Successfully}') {
        return 'S';
      } else {
        return 'N';
      }
    } catch (e) {
      return print(e.toString());
    }
  }

  Future updateData(
      String id,
      String bankName,
      String loanNumber,
      String customerName,
      String vehicleNumber,
      String model,
      String overDue,
      String phoneNumber) async {
    print(id);
    try {
      var result = await http
          .post("https://esportsgame.000webhostapp.com/crud/crud/update.php", body: {
        "id": id,
        "bankName": bankName,
        "loanNumber": loanNumber,
        "customerName": customerName,
        "vehicleNumber": vehicleNumber,
        "model": model,
        "overDue": overDue,
        "phoneNumber": phoneNumber
      });
      var message = await jsonDecode(result.body.toString());
      //print(json.decode(result.body));
      print(message.toString());
      if (message.toString() ==
          '{success: true, message: Data Updated Successfully}') {
        return "S";
      } else {
        return "N";
      }
//      if (message.toString() ==
//          '{success:true,message:Data Updated Successfully}') {
//        print('ss');
//      } else {
//        print('n');
//      }
    } catch (e) {
      print(e.toString());

    }
  }

  Future<List<Customer>> fetchData() async {
    String url = "https://esportsgame.000webhostapp.com/crud/crud/fetch.php";
    final response = await http.get(url);
    //print(response.body);
    return customerFromJson(response.body);
  }

  Future<List<Customer>> fetchSearchData(String search) async {
    String url = "https://esportsgame.000webhostapp.com/crud/crud/search.php";
    final response = await http.post(url, body: {"vehicle_number": search});
    print(response.body);
    return customerFromJson(response.body);
  }

  Future deleteData(String id) async {
    try {
      String url = "https://esportsgame.000webhostapp.com/crud/crud/delete.php";
      var result = await http.post(url, body: {
        "id": id,
      });
      print(result.body);
      if (result.body.toString() == "Delete") {
        return "S";
      } else {
        return "N";
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
