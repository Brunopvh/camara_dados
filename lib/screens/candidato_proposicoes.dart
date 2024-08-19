/*
Autor - Bruno Chaves
2024-08
*/

import 'package:flutter/material.dart';
import '../models/candidato.dart';
import 'package:projeto_flutter/dados/proposicoes_api.dart';

class CandidatoProposicoesScreen extends StatelessWidget {

  Candidato candidato;
  CandidatoProposicoesScreen({required this.candidato});

  List<Proposicao> getProposicoes(){
    return DeputadoProposicao(candidato: this.candidato).proposicoesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${this.candidato.nome.toUpperCase()} - (${this.getProposicoes().length}) proposições'),
      ),
      body: ListView.builder(
        itemCount: this.getProposicoes().length,
        itemBuilder: (context, index){
          final proposicao = this.getProposicoes()[index];

          return Card(
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'ID - ${proposicao.id}',
                    style: TextStyle(
                      fontSize: 16, // Tamanho do texto
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    proposicao.descricaoTipo,
                    style: TextStyle(
                      fontSize: 20, // Tamanho do texto
                      fontWeight: FontWeight.bold, // Negrito
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    proposicao.ementa,
                    style: TextStyle(
                      fontSize: 16, // Tamanho do texto
                    ),
                  ),
                ),
          ]
          ),
        );
        }
        ),
    );

  }

}

