import 'package:flutter/material.dart';
import 'package:gerenciamento_energia_bloc/pages/comodos/main_comodos_folder/components/comodosCardMP.dart';
import 'package:gerenciamento_energia_bloc/pages/comodos/main_comodos_folder/components/eletrodomesticosUsadosCardMP.dart';
import 'package:gerenciamento_energia_bloc/pages/comodos/main_comodos_folder/view/relay_gridviewComodos.dart';
import 'package:gerenciamento_energia_bloc/shared/widgets/AppDrawer_widget.dart';
import 'package:gerenciamento_energia_bloc/shared/widgets/adaptatives/adaptativeButton.dart';
import 'package:gerenciamento_energia_bloc/test/draggable_test.dart';

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
          drawer: const AppDrawerWidget(),
          body: Column(
            children: [
              ComodosCardMP(constraints: constraints),
              SizedBox(height: constraints.maxHeight * 0.015),
              ComodosGridView(
                constraints: constraints,
              ),
              EletrodomesticosMaisUsadosCard(constraints: constraints),
             
            ],
          ),
        );
      },
    );
  }
}
