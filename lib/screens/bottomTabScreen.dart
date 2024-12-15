import 'package:eval2/screens/listaScreen.dart';
import 'package:eval2/screens/recomendacionesScreen.dart';
import 'package:flutter/material.dart';

class Bottomtabscreen extends StatefulWidget {
  const Bottomtabscreen({super.key});

  @override
  State<Bottomtabscreen> createState() => _BottomtabscreenState();
}

class _BottomtabscreenState extends State<Bottomtabscreen> {
  int currentIndex = 0;

  final List<Widget> paginas = [Listascreen(), Recomendacionesscreen(),];

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: paginas[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Listas",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb),
            label: "Recomendaciones",
          ),
        ],
      ),
    );
  }
}
