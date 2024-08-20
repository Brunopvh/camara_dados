class Noticia {
  final String titulo;
  final String descricao;
  final String imagem;

  Noticia({
    required this.titulo,
    required this.descricao,
    required this.imagem,
  });
}

class Candidato {
  final String nome;
  final String cidade;
  final String cargo;
  final String biografia;
  final List<Noticia> ultimasNoticias;  // Alterado para lista de notícias
  final String contatos;
  final String facebookLink;
  final String instagramLink;
  final String youtubeLink;
  final String imagemPerfil;

  Candidato({
    required this.nome,
    required this.cidade,
    required this.cargo,
    required this.biografia,
    required this.ultimasNoticias,
    required this.contatos,
    required this.facebookLink,
    required this.instagramLink,
    required this.youtubeLink,
    required this.imagemPerfil,
  });
}
