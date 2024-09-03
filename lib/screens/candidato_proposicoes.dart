// ignore_for_file: public_member_api_docs, sort_constructors_first
/*
Autor - Bruno Chaves
2024-08
*/

import 'package:flutter/material.dart';
import '../models/candidato.dart';
import 'package:projeto_flutter/dados/proposicoes_api.dart';
import 'package:projeto_flutter/models/models_dados.dart';


class CandidatoProposicoesScreen extends StatelessWidget {

  Candidato candidato;
  CandidatoProposicoesScreen({required this.candidato});

  List<Ementa> getEmentasCandidato(){
    return CandidatoEmentas(candidato: this.candidato).candidatoListEmentas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${this.candidato.nome.toUpperCase()} - (${this.getEmentasCandidato().length}) Ementas'),
      ),
      body: ListView.builder(
        itemCount: this.getEmentasCandidato().length,
        itemBuilder: (context, index){
          final ementa = this.getEmentasCandidato()[index];

          return Card(
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'ID - ${ementa.getEmentaId()}',
                    style: TextStyle(
                      fontSize: 16, // Tamanho do texto
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    ementa.getDescricao(),
                    style: TextStyle(
                      fontSize: 20, // Tamanho do texto
                      fontWeight: FontWeight.bold, // Negrito
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    ementa.getEmentaNome(),
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

