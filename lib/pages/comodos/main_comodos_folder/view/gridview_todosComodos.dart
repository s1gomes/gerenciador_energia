import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gerenciamento_energia_bloc/data/db/db.dart';
import 'package:gerenciamento_energia_bloc/pages/bloc_comodos/comodo_bloc.dart';
import 'package:gerenciamento_energia_bloc/pages/bloc_comodos/comodo_event.dart';
import 'package:gerenciamento_energia_bloc/pages/bloc_comodos/comodo_state.dart';
import 'package:gerenciamento_energia_bloc/pages/bloc_gerenciarComodo/gerenciar_comodo_bloc.dart';
import 'package:gerenciamento_energia_bloc/pages/bloc_gerenciarComodo/gerenciar_comodo_event.dart';
import 'package:gerenciamento_energia_bloc/pages/comodos/main_comodos_folder/components/gerenciarComodos.dart';

enum FilterOptions { Deletar, Editar }

class GridviewTodosComodos extends StatefulWidget {
  const GridviewTodosComodos(
      {super.key, required this.constraints, required this.dados});
  final BoxConstraints constraints;
  final List dados;

  @override
  State<GridviewTodosComodos> createState() => _GridviewTodosComodosState();
}

class _GridviewTodosComodosState extends State<GridviewTodosComodos> {
  void _selectComodo(
    BuildContext context,
    comodoImageUrl,
    comodoNome,
    comodoId,
  ) {
    context.read<GerenciarComodoBloc>().add(AlterStateShowImage());
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => GerenciarComodosPage(
                comodoId: comodoId,
                comodoImageUrl: comodoImageUrl,
                comodoNome: comodoNome,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3, left: 15, right: 15, top: 3),
      child: Container(
        height: widget.constraints.maxHeight * 0.3,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 300,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemCount: widget.dados.length,
          itemBuilder: (context, dadosIndex) {
            final dadosComodo = widget.dados[dadosIndex];
            String comodoImageUrl = dadosComodo['urlImageComodo'].toString();

            String comodoNome = dadosComodo['nomeComodo'].toString();
            int comodoId = dadosComodo['idComodo'].toInt();

            return InkWell(
              onTap: () => _selectComodo(
                context,
                comodoImageUrl,
                comodoNome,
                comodoId,
              ),
              splashColor: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(15),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(comodoImageUrl),
                      onError: (exception, stackTrace) {
                        print("erro imagem gridview $exception");
                        print("imagem gridview ${comodoImageUrl}");
                        Image.asset(
                          "assets/images/product_image_not_available.png",
                          fit: BoxFit.cover,
                        );
                      },
                      fit: BoxFit.fill,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.4), BlendMode.dstATop),
                    ),
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(colors: [
                      Theme.of(context).cardColor,
                      Theme.of(context).canvasColor,
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                child: Container(
                  alignment: Alignment.bottomRight,
                  color: const Color.fromRGBO(225, 218, 218, 0.306),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        comodoNome,
                        style: Theme.of(context).textTheme.titleSmall,
                        textAlign: TextAlign.left,
                      ),
                      PopupMenuButton(
                        itemBuilder: (_) => [
                          const PopupMenuItem(
                            value: FilterOptions.Deletar,
                            child: Text('Deletar cômodo'),
                          ),
                          // implementar tela de confirmação pra deletar
                          const PopupMenuItem(
                            value: FilterOptions.Editar,
                            child: Text('Editar Cômodo'),
                          ),
                        ],
                        onSelected: (FilterOptions selectedValue) {
                          setState(() {
                            if (selectedValue == FilterOptions.Deletar) {
                              ComodoBancodeDados.instance
                                  .deletarCampo(comodoId)
                                  .then((value) => context
                                      .read<ComodoBloc>()
                                      .add(GetComodos()));
                            } else {
                              _selectComodo(
                                context,
                                comodoImageUrl,
                                comodoNome,
                                comodoId,
                              );
                            }
                          });
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
