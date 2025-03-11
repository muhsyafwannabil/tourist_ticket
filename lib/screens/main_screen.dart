import 'package:flutter/material.dart';
import 'package:tiket_wisata/screens/tickets_screen.dart';
import 'package:tiket_wisata/screens/profile_screen.dart';
import 'package:tiket_wisata/screens/order_page.dart'; // Import OrderPage

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; 

  final List<Widget> _pages = [
    OrderPage(), 
    TicketsScreen(),  // Halaman Tiket
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], 
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Order"),
          BottomNavigationBarItem(icon: Icon(Icons.airplane_ticket), label: "Tickets"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
