import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const urlLibros = "https://jritsqmet.github.io/web-api/libros.json";

class Listascreen extends StatelessWidget {
  const Listascreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listas'),
        centerTitle: true,
      ),
      body: librosList(urlLibros),
    );
  }
}

Future<List> fetchLibros(String url) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data['libros'];
  } else {
    throw Exception('Error al cargar datos de la API');
  }
}

Widget librosList(String url) {
  return FutureBuilder(
    future: fetchLibros(url),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (snapshot.hasData) {
        final libros = snapshot.data!;
        return ListView.builder(
          itemCount: libros.length,
          itemBuilder: (context, index) {
            final libro = libros[index];
            return ListTile(
              
              title: Text(libro['titulo']),
              subtitle: Text("Género: ${libro['género']}"),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(libro['titulo']),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 10),
                          Text("Género: ${libro['género']}"),
                          const SizedBox(height: 10),
                          Text("Descripción: ${libro['descripción']}"),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cerrar'),
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
        );
      } else {
        return const Center(
          child: Text('Error al cargar datos'),
        );
      }
    },
  );
}

