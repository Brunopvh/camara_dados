
import 'dart:convert';
import 'package:projeto_flutter/dados/repository_interface.dart';
import 'package:projeto_flutter/models/models_dados.dart';
import 'package:http/http.dart' as http;

String urlProposicoes = 'https://dadosabertos.camara.leg.br/arquivos/proposicoesTemas/json/proposicoesTemas-2024.json';
String urlAutores = 'https://dadosabertos.camara.leg.br/arquivos/proposicoesAutores/json/proposicoesAutores-2024.json';

class EmentasHttpRepository implements IEmentaRepository {

  @override
  Future<List<EmentaModel>> findAllEmentas() async {
    final responseEmenta = await http.get(Uri.parse(urlProposicoes));
    final Map<String, dynamic> responseMap = jsonDecode(responseEmenta.body);

    List<Map<String, dynamic>> ementasList = responseMap['dados'];
    int max = ementasList.length;
    List<EmentaModel> ementas = [];
    for(int i=0; i<max; i++){
      ementas.add(
        EmentaModel.fromMap(ementasList[i])
      );
    }

    return ementas;
  }
}


class AutoresHttpRepsitory implements IAutorRepository {
  
  @override
  Future<List<AutorModel>> findAllAutores() async {
    List<AutorModel> autores = [];

    final responseAutores = await http.get(Uri.parse(urlAutores));
    final Map<String, dynamic> responseAutoresMap = jsonDecode(responseAutores.body);
    List<Map<String, dynamic>> autoresList = responseAutoresMap['dados'];
    int maxNum = autoresList.length;

    for(int i=0; i<maxNum; i++){
      autores.add(
        AutorModel.fromMap(autoresList[i])
      );
    }

    return autores;
  }
}