import 'package:flutter/material.dart';
import '../models/candidato.dart';

class UltimasNoticiasScreen extends StatelessWidget {
  final List<Noticia> noticias;

  UltimasNoticiasScreen({required this.noticias});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Últimas Notícias'),
      ),
      body: ListView.builder(
        itemCount: noticias.length,
        itemBuilder: (context, index) {
          final noticia = noticias[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset(noticia.imagem), // Imagem da notícia
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    noticia.titulo,
                    style: TextStyle(
                      fontSize: 20, // Tamanho do texto
                      fontWeight: FontWeight.bold, // Negrito
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    noticia.descricao,
                    style: TextStyle(
                      fontSize: 16, // Tamanho do texto
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
