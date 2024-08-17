import 'package:flutter/material.dart';
import 'package:projeto_flutter/models/candidato.dart';
import 'screens/candidato_screen.dart'; // Verifique se o caminho está correto

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Visualizador de Candidatos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CandidatoScreen(
          listaDeputados:
              getDeputados()), // Certifique-se de que esta classe está definida e importada corretamente
    );
  }
}
