// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';
import 'dart:io';

import 'package:projeto_flutter/utils/libjson.dart';
import 'package:projeto_flutter/utils/utils.dart';

//Directory cacheDir = Directory(PathUtils().join([getUserDownloads(), 'dados-camara']));

Directory _getDirCache(){
  var _d;
  if (Platform.isAndroid) {
    _d = Directory(PathUtils().join([getTempDir(), 'dados-camara']));
  } else {
    _d = Directory(PathUtils().join([getUserDownloads(), 'dados-camara']));
  }

  return _d as Directory;

}

Directory cacheDir = _getDirCache();

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
// EMENTA MODEL
//========================================================================//

class EmentaModel {
  String id;
  String uri;
  String siglaTipo;
  String numero;
  String ano;
  String data;
  String codTipo;
  String descricaoTipo;
  String ementa;
  String ementaDetalhada;
  String keywords;
  String dataApresentacao;
  String uriOrgaoNumerador;
  String uriPropAnterior;
  String uriPropPrincipal;
  String uriPropPosterior;
  String urlInteiroTeor;
  String ultimoStatus;

  EmentaModel({
    required this.id,
    required this.uri,
    required this.siglaTipo,
    required this.numero,
    required this.ano,
    required this.data,
    required this.codTipo,
    required this.descricaoTipo,
    required this.ementa,
    required this.ementaDetalhada,
    required this.keywords,
    required this.dataApresentacao,
    required this.uriOrgaoNumerador,
    required this.uriPropAnterior,
    required this.uriPropPrincipal,
    required this.uriPropPosterior,
    required this.urlInteiroTeor,
    required this.ultimoStatus,
  });



  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'uri': uri,
      'siglaTipo': siglaTipo,
      'numero': numero,
      'ano': ano,
      'data': data,
      'codTipo': codTipo,
      'descricaoTipo': descricaoTipo,
      'ementa': ementa,
      'ementaDetalhada': ementaDetalhada,
      'keywords': keywords,
      'dataApresentacao': dataApresentacao,
      'uriOrgaoNumerador': uriOrgaoNumerador,
      'uriPropAnterior': uriPropAnterior,
      'uriPropPrincipal': uriPropPrincipal,
      'uriPropPosterior': uriPropPosterior,
      'urlInteiroTeor': urlInteiroTeor,
      'ultimoStatus': ultimoStatus,
    };
  }

  factory EmentaModel.fromMap(Map<String, dynamic> map) {
    return EmentaModel(
      id: map['id'] as String,
      uri: map['uri'] as String,
      siglaTipo: map['siglaTipo'] as String,
      numero: map['numero'] as String,
      ano: map['ano'] as String,
      data: map['data'] as String,
      codTipo: map['codTipo'] as String,
      descricaoTipo: map['descricaoTipo'] as String,
      ementa: map['ementa'] as String,
      ementaDetalhada: map['ementaDetalhada'] as String,
      keywords: map['keywords'] as String,
      dataApresentacao: map['dataApresentacao'] as String,
      uriOrgaoNumerador: map['uriOrgaoNumerador'] as String,
      uriPropAnterior: map['uriPropAnterior'] as String,
      uriPropPrincipal: map['uriPropPrincipal'] as String,
      uriPropPosterior: map['uriPropPosterior'] as String,
      urlInteiroTeor: map['urlInteiroTeor'] as String,
      ultimoStatus: map['ultimoStatus'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory EmentaModel.fromJson(String source) => EmentaModel.fromMap(json.decode(source) as Map<String, dynamic>);
}


class AutorModel {
  
  String nomeAutor;
  String idProposicao;
  String uriAutor;
  String uriProposicao;
  String idDeputadoAutor;
  String codTipoAutor;
  String tipoAutor;
  String siglaPartidoAutor;
  String siglaUFAutor;
  AutorModel({
    required this.nomeAutor,
    required this.idProposicao,
    required this.uriAutor,
    required this.uriProposicao,
    required this.idDeputadoAutor,
    required this.codTipoAutor,
    required this.tipoAutor,
    required this.siglaPartidoAutor,
    required this.siglaUFAutor,
  });
  
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nomeAutor': nomeAutor,
      'idProposicao': idProposicao,
      'uriAutor': uriAutor,
      'uriProposicao': uriProposicao,
      'idDeputadoAutor': idDeputadoAutor,
      'codTipoAutor': codTipoAutor,
      'tipoAutor': tipoAutor,
      'siglaPartidoAutor': siglaPartidoAutor,
      'siglaUFAutor': siglaUFAutor,
    };
  }

  factory AutorModel.fromMap(Map<String, dynamic> map) {
    return AutorModel(
      nomeAutor: map['nomeAutor'] as String,
      idProposicao: map['idProposicao'] as String,
      uriAutor: map['uriAutor'] as String,
      uriProposicao: map['uriProposicao'] as String,
      idDeputadoAutor: map['idDeputadoAutor'] as String,
      codTipoAutor: map['codTipoAutor'] as String,
      tipoAutor: map['tipoAutor'] as String,
      siglaPartidoAutor: map['siglaPartidoAutor'] as String,
      siglaUFAutor: map['siglaUFAutor'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AutorModel.fromJson(String source) => AutorModel.fromMap(json.decode(source) as Map<String, dynamic>);
}



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
    if(this.ementaItens.isEmpty){
      return 'ERRO';
    }
    return this.ementaItens['id'].toString();
  }

  String getEmentaNome(){
    if(this.ementaItens.isEmpty){
      return 'ERRO';
    }
    return this.ementaItens['ementa'].toString();
  }

  String getEmentaDetalhada(){
    if(this.ementaItens.isEmpty){
      return 'ERRO';
    }
    return this.ementaItens['ementaDetalhada'].toString();
  }

  String getDescricao(){
    if(this.ementaItens.isEmpty){
      return 'ERRO';
    }
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
    if(this.autorItens.isEmpty){
      return 'ERRO';
    }
    return this.autorItens['nomeAutor'].toString();
  }

  String idProposicao(){
    if(this.autorItens.isEmpty){
      return 'ERRO';
    }

    return this.autorItens['idProposicao'].toString();
  }

}