import 'package:flutter/material.dart';

import 'package:gerenciamento_energia_bloc/shared/widgets/compartmentalization/containers/texrcardContainers/textCardContainer.dart';
import 'package:gerenciamento_energia_bloc/shared/widgets/compartmentalization/text/textoCardAtualizacao.dart';

class EletrodomesticosMaisUsadosCard extends StatelessWidget {
  const EletrodomesticosMaisUsadosCard({super.key, required this.constraints});
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
        Container(
          width: constraints.maxWidth * 0.98,
          height: constraints.maxHeight * 0.07,
          child: Card(
            elevation: 3,
            child: TextCardContainer(
              constraints: constraints,
              titleController: "Eletrodomésticos mais custosos",
            ),
          ),
        ),
        const TextSemCadastros(
            frase: "Ainda não há eletrodomésticos cadastrados."),
      ],
    );
  }
}
