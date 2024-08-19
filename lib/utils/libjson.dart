/*


KEYS

id
uri
siglaTipo
numero
ano
codTipo
descricaoTipo
ementa
ementaDetalhada
keywords
dataApresentacao
uriOrgaoNumerador
uriPropAnterior
uriPropPrincipal
uriPropPosterior
urlInteiroTeor
ultimoStatus


VERSÃO = 2024-08-17

*/

/*
Autor - Bruno Chaves
2024-08
*/

import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:projeto_flutter/utils/utils.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

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
// Ao instânciar essa classe você pode obter um Map<> de um conteúdo JSON
// a fonte pode ser um ARQUIVO local ou um URL.
//========================================================================//
class JsonToMap {

  String getOnlineJson(String url){
    print('REQUEST: ${url}');
    String e = '{}';
    http.get(Uri.parse(url)).then((response) {
      
      if (response.statusCode == 200) {
        // Convertendo o corpo da resposta para String
        String responseBody = response.body;
        return responseBody;
      } else {
        print('Erro na requisição: ${response.statusCode}');
      }
    }).catchError((error) {
      print('Erro na requisição: $error');
    });

    return e;
  }

  Map<String, dynamic> fromUrl(String url) {
    // Recebe um url de arquivo JSON, baixa o conteúdo e retorna em forma de mapa.
    String dataJson = this.getOnlineJson(url);
    var _map = jsonDecode(dataJson);
    return _map as Map<String, dynamic>;
  }

  Map<String, dynamic> fromFileName(String filename) {
    // Recebe o caminho completo de um arquivo JSON no disco 
    //e retorna o conteúdo em forma de mapa.
    Map<String, dynamic> m = {};
    File f = File(filename);
    if (f.existsSync() == false) {
      printLine();
      printErro('o arquivo não existe ${filename}');
    } else {
      printInfo('Lendo o arquivo: ${filename}');
      m = jsonDecode(f.readAsStringSync());
    }
    return m;
  }
}


class CamaraDadosOnline {
  List<Map<String, dynamic>> _listMap = [];
  Map<String, dynamic> dataBaseMap;
  String keyDados = 'dados'; // Na chave dados estão todos os itens.

  CamaraDadosOnline({required this.dataBaseMap});

  List<dynamic> getList() {
    // Retorna uma lista bruta com os dados do arquivo.
    if(this.dataBaseMap.isEmpty){
      return [];
    }
    return this.dataBaseMap[this.keyDados];
  }

  List<Map<String, dynamic>> getListMap() {
    if (this._listMap.isEmpty) {
      Map<String, dynamic> _current;
      List<dynamic> get_list = this.getList();
      int max = get_list.length;

      for (int i = 0; i < max; i++) {
        _current = get_list[i];
        this._listMap.add(_current);
      }

    }
    return this._listMap;
  }

  List<String> getKeys() {
    if(this.getListMap().isEmpty){
      return [];
    }
    return this.getListMap()[0].keys.toList();
  }

  List<String> valuesInKey(String keyName) {
    // Apartir de uma chave/key - retorna todos os valores correspondentes no arquivo JSON.
    List<String> _values = [];
    String _current;
    int max = this.getListMap().length;

    for (int i = 0; i < max; i++) {
      _current = this.getListMap()[i][keyName].toString();
      _values.add(_current);
    }

    return _values;
  }
}


class GetDados {
  List<Map<String, dynamic>> _listMap = [];
  CamaraDadosOnline camaraDados;
  
  GetDados({required this.camaraDados});

  List<dynamic> getList() {
    return this.camaraDados.getList();
  }

  List<Map<String, dynamic>> getListMap() {
    return this.camaraDados.getListMap();
  }

  List<String> getKeys() {
    return this.camaraDados.getKeys();
  }

  List<String> valuesInKey(String keyName) {
    // Apartir de uma chave/key - retorna todos os valores correspondentes no arquivo JSON.
    return this.camaraDados.valuesInKey(keyName);
  }

  FindItens getFind() {
    return FindItens(listItens: this.getListMap());
  }
}

//========================================================================//
// Dados Proposições - (proposicoes.json)
//========================================================================//
class Proposicoes extends GetDados {
  Proposicoes({required super.camaraDados});

  FindItens containsEmenta({required String ementa}) {
    List<Map<String, dynamic>> e = [];
    List<Map<String, dynamic>> itens = this.getListMap();
    int maxNum = itens.length;

    if (itens.isEmpty) {
      return FindItens(listItens: [{'Chave Nula': 'Valor Nulo'}]);
    }

    for (int i = 0; i < maxNum; i++) {
      if (itens[i]['ementa'].toString().toUpperCase().contains(ementa.toUpperCase())) {
        // Observação usar <contains> ao invés de < == >
        e.add(itens[i]);
      }
    }

    return FindItens(listItens: e);
  }

  FindItens getIds({required List<String> idsList}) {
    // Filtra todas as proposições com base em uma lista de IDS
    if (idsList.isEmpty) {
      printLine();
      printErro('A lista de IDS é nula');
      return FindItens(listItens: [{'Chave Nula': 'Valor Nulo'}]);
    }
    return this.getFind().getMapsFromValues(values: idsList, key: 'id');
  }
}

//========================================================================//
// Dados dos Autores - (autores.json)
//========================================================================//
class AutoresDados extends GetDados {
  AutoresDados({required super.camaraDados});

  FindItens filtroUnidadeFederativa({required String uf}) {
    // Filtrar por Estado.
    return this.getFind().getMapsInKey(key: 'siglaUFAutor', value: uf);
  }

  FindItens filtroNomeAutor({required String nomeDeputado}) {
    // Retorna todos os itens de um deputado com base no nome do deputado.
    return this.getFind().getMapsInKey(key: 'nomeAutor', value: nomeDeputado);
  }

  List<String> filtroIdsProposicoes({required String nomeDeputado}) {
    // 1-> Filtrar a lista de mapas por nome do deputado
    // 2-> Filtrar todos os itens da chave/key idProposição do deputado.
    return this
        .filtroNomeAutor(nomeDeputado: nomeDeputado)
        .getValuesInKey(key: 'idProposicao');
  }
}

//========================================================================//
// Buscar Itens em uma lista de mapas/json
//========================================================================//

class FindItens {
  late List<Map<String, dynamic>> listItens;

  FindItens({required this.listItens});

  bool containsValue({required String key, required String value}) {
    // Verifica se um valor existe em uma chave especifica.
    if (!this.listItens[0].containsKey(key)) {
      return false;
    }

    bool _contains = false;
    int max = this.listItens.length;
    for (int i = 0; i < max; i++) {
      if (this.listItens[i][key].toString().contains(value)) {
        _contains = true;
        break;
      }
    }
    return _contains;
  }

  List<String> getValuesInKey({required String key}) {
    // Retorna os valores dos mapas na chave <key>
    List<String> _itens = [];
    int max = this.listItens.length;
    for (int i = 0; i < max; i++) {
      _itens.add(this.listItens[i][key].toString());
    }

    return _itens;
  }

  FindItens getMapsInKey({required String key, required String value}) {
    // Retorna um objeto FindItens com todos os mapas que contém o valor <value>
    // na chave <key>.
    List<Map<String, dynamic>> list_maps_from_key = [];
    if (this.listItens.isEmpty) {
      return FindItens(listItens: [{'Chave Nula': 'Valor Nulo'}]);
    }

    if (!this.listItens[0].keys.toList().contains(key)) {
      return FindItens(listItens: [{'Chave Nula': 'Valor Nulo'}]);
    }

    int max_num = this.listItens.length;
    for (int i = 0; i < max_num; i++) {
      if (this.listItens[i][key].toString().toUpperCase() ==
          value.toUpperCase()) {
        list_maps_from_key.add(this.listItens[i]);
      }
    }
    return FindItens(listItens: list_maps_from_key);
  }

  FindItens getMapsFromValues({required List<String> values, required key}) {
    // Recebe uma lista de valores, se tais valores forem encontrados, será retornado
    // uma lista de mapas com todas a ocorrênias na forma do objeto FindItens().
    List<Map<String, dynamic>> _list = [];
    Map<String, dynamic> current_map;
    int max = this.listItens.length;
    int max_values = values.length;

    for (int i = 0; i < max_values; i++) {
      for (int c = 0; c < max; c++) {
        current_map = this.listItens[c];
        if (current_map[key].toString() == values[i].toString()) {
          _list.add(current_map);
        }
      }
    }

    return FindItens(listItens: _list);
  }
}

