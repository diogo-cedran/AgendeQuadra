import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/court_list_screen.dart';
import 'screens/reservation_form_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AgendeQuadras',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: HomeScreen(),
      routes: {
        '/home': (ctx) => HomeScreen(),
        '/login': (ctx) => LoginScreen(),
        '/courts': (ctx) => CourtListScreen(),
        '/reservation-form': (ctx) => ReservationFormScreen(),
      },
    );
  }
}
