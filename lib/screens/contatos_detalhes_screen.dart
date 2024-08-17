// lib/screens/contatos_detalhes_screen.dart

import 'package:flutter/material.dart';

class ContatosDetalhesScreen extends StatelessWidget {
  final String contatos;

  ContatosDetalhesScreen({required this.contatos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contatos'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);  // Volta para a tela anterior
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            contatos,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
