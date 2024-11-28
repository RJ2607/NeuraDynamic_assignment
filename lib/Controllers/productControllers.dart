import 'dart:convert';
import 'dart:developer';

import 'package:flutter_assignment/Models/productModel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProductControllers extends GetxController {
  final String baseUrl = 'api.escuelajs.co';
  final String endPoint = '/api/v1/products';

  RxBool isLoading = true.obs;

  Rx<ProductModel> selectedProduct = ProductModel().obs;

  RxString selectedCategory = 'clothes'.obs;

  Future<List<ProductModel>> fetchProducts() async {
    try {
      isLoading.value = true;

      //Uri contains the URL and the endpoint
      Uri url = Uri.https(baseUrl, endPoint);
      final http.Response response = await http.get(url);
      log('success');
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        List<ProductModel> products = jsonResponse
            .map((product) => ProductModel.fromJson(product))
            .toList();
        isLoading.value = false;
        return products;
      } else {
        isLoading.value = false;
        Get.snackbar(
          'Error',
          'Failed to load products. Status code: ${response.statusCode}',
          snackPosition: SnackPosition.BOTTOM,
        );
        return [];
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      return [];
    }
  }
}
