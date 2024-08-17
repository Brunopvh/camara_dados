import 'package:flutter/material.dart';
import '../models/candidato.dart';
import 'candidato_detalhes_screen.dart';
import '../dados/candidatos_dados.dart'; // Certifique-se de que o caminho está correto

class CandidatoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Candidatos'),
      ),
      body: ListView.builder(
        itemCount: candidatos.length,
        itemBuilder: (context, index) {
          final candidato = candidatos[index];
          return ListTile(
            title: Text(candidato.nome),
            subtitle: Text('${candidato.cidade} - ${candidato.cargo}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CandidatoDetalhesScreen(candidato: candidato),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
