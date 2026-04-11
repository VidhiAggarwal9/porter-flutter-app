import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../../widgets/product_card.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  bool isGrid = true;

  final List<Product> products = [
    Product(name: "Shoes", image: "https://picsum.photos/200", price: 1999),
    Product(name: "Watch", image: "https://picsum.photos/201", price: 2999),
    Product(name: "Bag", image: "https://picsum.photos/202", price: 1499),
    Product(
        name: "Headphones", image: "https://picsum.photos/203", price: 2499),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        actions: [
          IconButton(
            icon: Icon(isGrid ? Icons.list : Icons.grid_view),
            onPressed: () {
              setState(() {
                isGrid = !isGrid;
              });
            },
          )
        ],
      ),
      body: isGrid
          ? GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) =>
                  ProductCard(product: products[index]),
            )
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) => ListTile(
                leading: Image.network(products[index].image),
                title: Text(products[index].name),
                subtitle: Text("₹${products[index].price}"),
              ),
            ),
    );
  }
}
