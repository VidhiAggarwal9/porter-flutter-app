import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../auth/login_screen.dart';
import '../location/location_screen.dart';
import '../chat/chat_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool isGrid = true;
  int selectedIndex = 0;
  String username = "User";

  final List<Map<String, dynamic>> products = [
    {"name": "Shoes", "price": 1999, "image": "https://tse1.mm.bing.net/th/id/OIP.HTPCXU0TOFrfyfqdBkHXsAHaFE?pid=Api&P=0&h=220"},
    {"name": "Watch", "price": 2999,"image": "https://tse1.mm.bing.net/th/id/OIP.ymfvmaIms_ZNSik_DlW1HgHaE7?pid=Api&P=0&h=220"},
    {"name": "Bag", "price": 1499, "image":"https://tse3.mm.bing.net/th/id/OIP.ZAeRCyTThkDiQWgxAVU-NgHaDt?pid=Api&P=0&h=220"},
    {"name": "Headphones", "price": 2499, "image": "https://tse1.mm.bing.net/th/id/OIP.B79IT46S2eBK_hHYqmoDtAHaId?pid=Api&P=0&h=220"},
  ];

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

      // Floating Chat Button
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: const Icon(Icons.chat),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const ChatScreen(),
            ),
          );
        },
      ),

      // Modern Gradient AppBar
      appBar: AppBar(
        title: Text("Welcome $username"),

        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
            ),
          ),
        ),

        actions: [

          IconButton(
            icon: const Icon(Icons.location_on),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const LocationScreen(),
                ),
              );
            },
          ),

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
        padding: const EdgeInsets.all(12),
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {

          final product = products[index];

          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 6,

            child: Column(
              children: [

                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(15)),
                    child: Image.network(
                      product["image"],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  product["name"],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                Text(
                  "₹${product["price"]}",
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5)
              ],
            ),
          );
        },
      )

          : ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {

          final product = products[index];

          return Card(
            margin: const EdgeInsets.all(8),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),

            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(product["image"]),
              ),
              title: Text(product["name"]),
              subtitle: Text("₹${product["price"]}"),
            ),
          );
        },
      ),

      // Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },

        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: "Location",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}