// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';
import 'package:projeto_flutter/dados/repository_interface.dart';


class ControllerEmentas extends GetxController {
  final IEmentaRepository _ementaRepository;
  ControllerEmentas(this._ementaRepository);
  
}

class ControllerAutores extends GetxController {
  final IAutorRepository _autorRepository;

  ControllerAutores(this._autorRepository); 
}