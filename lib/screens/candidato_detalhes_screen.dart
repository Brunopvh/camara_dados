import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/candidato.dart';
import 'biografia_detalhes_screen.dart';
import 'ultimas_noticias_screen.dart'; // Certifique-se de que o caminho está correto
import 'contatos_detalhes_screen.dart';

class CandidatoDetalhesScreen extends StatelessWidget {
  final Candidato candidato;

  CandidatoDetalhesScreen({required this.candidato});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(candidato.nome),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Volta para a tela anterior
          },
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'lib/img/fundo.jpg',
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage(candidato.imagemPerfil),
                  ),
                ),
                SizedBox(height: 16.0),
                Center(
                  child: Text(
                    candidato.nome,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                SizedBox(height: 25.0),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BiografiaDetalhesScreen(
                          biografia: candidato.biografia,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.yellow, width: 2),
                      borderRadius: BorderRadius.circular(25.0),
                      color: Colors.transparent,
                    ),
                    child: Text(
                      'Biografia',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 25.0),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContatosDetalhesScreen(
                          contatos: candidato.contatos,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.yellow, width: 2),
                      borderRadius: BorderRadius.circular(25.0),
                      color: Colors.transparent,
                    ),
                    child: Text(
                      'Contatos',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 25.0),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UltimasNoticiasScreen(
                          noticias: candidato.ultimasNoticias, // Corrigido
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.yellow, width: 2),
                      borderRadius: BorderRadius.circular(25.0),
                      color: Colors.transparent,
                    ),
                    child: Text(
                      'Últimas Notícias',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 80.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        if (await canLaunch(candidato.facebookLink)) {
                          await launch(candidato.facebookLink);
                        } else {
                          throw 'Não foi possível abrir o link ${candidato.facebookLink}';
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Image.asset(
                          'lib/img/iconfacebook.png',
                          width: 40,
                          height: 40,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.error, color: Colors.red);
                          },
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (await canLaunch(candidato.instagramLink)) {
                          await launch(candidato.instagramLink);
                        } else {
                          throw 'Não foi possível abrir o link ${candidato.instagramLink}';
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Image.asset(
                          'lib/img/iconinstagram.png',
                          width: 40,
                          height: 40,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.error, color: Colors.red);
                          },
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (await canLaunch(candidato.youtubeLink)) {
                          await launch(candidato.youtubeLink);
                        } else {
                          throw 'Não foi possível abrir o link ${candidato.youtubeLink}';
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Image.asset(
                          'lib/img/iconyoutube.png',
                          width: 40,
                          height: 40,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.error, color: Colors.red);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
