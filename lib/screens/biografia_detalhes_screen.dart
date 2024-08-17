// lib/screens/biografia_detalhes_screen.dart

import 'package:flutter/material.dart';

class BiografiaDetalhesScreen extends StatelessWidget {
  final String biografia;

  BiografiaDetalhesScreen({required this.biografia});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Biografia'),
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
            biografia,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
