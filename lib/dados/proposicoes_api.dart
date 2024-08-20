/*
Autor - Bruno Chaves
2024-08
*/

import 'dart:convert';
import 'dart:io';
import 'package:projeto_flutter/utils/models_dados.dart';
import 'package:projeto_flutter/utils/libjson.dart';
import 'package:projeto_flutter/models/candidato.dart';

//========================================================================//
// Baixar arquivos JSON localmente.
//========================================================================//

class BuildDadosAutores {

  File filePath = File(baseAutores());
  Map<String, dynamic> dadosAutores = {};

  BuildDadosAutores();

  DadosAutor create(){
    return DadosAutor(dados: DadosCamara(dadosCamara: GetJson().fromFileName(this.filePath.path)));
  }
}

class BuildDadosEmentas {

  File filePath = File(baseEmentas());
  Map<String, dynamic> dadosAutores = {};

  BuildDadosEmentas();

  DadosEmenta create(){
    return DadosEmenta(dados: DadosCamara(dadosCamara: GetJson().fromFileName(this.filePath.path)));
  }
}

DadosAutor dadosAutores = BuildDadosAutores().create();
DadosEmenta dadosEmentas = BuildDadosEmentas().create();

//========================================================================//
// Filtrar os dados para exibir no app.
//========================================================================//

class CandidatoEmentas {

  DadosEmenta ementas = dadosEmentas;
  DadosAutor autores = dadosAutores;
  

  Ementa defaultEmenta = Ementa(
      ementaItens: {
        'id': 'ERRO',
        'dataApresentacao': 'ERRO',
        'ementa': 'ERRO',
        'ementaDetalhada': 'ERRO',
      }
    );

  Candidato candidato;
  CandidatoEmentas({required this.candidato});

  List<Ementa> candidatoListEmentas(){
    List<String> ids = this.autores.autorProposicoesIds(nome: this.candidato.nome);
    return this.ementas.getEmentas(ids: ids);
  }

}
