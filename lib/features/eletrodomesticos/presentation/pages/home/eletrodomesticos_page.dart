
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gerenciamento_energia_bloc/features/eletrodomesticos/data/models/EletrodomesticoModel.dart';

import '../../../../../shared/widgets/AppDrawer_widget.dart';


class EletrodomesticosPage extends StatefulWidget {
  const EletrodomesticosPage({super.key});

  @override
  State<EletrodomesticosPage> createState() => _EletrodomesticosPageState();
}

class _EletrodomesticosPageState extends State<EletrodomesticosPage> {

  Future getEletrodomesticos() async {
    List<EletrodomesticoModel> eletrodomesticos = await allEletrodomesticos();
    return eletrodomesticos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Colors.green,
        title: const Text("Eletrodomésticos"),
      ),
      drawer: const AppDrawerWidget(),
      body: FutureBuilder(
          future: getEletrodomesticos(),
          builder: (context, snapshot) {
          Row(
            children: [
              Text('Adicionar eletrodoméstico'),
              IconButton(
                  onPressed: () {
                    //navegar para pagina adicionar eletrodomestico
                  }, icon: Icon(
                Icons.add,
                color: Colors.black,
              ))
            ],
          );

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: const CircularProgressIndicator(),

          );
        } else if (snapshot.hasError){
          return Center(
            child: Row(
              children: [
                Text('Error: ${snapshot.error}'),
                IconButton(
                    onPressed: () {
                  //recall fetch function
                }, icon: Icon(
                    Icons.replay_sharp,
                  color: Colors.black,
                ))
              ],
            ),
          );
        } else {
          return ListView.builder(
              itemCount: itemProvider.items.length,
              itemBuilder: (context, index) {
            final item = itemProvider.items[index];

            return ListTile(
              title: Text(item.name),
              subtitle: Text('Consumo atual: ${item.consumoAtual}'),
            );
          });
        }
      }
      ),
    );
  }
}