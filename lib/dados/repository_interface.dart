import 'package:projeto_flutter/models/models_dados.dart';

abstract class IEmentaRepository {

  Future<List<EmentaModel>> findAllEmentas();
}



abstract class IAutorRepository {

  Future<List<AutorModel>> findAllAutores();
}