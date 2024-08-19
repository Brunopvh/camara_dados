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

late CamaraDadosOnline autores;
late CamaraDadosOnline proposicoes;

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

//========================================================================//
// Baixar arquivos JSON localmente.
//========================================================================//
void startApiFiles() {
  /*
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
  */
  startApi();
  //autores = getAutoresOnline();
  //proposicoes = getProposicoesOnline();

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

Proposicoes getProposicoes() {
  //Map<String, dynamic> m = JsonToMap().fromFileName(fileProposicoes.path);
  return Proposicoes(camaraDados: getProposicoesOnline());
}

AutoresDados getAutores() {
  //Map<String, dynamic> m = JsonToMap().fromUrl(BaseUrls().urlAutoresProposicoes());
  //Map<String, dynamic> m = JsonToMap().fromFileName(fileAutores.path);
  return AutoresDados(camaraDados: getAutoresOnline());
}

//========================================================================//
// Filtrar os dados para exibir no app.
//========================================================================//

class DeputadoProposicao {
  Candidato candidato;

  DeputadoProposicao({required this.candidato});

  FindItens dados() {
    // retornar todos os dados do deputado no arquivo JSON autores.
    return getAutores().getFind().getMapsInKey(key: 'nomeAutor', value: this.candidato.nome);
  }

  List<String> idsProposicao() {
    // obter os IDS das proposições do deputado.
    return this.dados().getValuesInKey(key: 'idProposicao');
  }

  FindItens proposicoesTodas() {
    return getProposicoes().getIds(idsList: this.idsProposicao());
  }

  Proposicao getDefaultProposicao(){
    return Proposicao(
            id: 'ERRO', 
            ano: 'ERRO', 
            descricaoTipo: 'ERRO', 
            ementa: 'ERRO'
            );
  }

  List<Proposicao> proposicoesList() {
    List<Proposicao> p = [];
    List<Map<String, dynamic>> mp = this.proposicoesTodas().listItens;
    int maxNum = mp.length;
    
    try {
      for (int i = 0; i < maxNum; i++) {
        p.add(Proposicao(
            id: mp[i]['id'].toString(),
            ano: mp[i]['ano'].toString(),
            descricaoTipo: mp[i]['descricaoTipo'],
            ementa: mp[i]['ementa']));
      }
    } catch(e){
      print(e.toString());
      printLine();
      printErro("Erro ao tentar gerar a lista de proposições");

      p.add(this.getDefaultProposicao());
    }
    
    return p;
  }
}
