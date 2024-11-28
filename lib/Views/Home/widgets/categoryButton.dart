import 'package:flutter/material.dart';
import 'package:flutter_assignment/Controllers/productControllers.dart';
import 'package:get/get.dart';

import '../category page/categoricalPages.dart';

class CategoryButton extends StatelessWidget {
  String imageUrl;
  String title;
  CategoryButton({
    required this.imageUrl,
    required this.title,
    super.key,
  });

  final ProductControllers _productControllers = Get.put(ProductControllers());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (title == 'Clothes') {
          _productControllers.selectedCategory.value = title.capitalizeFirst!;
        } else if (title == 'Shoes') {
          _productControllers.selectedCategory.value = title.capitalizeFirst!;
        } else if (title == 'Electronics') {
          _productControllers.selectedCategory.value = title.capitalizeFirst!;
        } else if (title == 'Furniture') {
          _productControllers.selectedCategory.value = 'Change title';
        } else {
          _productControllers.selectedCategory.value = title.capitalizeFirst!;
        }
        Get.to(() => CategoricalPage());
      },
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
            style: const TextStyle(
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
