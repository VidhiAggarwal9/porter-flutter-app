import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        children: [
          Expanded(
            child: Image.network(
              product.image,
              fit: BoxFit.cover,
            ),
          ),
          Text(product.name,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          Text("₹${product.price}")
        ],
      ),
    );
  }
}
