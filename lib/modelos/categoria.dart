import 'package:flutter/material.dart';

class CategoriaListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Categorías')),
      body: Center(child: Text('Categorías - Implementar vista similar a proveedores')),
    );
  }
}

// ---------------------- PRODUCTOS ----------------------
class ProductoListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Productos')),
      body: Center(child: Text('Productos - Implementar vista similar a proveedores')),
    );
  }
}
