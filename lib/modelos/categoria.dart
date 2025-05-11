import 'package:flutter/material.dart';


class Categoria {
  String nombre;
  Categoria({required this.nombre});
}

class CategoriaListScreen extends StatefulWidget {
  @override
  _CategoriaListScreenState createState() => _CategoriaListScreenState();
}

class _CategoriaListScreenState extends State<CategoriaListScreen> {
  List<Categoria> categorias = [
    Categoria(nombre: 'Medicamentos'),
    Categoria(nombre: 'Suplementos'),
  ];

  void _eliminarCategoria(int index) {
    setState(() {
      categorias.removeAt(index);
    });
  }

  void _editarCategoria(int index, Categoria categoriaEditada) {
    setState(() {
      categorias[index] = categoriaEditada;
    });
  }

  void _agregarCategoria(Categoria nuevaCategoria) {
    setState(() {
      categorias.add(nuevaCategoria);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Categorías')),
      body: ListView.builder(
        itemCount: categorias.length,
        itemBuilder: (context, index) {
          final categoria = categorias[index];
          return ListTile(
            title: Text(categoria.nombre),
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CategoriaDetailScreen(
                    categoria: categoria,
                    onDelete: () => _eliminarCategoria(index),
                    onEdit: (editada) => _editarCategoria(index, editada),
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
          final nueva = await Navigator.push<Categoria>(
            context,
            MaterialPageRoute(builder: (_) => CategoriaEditScreen()),
          );
          if (nueva != null) _agregarCategoria(nueva);
        },
      ),
    );
  }
}

class CategoriaDetailScreen extends StatelessWidget {
  final Categoria categoria;
  final VoidCallback onDelete;
  final Function(Categoria) onEdit;

  CategoriaDetailScreen({required this.categoria, required this.onDelete, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalle de Categoría')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nombre: ${categoria.nombre}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Editar'),
              onPressed: () async {
                final editada = await Navigator.push<Categoria>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CategoriaEditScreen(categoria: categoria),
                  ),
                );
                if (editada != null) {
                  onEdit(editada);
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

class CategoriaEditScreen extends StatefulWidget {
  final Categoria? categoria;
  CategoriaEditScreen({this.categoria});

  @override
  _CategoriaEditScreenState createState() => _CategoriaEditScreenState();
}

class _CategoriaEditScreenState extends State<CategoriaEditScreen> {
  late TextEditingController _nombreController;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.categoria?.nombre ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.categoria == null ? 'Nueva Categoría' : 'Editar Categoría')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _nombreController, decoration: InputDecoration(labelText: 'Nombre')),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Guardar'),
              onPressed: () {
                final nuevaCategoria = Categoria(nombre: _nombreController.text);
                Navigator.pop(context, nuevaCategoria);
              },
            ),
          ],
        ),
      ),
    );
  }
}
