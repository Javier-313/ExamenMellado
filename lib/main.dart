import 'package:examen/screens/home_screen.dart';
import 'package:examen/screens/register_screen.dart';
import 'package:examen/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:examen/modelos/categoria.dart';
import 'package:examen/modelos/producto.dart';
//import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginScreen(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => MainApp(), 
      },
    );
  }
}
class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}
class _MainAppState extends State<MainApp> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    HomeScreen(),
    CategoriaListScreen(), 
    CategoriaListScreen(),
    ProductoListScreen(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(' Flutter')),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Proveedores'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Categorías'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Productos'),
        ],
      ),
    );
  }
}