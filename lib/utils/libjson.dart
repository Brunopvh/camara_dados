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
// Ao instânciar essa classe você pode obter um Map<> de um conteúdo JSON
// a fonte pode ser um ARQUIVO local ou um URL.
//========================================================================//
class JsonToMap {
  Future<Map<String, dynamic>> fromUrl(String url) async {
    // Recebe um url de arquivo JSON, baixa o conteúdo e retorna em forma de mapa.
    Map<String, dynamic> m = {'Valor nulo': 'Valor nulo'};

    try {
      Future<Response> response = getRequest(url);
      Response r = await response;
      m = jsonDecode(utf8.decode(r.bodyBytes));

    } catch (e) {
      printErro(e.toString());
      printLine();
      printInfo('Verifique o URL ou sua conexção com a internet.');
      printLine();
    }
    return m;
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

//========================================================================//
// Dados Gerais
//========================================================================//
class CamaraJsonUtil {
  List<Map<String, dynamic>> _listMap = [];
  File fileNameJson;
  String keyDados = 'dados';

  CamaraJsonUtil({required this.fileNameJson, required this.keyDados});

  List<dynamic> getList() {
    // Retorna uma lista bruta com os dados do arquivo.
    if (!this.fileNameJson.existsSync()) {
      return [
        {'NULL': 'NULL'}
      ];
    }
    return JsonToMap().fromFileName(this.fileNameJson.path)[this.keyDados];
  }

  List<Map<String, dynamic>> getListMap() {
    // Retorna uma lista com mapas dos valores do arquivo.
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
    // Retorna uma lista de chaves dos mapas.
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
  File filePath;
  late CamaraJsonUtil camaraJsonUtil;

  GetDados(this.filePath) {
    // Criar o objeto para análise e obtenção dos dados apartir de um arquivo JSON qualquer.
    this.camaraJsonUtil =
        CamaraJsonUtil(fileNameJson: this.filePath, keyDados: 'dados');
  }

  List<dynamic> getList() {
    return this.camaraJsonUtil.getList();
  }

  List<Map<String, dynamic>> getListMap() {
    return this.camaraJsonUtil.getListMap();
  }

  List<String> getKeys() {
    return this.camaraJsonUtil.getKeys();
  }

  List<String> valuesInKey(String keyName) {
    // Apartir de uma chave/key - retorna todos os valores correspondentes no arquivo JSON.
    return this.camaraJsonUtil.valuesInKey(keyName);
  }

  FindItens getFind() {
    return FindItens(listItens: this.getListMap());
  }
}

//========================================================================//
// Dados Proposições - (proposicoes.json)
//========================================================================//
class Proposicoes extends GetDados {
  Proposicoes(super.filePath);

  FindItens containsEmenta({required String ementa}) {
    List<Map<String, dynamic>> e = [];
    List<Map<String, dynamic>> itens = this.getListMap();
    int maxNum = itens.length;

    if (itens.isEmpty) {
      return FindItens(listItens: [
        {'Valor nulo': 'Valor nulo'}
      ]);
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
      return FindItens(listItens: [
        {'NULL': 'Null'}
      ]);
    }
    return this.getFind().getMapsFromValues(values: idsList, key: 'id');
  }
}

//========================================================================//
// Dados dos Autores - (autores.json)
//========================================================================//
class AutoresDados extends GetDados {
  AutoresDados(super.filePath);

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
      return FindItens(listItens: []);
    }

    if (!this.listItens[0].keys.toList().contains(key)) {
      return FindItens(listItens: []);
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

class FindElements extends FindItens {
  FindElements({required super.listItens});
}

void run() {
  return;
}
