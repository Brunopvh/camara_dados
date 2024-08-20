
import 'dart:io';
import 'package:projeto_flutter/utils/libjson.dart';
import 'package:projeto_flutter/utils/utils.dart';

Directory cacheDir = Directory(PathUtils().join([getUserDownloads(), 'dados-camara']));

String baseEmentas(){
  return PathUtils().join([cacheDir.path, 'ementas.json']);
}

String baseAutores(){
  return PathUtils().join([cacheDir.path, 'autores.json']);
}

Future<bool> downloadBaseOnline() async {

  if(!cacheDir.existsSync()){
    cacheDir.createSync(recursive: true);
  }


  if(!File(baseAutores()).existsSync()){
    download(url: UrlsCamara().autores(), filePath:  File(baseAutores()));
  }

  if(!File(baseEmentas()).existsSync()){
    download(url: UrlsCamara().ementas(), filePath:  File(baseEmentas()));
  }

  if(File(baseEmentas()).existsSync() && File(baseAutores()).existsSync()){
    return true;
  }

  return false;
}

//========================================================================//
// AUTOR
//========================================================================//
class Ementa {
  /*
  late String id;
  late String uri;
  late String siglaTipo;
  late String numero;
  late String ano;
  late String codTipo;
  late String descricaoTipo;
  late String ementa;
  late String ementaDetalhada;
  late String keywords;
  late String dataApresentacao;
  late String uriOrgaoNumerador;
  late String uriPropAnterior;
  late String uriPropPrincipal;
  late String uriPropPosterior;
  late String urlInteiroTeor;
  late String ultimoStatus;
  */

  Map<String, dynamic> ementaItens;
  Ementa({required this.ementaItens});

  String getEmentaId(){
    return this.ementaItens['id'].toString();
  }

  String getEmentaNome(){
    return this.ementaItens['ementa'].toString();
  }

  String getEmentaDetalhada(){
    return this.ementaItens['ementaDetalhada'].toString();
  }

  String getDescricao(){
    return this.ementaItens['descricaoTipo'].toString();
  }

}

//========================================================================//
// AUTOR
//========================================================================//
class Autor {
  /*
 
  */

  Map<String, dynamic> autorItens;
  Autor({required this.autorItens});

  String getNome(){
    return this.autorItens['nomeAutor'].toString();
  }

  String idProposicao(){
    return this.autorItens['idProposicao'].toString();
  }

}