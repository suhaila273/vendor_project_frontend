import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:vendor_app/Models/category_model.dart';
import 'package:vendor_app/api_constants.dart';

class CategoryApiService
{
  Future<List<ViewCategory>> getCategory() async{
    var client=http.Client();
    var apiUrl=Uri.parse("${ApiConstants.baseUrl}/api/category/view_category");
    var response=await client.get(apiUrl);
    if(response.statusCode==200)
    {
      return viewCategoryFromJson(response.body);
    }
    else
    {
      return [];
    }
  }
}

