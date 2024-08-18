/*
Autor - Bruno Chaves
2024-08
*/

import 'dart:io';
import 'package:projeto_flutter/utils/utils.dart';
import 'package:projeto_flutter/utils/libjson.dart';
import 'package:projeto_flutter/models/candidato.dart';

//========================================================================//
// INTEGRAÇÃO DA API COM ARQUIVOS LOCAIS
//========================================================================//

PathUtils path_utils = PathUtils();

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

File getFileAutoresRo(){
  File f = File(path_utils.join([getLocalDirCache().path, 'autores-ro.json']));

  if(!f.existsSync()){
    FindItens _a = AutoresDados(getFileAutores()).filtroUnidadeFederativa(uf: 'RO');
    JsonUtils().exportMapToFile(map: {'dados': _a.listItens}, outputFile: f);
  }

  return f;
}

File getFileProposicoesRo(){
  File fRo = File(path_utils.join([getLocalDirCache().path, 'proposicoes-ro.json']));

  if(!fRo.existsSync()){
    FindItens _autores = AutoresDados(getFileAutoresRo()).getFind();
    List<String> _ids = _autores.getValuesInKey(key: 'idProposicao');
    FindItens p = Proposicoes(getFileProposicoes()).getIds(idsList: _ids);
    JsonUtils().exportMapToFile(map: {'dados': p.listItens}, outputFile: fRo);
  }
  return fRo;
}

//========================================================================//
// Baixar arquivos JSON localmente.
//========================================================================//
bool startApiFiles() {
  try {
    if (!fileProposicoes.existsSync()) {
      downloadFileSync(BaseUrls().urlAutoresProposicoes(), fileAutores.path);
    }

    if (!fileProposicoes.existsSync()) {
      downloadFileSync(BaseUrls().urlProposicoes(), fileProposicoes.path);
    }
  } catch (e){
    return false;
  }
  return true;
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
Directory getLocalDirCache() {
  Directory d = Directory(PathUtils().join([getUserDownloads(), 'dados-camara']));

  if (!d.existsSync()) {
    d.createSync(recursive: true);
  }
  return d;
}

Proposicoes getPropocicoes() {
  return Proposicoes(getFileProposicoesRo());
}

AutoresDados getAutores() {
  return AutoresDados(getFileAutoresRo());
}

//========================================================================//
// Filtrar os dados para exibir no app.
//========================================================================//

class DeputadoProposicao {
  Candidato candidato;

  DeputadoProposicao({required this.candidato});

  FindItens dados() {
    // retornar todos os dados do deputado no arquivo JSON autores.
    return getAutores()
        .getFind()
        .getMapsInKey(key: 'nomeAutor', value: this.candidato.nome);
  }

  List<String> idsProposicao() {
    // obter os IDS das proposições do deputado.
    return this.dados().getValuesInKey(key: 'idProposicao');
  }

  FindItens proposicoesTodas() {
    return getPropocicoes().getIds(idsList: this.idsProposicao());
  }

  List<Proposicao> proposicoesList() {
    List<Proposicao> p = [];
    List<Map<String, dynamic>> mp = this.proposicoesTodas().listItens;
    int maxNum = mp.length;

    for (int i = 0; i < maxNum; i++) {
      p.add(Proposicao(
          id: mp[i]['id'].toString(),
          ano: mp[i]['ano'].toString(),
          descricaoTipo: mp[i]['descricaoTipo'],
          ementa: mp[i]['ementa']));
    }

    return p;
  }
}
