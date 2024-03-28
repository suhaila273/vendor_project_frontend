import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor_app/Models/productModel.dart';
import 'package:vendor_app/Services/product_service.dart';
import 'package:vendor_app/api_constants.dart';

class MyProductPage extends StatefulWidget {
  const MyProductPage({Key? key}) : super(key: key);

  @override
  State<MyProductPage> createState() => _MyProductPageState();
}

class _MyProductPageState extends State<MyProductPage> {
  late Future<List<Product>>? data;

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    if (userId != null) {
      setState(() {
        data = ProductApiService().getProductByVendor(userId);
      });
    } else {
      print("error");
    }
  }

  @override

  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.only(top: 40),
      child: FutureBuilder(
        future: data,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return GridView.builder(
              itemCount: snapshot.data!.length,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.6667,
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                List<String> imagePaths =
                snapshot.data![index].productImg.split(',');
                List<String> fullImagePaths = imagePaths
                    .map((path) => "${ApiConstants.baseUrl}/$path")
                    .toList();
                return InkWell(
                  onTap: () {},
                  child: Container(
                    height: 300,
                    width: 200,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          spreadRadius: 2,
                        )
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                snapshot.data![index].discount + "% off",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              //Icon(Icons.favorite,color: Colors.redAccent,)
                            ],
                          ),
                          SizedBox(height: 5),
                          if (fullImagePaths.isNotEmpty)
                            Image.network(
                              fullImagePaths.first,
                              height: 100,
                              width: 100,
                            ),
                          SizedBox(height: 5,),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(snapshot.data![index].productName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.black.withOpacity(0.8),
                                  ),
                                  textAlign: TextAlign.center,),
                                SizedBox(height: 5,),
                                Row(
                                  children: [
                                    Text(
                                      "₹"+snapshot.data![index].discountPrice,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.redAccent,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(width: 5,),
                                    Text(
                                      "₹"+snapshot.data![index].price,
                                      style: TextStyle(
                                          decoration: TextDecoration.lineThrough,
                                          fontSize: 13,
                                          color: Colors.black.withOpacity(0.4)
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),)
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Text("Loading");
          }
        },
      ),
    );
  }
}
