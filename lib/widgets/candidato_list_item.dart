import 'package:flutter/material.dart';
import '../models/candidato.dart';

class CandidatoListItem extends StatelessWidget {
  final Candidato candidato;

  CandidatoListItem({required this.candidato});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(candidato.nome),
      subtitle: Text('${candidato.cidade} - ${candidato.cargo}'),
    );
  }
}
