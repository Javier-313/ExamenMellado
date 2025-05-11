import 'package:flutter/material.dart';

class Proveedor {
  String nombre;
  String contacto;
  Proveedor({required this.nombre, required this.contacto});
}

class ProveedorListScreen extends StatefulWidget {
  @override
  _ProveedorListScreenState createState() => _ProveedorListScreenState();
}

class _ProveedorListScreenState extends State<ProveedorListScreen> {
  List<Proveedor> proveedores = [
    Proveedor(nombre: 'Proveedor A', contacto: 'contacto@a.com'),
    Proveedor(nombre: 'Proveedor B', contacto: 'contacto@b.com'),
  ];

  void _eliminarProveedor(int index) {
    setState(() {
      proveedores.removeAt(index);
    });
  }

  void _editarProveedor(int index, Proveedor proveedorEditado) {
    setState(() {
      proveedores[index] = proveedorEditado;
    });
  }

  void _agregarProveedor(Proveedor nuevoProveedor) {
    setState(() {
      proveedores.add(nuevoProveedor);
    });
  }

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
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProveedorDetailScreen(
                    proveedor: proveedor,
                    onDelete: () => _eliminarProveedor(index),
                    onEdit: (editado) => _editarProveedor(index, editado),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final nuevo = await Navigator.push<Proveedor>(
            context,
            MaterialPageRoute(builder: (_) => ProveedorEditScreen()),
          );
          if (nuevo != null) _agregarProveedor(nuevo);
        },
      ),
    );
  }
}

class ProveedorDetailScreen extends StatelessWidget {
  final Proveedor proveedor;
  final VoidCallback onDelete;
  final Function(Proveedor) onEdit;

  ProveedorDetailScreen({required this.proveedor, required this.onDelete, required this.onEdit});

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
              onPressed: () async {
                final editado = await Navigator.push<Proveedor>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProveedorEditScreen(proveedor: proveedor),
                  ),
                );
                if (editado != null) {
                  onEdit(editado);
                  Navigator.pop(context);
                }
              },
            ),
            ElevatedButton(
              child: Text('Eliminar'),
              onPressed: () {
                onDelete();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProveedorEditScreen extends StatefulWidget {
  final Proveedor? proveedor;
  ProveedorEditScreen({this.proveedor});

  @override
  _ProveedorEditScreenState createState() => _ProveedorEditScreenState();
}

class _ProveedorEditScreenState extends State<ProveedorEditScreen> {
  late TextEditingController _nombreController;
  late TextEditingController _contactoController;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.proveedor?.nombre ?? '');
    _contactoController = TextEditingController(text: widget.proveedor?.contacto ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.proveedor == null ? 'Nuevo Proveedor' : 'Editar Proveedor')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _nombreController, decoration: InputDecoration(labelText: 'Nombre')),
            TextField(controller: _contactoController, decoration: InputDecoration(labelText: 'Contacto')),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Guardar'),
              onPressed: () {
                final nuevoProveedor = Proveedor(
                  nombre: _nombreController.text,
                  contacto: _contactoController.text,
                );
                Navigator.pop(context, nuevoProveedor);
              },
            ),
          ],
        ),
      ),
    );
  }
}