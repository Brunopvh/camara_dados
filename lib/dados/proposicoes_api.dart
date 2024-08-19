/*
Autor - Bruno Chaves
2024-08
*/

import 'dart:convert';
import 'dart:io';
import 'package:projeto_flutter/utils/utils.dart';
import 'package:projeto_flutter/utils/libjson.dart';
import 'package:projeto_flutter/models/candidato.dart';

//========================================================================//
// INTEGRAÇÃO DA API COM ARQUIVOS LOCAIS
//========================================================================//

PathUtils path_utils = PathUtils(); // -> lib/utils.dart

// Arquivos JSON que serão baixados localmente.
final File fileProposicoes = File(path_utils.join([getLocalDirCache().path, 'proposicoes.json']));
final File fileAutores = File(path_utils.join([getLocalDirCache().path, 'autores.json']));

File getFileProposicoes() {
  if (!fileProposicoes.existsSync()) {
    startApiFiles();
  }
  return fileProposicoes;
}

File getFileAutores() {
  // Arquivo JSON com dados dos autores - que será baixado localmente

  if (!fileAutores.existsSync()) {
    startApiFiles();
  }
  return fileAutores;
}

//========================================================================//
// Baixar arquivos JSON localmente.
//========================================================================//
void startApiFiles() {

  try {
    if (!fileProposicoes.existsSync()) {
      downloadFileSync(BaseUrls().urlAutoresProposicoes(), fileAutores.path);
    }

    if (!fileProposicoes.existsSync()) {
      downloadFileSync(BaseUrls().urlProposicoes(), fileProposicoes.path);
    }
  } catch (e){
    printLine();
    print(e);
    printLine();
  }
  
}


//========================================================================//
// Diretório para baixar arquivos localmente - está setado para usar a pasta
// Downloads do usuário.
//========================================================================//
Directory getLocalDirCache() {
  Directory d = Directory(PathUtils().join([getUserDownloads(), 'dados-camara']));

  if (!d.existsSync()) {
    d.createSync(recursive: true);
  }
  return d;
}

class BuildDadosAutores {

  String urlAutores = BaseUrls().urlAutoresProposicoes();
  File filePath = getFileAutores();
  Map<String, dynamic> _dadosOnline = {};

  BuildDadosAutores();

  Map<String, dynamic> _dadosUrl(){
    // Retornar os dados usando um URL como fonte.
    if(this._dadosOnline.isEmpty){
      this._dadosOnline = JsonToMap().fromUrl(this.urlAutores);
    }
    return this._dadosOnline;
  }

  Map<String, dynamic> _dadosArquivo(){
    // Retornar os dados usando um ARQUIVO como fonte.
    Map<String, dynamic> _dados = JsonToMap().fromFileName(this.filePath.path);
    return _dados;
  }

  AutoresDados get(){
    Map<String, dynamic> mp = this._dadosArquivo();
    return AutoresDados(camaraDados: CamaraDadosOnline(dataBaseMap: mp));
  }

}


class BuildProposicoes {

  String urlAutores = BaseUrls().urlProposicoes();
  File filePath = getFileProposicoes();
  var _dadosOnline;

  BuildProposicoes();

  String _dadosUrl(){
    // Retornar os dados usando um URL como fonte.
    if(this._dadosOnline.isEmpty){
      this._dadosOnline = JsonToMap().getOnlineJson(this.urlAutores);
    }
    return this._dadosOnline as String;
  }

  String _dadosArquivo(){
    // Retornar os dados usando um ARQUIVO como fonte.
    var _dados = jsonDecode(this.filePath.readAsStringSync());
    return _dados as String;
  }

  Map<String, dynamic> _getDados(){
    Map<String, dynamic> m = jsonDecode(this._dadosArquivo());
    if(m.isEmpty){
      return {'dados':[]};
    }
    return m;
  }

  Proposicoes get(){
    return Proposicoes(camaraDados: CamaraDadosOnline(dataBaseMap: this._getDados()));
  }

}


//========================================================================//
// Filtrar os dados para exibir no app.
//========================================================================//

class DeputadoProposicao {
  Candidato candidato;

  DeputadoProposicao({required this.candidato});

  Proposicao getDefaultProposicao(){
    return Proposicao(
            id: 'ERRO', 
            ano: 'ERRO', 
            descricaoTipo: 'ERRO', 
            ementa: 'ERRO'
            );
  }

  List<Proposicao> proposicoesList() {
    return [this.getDefaultProposicao()];
  }
}
