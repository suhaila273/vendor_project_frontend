import 'dart:convert';

ResetPasswordModel resetPasswordModel(String str)=> ResetPasswordModel.fromJson(json.decode(str));

class ResetPasswordModel{
  ResetPasswordModel({
    required this.message,
    this.data,
  });

  late final String message;
  late final String? data;

  ResetPasswordModel.fromJson(Map<String,dynamic> json){
    message = json['message'];
    data=json['data'];
  }

  Map<String, dynamic>toJson() {
    final data = <String, dynamic>{};
    data["message"]=message;
    data["data"]=data;

    return data;
  }
}
