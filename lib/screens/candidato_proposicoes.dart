/*
Autor - Bruno Chaves
2024-08
*/

import 'package:flutter/material.dart';
import '../models/candidato.dart';
import 'package:projeto_flutter/dados/proposicoes_api.dart';

class CandidatoProposicoesScreen extends StatelessWidget {

  Candidato deputado;
  List<Proposicao> proposicoes = [];
  CandidatoProposicoesScreen({required this.deputado}){
    this.proposicoes = DeputadoProposicao(candidato: this.deputado).proposicoesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${this.deputado.nome.toUpperCase()} - (${this.proposicoes.length}) proposições'),
      ),
      body: ListView.builder(
        itemCount: this.proposicoes.length,
        itemBuilder: (context, index){
          final proposicao = this.proposicoes[index];

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

