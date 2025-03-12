import 'package:flutter/material.dart';
import 'package:tiket_wisata/main_layout.dart';
import 'package:tiket_wisata/screens/home_screen.dart';
import 'package:tiket_wisata/screens/Auth/register_screen.dart';
import 'package:tiket_wisata/screens/order/tiket_page.dart';
import 'package:tiket_wisata/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      initialRoute: '/',
      routes: {
        '/register':(context)=> RegisterScreen(),
        'home':(context)=> HomeScreen(),
        '/main':(context)=> MainLayout(),
        '/ticket': (context) => TicketPage(),
      },
    );
  }
}


