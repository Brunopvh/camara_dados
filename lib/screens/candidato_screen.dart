import 'package:flutter/material.dart';
import 'package:projeto_flutter/screens/candidato_proposicoes.dart';
import '../models/candidato.dart';
import 'candidato_detalhes_screen.dart';
import '../dados/candidatos_dados.dart'; // Certifique-se de que o caminho está correto

class MyHomePage extends StatefulWidget {
  List<Candidato> candidatos;

  MyHomePage({super.key, required this.candidatos});

  @override
  State<MyHomePage> createState() => CandidatoScreen(listaDeputados: this.candidatos);
}


// Exibição dos canditados na tela principal.
class CandidatoScreen extends State<MyHomePage> {
  late List<Candidato> listaDeputados;

  CandidatoScreen({required this.listaDeputados});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página Inicial'),
      ),
      body: ListView.builder(
        //itemCount: candidatos.length,
        itemCount: this.listaDeputados.length,
        itemBuilder: (context, index) {
          var candidato = this.listaDeputados[index];
          return ListTile(
            title: Text(candidato.nome),
            subtitle: Text('${candidato.cidade} - ${candidato.cargo}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CandidatoDetalhesScreen(candidato: candidato),
                      
                ),
              );
            },
          );
        },
      ),
    );
  }
}
