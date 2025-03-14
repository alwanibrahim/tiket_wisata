import 'package:flutter/material.dart';
import 'package:tiket_wisata/constants/colors.dart';
import 'package:tiket_wisata/screens/order/order_screen.dart';
import 'package:tiket_wisata/screens/order/tiket_page.dart';
import 'package:tiket_wisata/screens/profile_screen.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:tiket_wisata/components/button_mainlayout.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    OrderPage(),
    TicketPage(),
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
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xff6200ee),
        unselectedItemColor: const Color(0xff757575),
        onTap: _onItemTapped,
        items: [
          buttonMainlayout(
              icon: Icon(Icons.home), teks: 'Home', color: AppColors.secondary),
          buttonMainlayout(
              icon: Icon(Icons.confirmation_num), teks: 'tiket', color: AppColors.secondary),
          buttonMainlayout(
              icon: Icon(Icons.person), teks: 'Profile', color: AppColors.secondary),
        ],
      ),
    );
  }
}
