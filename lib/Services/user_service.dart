import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vendor_app/Models/user_model.dart';
import 'package:vendor_app/api_constants.dart';

class VendorApiService
{
  Future<dynamic> VendorloginData(String email, String password) async {
    var client = http.Client();
    var apiUrl = Uri.parse("${ApiConstants.baseUrl}/api/vendor/login");

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
    var apiUrl= Uri.parse("${ApiConstants.baseUrl}/api/vendor/signup");

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