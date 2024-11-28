import 'package:flutter/material.dart';
import 'package:flutter_assignment/Controllers/productControllers.dart';
import 'package:flutter_assignment/Models/productModel.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ProductControllers _productControllers = Get.put(ProductControllers());

  // late List<ProductModel> products;

  // @override
  // void initState() {
  //   super.initState();
  //   _productControllers.fetchProducts().then((value) {
  //     if (value != null) {
  //       setState(() {
  //         products = value;
  //       });
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: FutureBuilder(
          future: _productControllers.fetchProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  ProductModel product = snapshot.data![index];
                  return ListTile(
                    title: Text(product.title!),
                    subtitle: Text(product.description!),
                    trailing: Text(product.price.toString()),
                  );
                },
              );
            }
          }),
    );
  }
}
