import 'package:http/http.dart' as http;
import 'package:vendor_app/Models/productModel.dart';
import 'package:vendor_app/api_constants.dart';

class ProductApiService{
  Future<List<Product>> getProduct() async{
    var client=http.Client();
    var apiUrl=Uri.parse("${ApiConstants.baseUrl}/api/product/viewproduct");
    var response=await client.get(apiUrl);
    if(response.statusCode==200)
    {
      return productFromJson(response.body);
    }
    else
    {
      return [];
    }
  }

  //to display products by vendor
  Future<List<Product>> getProductByVendor(String vendorId) async {
    var apiUrl = Uri.parse("${ApiConstants.baseUrl}/api/display/products_by_vendor/$vendorId");
    var response = await http.get(apiUrl);

    if (response.statusCode == 200) {
      return productFromJson(response.body);
    } else {
      // Handle error here if needed
      return [];
    }
  }

  //to display products by vendor within each category
  Future<List<Product>> getProductByVendorAndCategory(String vendorId, String categoryId) async {
    var apiUrl = Uri.parse("${ApiConstants.baseUrl}/api/display/products_by_vendor_category/$vendorId/$categoryId");
    var response = await http.get(apiUrl);
    if(response.statusCode == 200) {
      return productFromJson(response.body);
    } else {
      return [];
    }
  }

}