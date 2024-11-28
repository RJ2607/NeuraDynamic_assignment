import 'package:flutter/material.dart';

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    this.isActive = false,
    super.key,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      duration: const Duration(milliseconds: 300),
      height: MediaQuery.of(context).size.height * 0.01,
      width: isActive ? MediaQuery.of(context).size.width * 0.05 : 10,
      decoration: BoxDecoration(
          color: isActive ? Colors.black : Colors.white,
          // border: Border.all(color: Colors.white, width: 1.5),
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
          border: Border.all(
            color: isActive ? Colors.white : Colors.black,
          )),
    );
  }
}
