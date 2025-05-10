import 'package:flutter/material.dart';

class Proveedor {
  String nombre;
  String contacto;
  Proveedor({required this.nombre, required this.contacto});
}

class ProveedorListScreen extends StatelessWidget {
  final List<Proveedor> proveedores = [
    Proveedor(nombre: 'Proveedor A', contacto: 'contacto@a.com'),
    Proveedor(nombre: 'Proveedor B', contacto: 'contacto@b.com'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Proveedores')),
      body: ListView.builder(
        itemCount: proveedores.length,
        itemBuilder: (context, index) {
          final proveedor = proveedores[index];
          return ListTile(
            title: Text(proveedor.nombre),
            subtitle: Text(proveedor.contacto),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProveedorDetailScreen(proveedor: proveedor))),
          );
        },
      ),
    );
  }
}

class ProveedorDetailScreen extends StatelessWidget {
  final Proveedor proveedor;
  ProveedorDetailScreen({required this.proveedor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalle del Proveedor')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nombre: ${proveedor.nombre}', style: TextStyle(fontSize: 18)),
            Text('Contacto: ${proveedor.contacto}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Editar'),
              onPressed: () {}, // A implementar
            ),
            ElevatedButton(
              child: Text('Eliminar'),
              onPressed: () {}, // A implementar
            ),
          ],
        ),
      ),
    );
  }
}
