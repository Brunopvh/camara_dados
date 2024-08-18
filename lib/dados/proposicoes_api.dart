/*
Autor - Bruno Chaves
2024-08
*/


import 'dart:io';
import 'package:projeto_flutter/utils/utils.dart';
import 'package:projeto_flutter/utils/libjson.dart';
import 'package:projeto_flutter/models/candidato.dart';

void startApi(){
  if(!getFileAutores().existsSync()){
    downloadFileSync(BaseUrls().urlAutoresProposicoes(), getFileAutores().path);
  }

  if(!getFileProposicoes().existsSync()){
    downloadFileSync(BaseUrls().urlProposicoes(), getFileProposicoes().path);
  }
}

//========================================================================//
// Classe para obter URLs da API
//========================================================================//
class BaseUrls {
  String urlProposicoes() {
    return 'https://dadosabertos.camara.leg.br/arquivos/proposicoes/json/proposicoes-2024.json';
  }

  String urlTemas() {
    return 'https://dadosabertos.camara.leg.br/arquivos/proposicoesTemas/json/proposicoesTemas-2024.json';
  }

  String urlAutoresProposicoes() {
    return 'https://dadosabertos.camara.leg.br/arquivos/proposicoesAutores/json/proposicoesAutores-2024.json';
  }
}

//========================================================================//
// Diretório para baixar arquivos localmente
//========================================================================//
Directory getLocalDirCache(){
  Directory d = Directory(PathUtils().join([getUserDownloads(), 'dados-camara']));
  if(!d.existsSync()){
    d.createSync(recursive: true);
  }
  return d;
}

//========================================================================//
// INTEGRAÇÃO COM API COM ARQUIVOS LOCAIS
//========================================================================//
File getFileProposicoes(){
  // Arquivo JSON que será baixado localmente
  final File fileProposicoes = File(PathUtils().join([getLocalDirCache().path, 'proposicoes.json']));
  if(!fileProposicoes.existsSync()){
    downloadFileSync(BaseUrls().urlProposicoes(), fileProposicoes.path);
  }
  return fileProposicoes;
}

File getFileAutores(){
  // Arquivo JSON com dados dos autores - que será baixado localmente
  final File fileAutores = File(PathUtils().join([getLocalDirCache().path, 'autores.json']));
  if(!fileAutores.existsSync()){
    downloadFileSync(BaseUrls().urlAutoresProposicoes(), fileAutores.path);
  }
  return fileAutores;
}

Proposicoes getPropocicoes(){
  return Proposicoes(getFileProposicoes());
}

ProposicoesAutores getAutores(){
  return ProposicoesAutores(getFileAutores());
}

//========================================================================//
// Filtrar os dados para exibir no app.
//========================================================================//


class DeputadoProposicao {
  Candidato candidato;

  DeputadoProposicao({required this.candidato});

  FindItens dados(){
    // retornar todos os dados do deputado no arquivo JSON autores.
    return getAutores().getFind().getMapsInKey(key: 'nomeAutor', value: this.candidato.nome);
  }

  List<String> idsProposicao(){
    // obter os IDS das proposições do deputado.
    return this.dados().getValuesInKey(key: 'idProposicao');
  }

  FindItens proposicoesTodas(){
    return getPropocicoes().getFind().getMapsFromValues(values: this.idsProposicao(), key: 'id');
  }

  List<Proposicao> proposicoesList(){

    List<Proposicao> p = [];
    List<Map<String, dynamic>> mp = this.proposicoesTodas().listItens;
    int maxNum = mp.length;

    for(int i=0; i<maxNum; i++){
      p.add(
        Proposicao(
            id: mp[i]['id'].toString(), 
            ano: mp[i]['ano'].toString(), 
            descricaoTipo: mp[i]['descricaoTipo'], 
            ementa: mp[i]['ementa']
            )
      );
    }

    return p;
  }


}