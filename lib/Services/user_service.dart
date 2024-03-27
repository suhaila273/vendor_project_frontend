import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vendor_app/Models/user_model.dart';


class VendorApiService
{
  Future<dynamic> VendorloginData(String email, String password) async {
    var client = http.Client();
    var apiUrl = Uri.parse("http://192.168.0.106:3001/api/vendor/login");

    var response = await client.post(apiUrl,
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
        body: jsonEncode(<String, String>{
          "email": email,
          "password": password,
        })
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    else {
      throw Exception("failed to login");
    }
  }

  Future<dynamic> addVendorApi(String email,String password,String companyName,String companyAddress,String personName,String contact) async
  {
    var client =http.Client();
    var apiUrl= Uri.parse("http://192.168.0.106:3001/api/vendor/signup");

    var response =await client.post(apiUrl,
        headers: <String,String>{
          "Content-Type" : "application/json; charset=UTF-8"
        },
        body: jsonEncode(<String,String>{
          "email": email,
          "password": password,
          "companyName": companyName,
          "companyAddress": companyAddress,
          "personName": personName,
          "contact": contact,
        })
    );
    if(response.statusCode==200)
    {
      return json.decode(response.body);
    }
    else
    {
      throw Exception("failed to register");
    }
  }


}