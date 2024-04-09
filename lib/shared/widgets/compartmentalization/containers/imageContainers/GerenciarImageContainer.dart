import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GerenciarImageContainer extends StatelessWidget {
  const GerenciarImageContainer(
      {super.key,
      required this.constraints,
      required this.imageUrl,
      });
  final BoxConstraints constraints;
  final String imageUrl;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      child: Image.asset(
        imageUrl,
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
