import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isGrid = true;
  String username = "User";

  final List<Map<String, dynamic>> products = [
    {"name": "Shoes", "price": 1999, "image": "https://picsum.photos/200"},
    {"name": "Watch", "price": 2999, "image": "https://picsum.photos/201"},
    {"name": "Bag", "price": 1499, "image": "https://picsum.photos/202"},
    {"name": "Headphones", "price": 2499, "image": "https://picsum.photos/203"},
  ];

  // LOAD USERNAME FROM STORAGE
  void loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      username = prefs.getString("username") ?? "User";
    });
  }

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  // LOGOUT FUNCTION
  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove("username");

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome $username"),
        actions: [
          IconButton(
            icon: Icon(isGrid ? Icons.list : Icons.grid_view),
            onPressed: () {
              setState(() {
                isGrid = !isGrid;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: logout,
          ),
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
              itemBuilder: (context, index) {
                final product = products[index];

                return Card(
                  elevation: 4,
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.network(
                          product["image"],
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        product["name"],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("₹${product["price"]}")
                    ],
                  ),
                );
              },
            )
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];

                return ListTile(
                  leading: Image.network(product["image"]),
                  title: Text(product["name"]),
                  subtitle: Text("₹${product["price"]}"),
                );
              },
            ),
    );
  }
}
