import 'package:flutter/material.dart';
import 'package:flutter_assignment/Controllers/productControllers.dart';
import 'package:flutter_assignment/Models/productModel.dart';
import 'package:flutter_assignment/Views/Home/widgets/category_button.dart';
import 'package:flutter_assignment/Views/Home/widgets/productCard.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProductControllers _productControllers = Get.put(ProductControllers());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Categories',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CategoryButton(
                      imageUrl: 'https://i.imgur.com/QkIa5tT.jpeg',
                      title: 'Clothes',
                    ),
                    CategoryButton(
                        imageUrl: 'https://i.imgur.com/qNOjJje.jpeg',
                        title: 'Shoes'),
                    CategoryButton(
                      imageUrl: 'https://i.imgur.com/ZANVnHE.jpeg',
                      title: 'Electronics',
                    ),
                    CategoryButton(
                        imageUrl: 'https://i.imgur.com/Qphac99.jpeg',
                        title: 'Furniture'),
                    CategoryButton(
                        imageUrl: 'https://i.imgur.com/BG8J0Fj.jpg',
                        title: 'Miscellaneous'),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              const Text(
                'Recent Products',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              FutureBuilder(
                  future: _productControllers.fetchProducts(),
                  builder: (context, snapshot) {
                    if (_productControllers.isLoading.value) {
                      return Shimmer(
                        gradient: const LinearGradient(
                          colors: [
                            Colors.white,
                            Colors.grey,
                            Colors.white,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        child: Container(
                          margin: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).size.height * 0.02),
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      return Expanded(
                          child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          ProductModel product = snapshot.data![index];
                          return ProductCard(product: product);
                        },
                      ));
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
