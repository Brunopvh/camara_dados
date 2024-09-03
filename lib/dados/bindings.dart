import 'package:get/get.dart';
import 'package:projeto_flutter/dados/controller.dart';
import 'package:projeto_flutter/dados/repository_implements.dart';
import 'package:projeto_flutter/dados/repository_interface.dart';

class HttpBindings implements Bindings {

  @override
  void dependencies(){
    Get.put<IEmentaRepository>(EmentasHttpRepository());
    Get.put<IAutorRepository>(AutoresHttpRepsitory());
    
    Get.put(ControllerEmentas(Get.find()));
    Get.put(ControllerAutores(Get.find()));
  }
}