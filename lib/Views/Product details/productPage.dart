import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/Controllers/productControllers.dart';
import 'package:flutter_assignment/Models/productModel.dart';
import 'package:get/get.dart';

import 'widgets/dotIndicator.dart';

class ProductPage extends StatelessWidget {
  ProductPage({super.key});

  final ProductControllers _productControllers = Get.put(ProductControllers());

  final RxInt _cardIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    ProductModel selectedProduct = _productControllers.selectedProduct.value;
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedProduct.title!.capitalizeFirst!,
            style: const TextStyle(color: Colors.black, fontSize: 18)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                    items: List.generate(
                        selectedProduct.images!.length,
                        (i) => Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image:
                                      NetworkImage(selectedProduct.images![i]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )),
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height * 0.4,
                      viewportFraction: 0.97,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.35,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      initialPage: _cardIndex.value,
                      enableInfiniteScroll: false,
                      onPageChanged: (index, reason) {
                        _cardIndex.value = index;
                      },
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    selectedProduct.images!.length,
                    (index) => Obx(
                      () => DotIndicator(
                        isActive: index == _cardIndex.value,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Text(
                  '\$ ${selectedProduct.price}',
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(
                  color: Colors.black,
                ),
                const Text(
                  'Description',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Text(
                  selectedProduct.description!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.13,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: double.infinity,
                        width: MediaQuery.of(context).size.width * 0.3,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image:
                                NetworkImage(selectedProduct.category!.image!),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                selectedProduct.category!.name!,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
