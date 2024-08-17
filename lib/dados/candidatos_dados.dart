import 'package:flutter/material.dart';
import '../models/candidato.dart';

List<Candidato> candidatos = [
  Candidato(
    nome: "Affonso Candido",
    cidade: "Ji-Paraná",
    cargo: "Deputado",
    biografia: "Affonso Cândido tem como propósito trabalhar em prol dos rondonienses Deputado tem como pilares a defesa da saúde, infraestrutura, segurança e agricultura familiar. Affonso Cândido (PL) nasceu em Ji-Paraná no dia 19 de julho em 1990. Neto de Toninho da Mabel, empresário que ajudou no desenvolvimento econômico de Rondônia desde os anos de 1980. Graduado em Direito, disputou pela primeira vez um cargo eletivo em 2012 e se elegeu como o vereador aos 22 anos, em Ji-Paraná. Foi vereador por dois mandatos e se tornou o mais jovem presidente de Câmara Municipal do Estado de Rondônia, atuando por dois Biênios consecutivos. Atuou como prefeito de Ji-Paraná no ano de 2020. Por 96 dias mostrou capacidade de liderança e gestão. Em sua avaliação, conseguiu dar uma cara nova para a cidade no quesito infraestrutura, com asfaltamento, recuperação de estradas rurais, e a arborização e limpeza de ruas e bairros. Na área da saúde enfrentou um dos picos da pandemia mantendo o comércio aberto, abriu 10 leitos de UTI, fez a aquisição de ambulâncias, fez convênio com clínicas particulares para agilidade nos diagnósticos por meio de tomografias computadorizadas, e fez a montagem de uma usina de oxigênio. Em 2023, assume o seu primeiro mandato no legislativo estadual com 13.665 votos. De acordo com Affonso, seu objetivo é trabalhar pela melhoria da Saúde, infraestrutura, segurança e agricultura familiar do estado de Rondônia. O deputado é casado e tem uma filha.",
    ultimasNoticias: [
      Noticia(
        titulo: "Affonso Cândido destina 150 mil reais para o Projeto Remadas que Transformam - 28 de junho de 2024",
        descricao: "O deputado estadual, Affonso Cândido (PL), participou, nesta sexta-feira (28), do lançamento oficial do Projeto Remadas que Transformam, desenvolvido pela Fundação JiCred e Confederação Brasileira de Canoagem (CBCa). A iniciativa social e esportiva recebeu emenda do parlamentar no valor de 150 mil reais.",
        imagem: 'lib/img/destina.jpg', // Imagem da notícia
      ),
      Noticia(
        titulo: "Affonso Cândido participa da entrega de calcário à Aprodol 8, em Ji-Paraná",
        descricao: "Mais uma remessa de calcário ensacado foi entregue pelo deputado estadual Affonso Cândido (PL), para fomentar a produção da agricultura familiar. Na última sexta-feira (7) foram entregues cinco toneladas do insumo à Associação dos Pequenos Produtores Rurais da Linha 208 (Aprodol 8), em Ji-Paraná.",
        imagem: 'lib/img/calcario.jpg', // Imagem da notícia
      ),
    ],
    contatos: "Email: gabdepaffonsocandido@ale.ro.gov.br",
    facebookLink: "https://www.facebook.com/AffonsoCandidoOficial",
    instagramLink: "https://www.instagram.com/affonsocandido",
    youtubeLink: "https://www.youtube.com/@DeputadoPoubel",
    imagemPerfil: 'lib/img/affonso.jpg', // Caminho da imagem de perfil
  ),
  // Adicione mais candidatos aqui
];
