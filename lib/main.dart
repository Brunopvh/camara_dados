import 'package:flutter/material.dart';
import 'package:projeto_flutter/models/candidato.dart';
import 'package:projeto_flutter/dados/candidatos_dados.dart';
import 'screens/candidato_screen.dart'; // Verifique se o caminho está correto
import 'package:projeto_flutter/dados/proposicoes_api.dart';

void main() {
  startApi();
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
      home: CandidatoScreen(listaDeputados: deputados));
  }
}
