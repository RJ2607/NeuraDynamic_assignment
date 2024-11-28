import 'package:flutter/material.dart';
import 'package:flutter_assignment/Models/productModel.dart';
import 'package:flutter_assignment/Views/Product%20details/productPage.dart';
import 'package:get/get.dart';

import '../../../Controllers/productControllers.dart';

class ProductCard extends StatelessWidget {
  ProductCard({
    super.key,
    required this.product,
  });

  final ProductModel product;

  ProductControllers _productControllers = Get.put(ProductControllers());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _productControllers.selectedProduct.value = product;
        Get.to(() => ProductPage());
      },
      child: Container(
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.02),
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
        child: Row(
          children: [
            Container(
              height: double.infinity,
              width: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(product.images![0]),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          product.title!,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          product.description!,
                          softWrap: true,
                          maxLines: 3,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${product.price} \$',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
