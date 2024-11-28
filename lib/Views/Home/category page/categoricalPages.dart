import 'package:flutter/material.dart';
import 'package:flutter_assignment/Controllers/productControllers.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../Models/productModel.dart';
import '../widgets/productCard.dart';

class CategoricalPage extends StatelessWidget {
  CategoricalPage({super.key});

  final ProductControllers _productControllers = Get.put(ProductControllers());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_productControllers.selectedCategory.value),
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: FutureBuilder(
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
                          bottom: MediaQuery.of(context).size.height * 0.02),
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
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      ProductModel product = snapshot.data![index];
                      if (product.category!.name ==
                          _productControllers.selectedCategory.value) {
                        return ProductCard(product: product);
                      }
                      return const SizedBox.shrink();
                    },
                  ));
                }
              }),
        )));
  }
}
