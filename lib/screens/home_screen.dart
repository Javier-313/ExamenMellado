import 'package:examen/modelos/categoria.dart';
import 'package:examen/modelos/producto.dart';
import 'package:examen/modelos/proveedor.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inicio')),
      body: ListView(
        children: [
          ListTile(
            title: Text('Proveedores'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProveedorListScreen())),
          ),
          ListTile(
            title: Text('Categorías'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CategoriaListScreen())),
          ),
          ListTile(
            title: Text('Productos'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductoListScreen())),
          ),
        ],
      ),
    );
  }
}