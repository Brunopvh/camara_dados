// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projeto_flutter/dados/bindings.dart';
import 'package:projeto_flutter/dados/candidatos_dados.dart';
import 'package:projeto_flutter/models/candidato.dart';
import 'package:projeto_flutter/models/models_dados.dart';
import 'screens/candidato_screen.dart'; // Verifique se o caminho está correto

String app_version = '1.0';

void main() {
  downloadBaseOnline();
  runApp(MyApp(candidatos: deputados,));
}

class MyApp extends StatelessWidget {
  
  late List<Candidato> candidatos;
  MyApp({required this.candidatos});
  
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(
          name: '/', 
          page: () => MyHomePage(candidatos: this.candidatos,),
          binding: HttpBindings(),
        ),  
      ],

      title: 'Visualizador de Candidatos',
      theme: ThemeData(primarySwatch: Colors.blue,),
      );
  
  }
}
