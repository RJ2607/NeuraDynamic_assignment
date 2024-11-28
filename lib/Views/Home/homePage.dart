import 'package:flutter/material.dart';
import 'package:flutter_assignment/Controllers/productControllers.dart';
import 'package:flutter_assignment/Models/productModel.dart';
import 'package:flutter_assignment/Views/Home/widgets/productCard.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ProductControllers _productControllers = Get.put(ProductControllers());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
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
              Text(
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
                        gradient: LinearGradient(
                          colors: [
                            Colors.white,
                            Colors.grey,
                            Colors.white,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
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

class CategoryButton extends StatelessWidget {
  String imageUrl;
  String title;
  CategoryButton({
    required this.imageUrl,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin:
            EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.02),
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width * 0.225,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
