import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CadastrarImageContainer extends StatelessWidget {
  const CadastrarImageContainer({
    super.key,
    // required this.constraints,
    required this.imageController,
  });
  // final BoxConstraints constraints;
  final String? imageController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      child: Image.asset(
        imageController!,
        fit: BoxFit.fill,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            "assets/images/product_image_not_available.png",
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}
