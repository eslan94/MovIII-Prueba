import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';


void main() {
  runApp(const MaterialApp(
    home: Recomendacionesscreen(),
  ));
}

class Recomendacionesscreen extends StatefulWidget {
  const Recomendacionesscreen({super.key});

  @override
  State<Recomendacionesscreen> createState() => _RecomendacionesscreenState();
}

class _RecomendacionesscreenState extends State<Recomendacionesscreen> {
  final DatabaseReference _database = FirebaseDatabase.instance.ref("recomendaciones");
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _libroController = TextEditingController();
  final TextEditingController _generoController = TextEditingController();

  void _guardarRecomendacion() {
    final id = _idController.text.trim();
    final libro = _libroController.text.trim();
    final genero = _generoController.text.trim();

    if (id.isNotEmpty && libro.isNotEmpty && genero.isNotEmpty) {
      _database.child(id).set({
        "libro": libro,
        "genero": genero,
      }).then((_) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Recomendación guardada con éxito')),
        );
        _idController.clear();
        _libroController.clear();
        _generoController.clear();
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al guardar: $error')),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, complete todos los campos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recomendaciones'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _idController,
              decoration: const InputDecoration(
                labelText: 'ID',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _libroController,
              decoration: const InputDecoration(
                labelText: 'Nombre del Libro',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _generoController,
              decoration: const InputDecoration(
                labelText: 'Género',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _guardarRecomendacion,
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}


