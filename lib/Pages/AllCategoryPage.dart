import 'package:flutter/material.dart';
import 'package:vendor_app/Models/category_model.dart';
import 'package:vendor_app/Pages/CategoryProduct.dart';
import 'package:vendor_app/Services/category_service.dart';
import 'package:vendor_app/api_constants.dart';

class CategoryMenu extends StatefulWidget {
  const CategoryMenu({Key? key}) : super(key: key);

  @override
  State<CategoryMenu> createState() => _VendorMenuState();
}

class _VendorMenuState extends State<CategoryMenu> {
  Future<List<ViewCategory>>? data;

  @override
  void initState() {
    super.initState();
    data = CategoryApiService().getCategory();
  }
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new,size: 18,),
            onPressed: () {
             Navigator.pop(context);
            },
          ),
          title:
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'All Categories',
                style: TextStyle(color: Color(0xFF004225),fontWeight: FontWeight.bold,fontSize: 18),
              ),
            ],
          ),
          actions: [
            Icon(Icons.category, color: Color(0xFF004225)),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(height: 15),
                SizedBox(
                  child: FutureBuilder(
                    future: data,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        return GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 2, // Number of items per row
                          childAspectRatio: 0.8, // Aspect ratio of each item
                          mainAxisSpacing: 0, // Spacing between rows
                          crossAxisSpacing: 0, // Spacing between columns
                          children: List.generate(snapshot.data!.length, (index) {
                            String img_url = "${ApiConstants.baseUrl}/" +
                                snapshot.data![index].categoryIcon.toString();
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CategoryProduct(
                                      categoryId: snapshot.data![index].id,
                                      categoryName: snapshot.data![index].categoryName,
                                    ),
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        img_url,
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    snapshot.data![index].categoryName.toString(),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF004225),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        );
                      } else {
                        return Text("No data available");
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
