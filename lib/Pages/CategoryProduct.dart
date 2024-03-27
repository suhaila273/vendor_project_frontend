import 'package:flutter/material.dart';

class CategoryProduct extends StatefulWidget {
  final String categoryId;
  final String categoryName;

  const CategoryProduct({required this.categoryId, required this.categoryName,Key? key}) : super(key: key);


  @override
  State<CategoryProduct> createState() => _CategoryProductState();
}

class _CategoryProductState extends State<CategoryProduct> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Text("product is shown here"),
        ),
      ),
    );
  }
}
