import 'package:flutter/material.dart';
import 'package:gerenciamento_energia_bloc/features/comodos/presentation/bloc/cadastrar_comodo_bloc/comodosCardMP.dart';
import 'package:gerenciamento_energia_bloc/shared/widgets/AppDrawer_widget.dart';

import '../../bloc/cadastrar_comodo_bloc/eletrodomesticosUsadosCardMP.dart';
import '../../widgets/relay_gridviewComodos.dart';

class MainComodosPage extends StatefulWidget {
  const MainComodosPage({super.key});

  @override
  State<MainComodosPage> createState() => _MainComodosPageState();
}

class _MainComodosPageState extends State<MainComodosPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: const Text("Comodos"),
          ),
          // drawer: const AppDrawerWidget(),
          body: Column(
            children: [
              ComodosCardMP(constraints: constraints),
              SizedBox(height: constraints.maxHeight * 0.015),
              ComodosGridView(
                constraints: constraints,
              ),
              EletrodomesticosMaisUsadosCard(constraints: constraints)
            ],
          ),
        );
      },
    );
  }
}
