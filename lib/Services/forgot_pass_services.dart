import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vendor_app/Models/forgot_pass_model.dart';
import 'package:vendor_app/api_constants.dart';

class ResetPasswordApiService{
  Future<ResetPasswordModel> otpLogin(String email) async{
    var client=http.Client();
    var apiUrl=Uri.parse("${ApiConstants.baseUrl}/api/vendor/otp-reset-password");
    var response=await client.post(apiUrl,
        headers: {
          "Content-Type":"application/json; charset=UTF-8"
        },
        body: jsonEncode(
            {
              "email":email
            }));
    if(response.statusCode==200)
    {
      return resetPasswordModel(response.body);
    }
    if(response.statusCode==404)
    {
      return resetPasswordModel(response.body);
    }
    else
    {
      throw Exception("Failed");
    }

  }

  Future<ResetPasswordModel> verifyOtp(String email, String otpHash,String otpCode)async{
    var client=http.Client();
    var apiUrl=Uri.parse("${ApiConstants.baseUrl}/api/vendor/otp-verify");
    var response=await client.post(apiUrl,
        headers:
        {
          "Content-Type":"application/json ; charset=UTF-8"
        },
        body: jsonEncode(
            {
              "email": email,
              "otp": otpCode,
              "hash": otpHash
            }));
    if(response.statusCode==200)
    {
      return resetPasswordModel(response.body);
    }
    else
    {
      throw Exception("Failed");
    }

  }

  Future<dynamic> changePassword(String email,String password) async{
    var client=http.Client();
    var apiUrl=Uri.parse("${ApiConstants.baseUrl}/api/vendor/change_password");
    var response=await client.post(apiUrl,
        headers: <String,String>{
          "Content-Type":"application/json ; charset=UTF-8"
        },
        body: jsonEncode(<String,String>{
          "email":email,
          "password":password
        }));
    if(response.statusCode==200)
    {
      return jsonDecode(response.body);
    }
    else
    {
      throw Exception("Failed");
    }
  }
}