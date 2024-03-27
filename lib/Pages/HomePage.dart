import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vendor_app/Models/category_model.dart';
import 'package:vendor_app/Pages/CategoryProduct.dart';
import 'package:vendor_app/Services/category_service.dart';

class ProductHomePage extends StatefulWidget {
  const ProductHomePage({Key? key}) : super(key: key);

  @override
  State<ProductHomePage> createState() => _ProductHomePageState();
}

class _ProductHomePageState extends State<ProductHomePage> {
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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.person,
                    color: Colors.orangeAccent,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "John Doe", //change this
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              CircleAvatar(
                child: SvgPicture.asset(
                  'assets/villageZone.svg',
                  width: 40,  // Adjust width and height as needed
                  height: 40,
                  fit: BoxFit.contain, // Adjust fit as needed
                ),
                radius: 20,
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  width: 500,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search here',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Categories",
                        style: TextStyle(fontSize: 15, color: Color(0xFF004225),fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // Code to move to another page horizontally
                        // You can use PageView, PageController, or any other method here
                      },
                      icon: Icon(Icons.arrow_forward_ios_rounded),
                      color: Color(0xFF004225),
                    ),
                    SizedBox(width: 10), // Adjust the space between text and icon as needed
                  ],
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 150,
                  child: FutureBuilder(
                    future: data,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            String img_url = "http://192.168.0.106:3001/" +
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
                              child: Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10), // Adjust the radius to match the container
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
                                      maxLines: 2, // Adjust the number of lines as needed
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF004225),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return Text("No data available");
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                //GridViewHome(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
