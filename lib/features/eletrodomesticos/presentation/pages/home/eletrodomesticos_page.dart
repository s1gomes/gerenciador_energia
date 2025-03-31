
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../shared/widgets/AppDrawer_widget.dart';
import '../../../data/data_sources/database/EletrodomesticoDatabaseHelper.dart';


class EletrodomesticosPage extends StatefulWidget {
  const EletrodomesticosPage({super.key});

  @override
  State<EletrodomesticosPage> createState() => _EletrodomesticosPageState();
}

class _EletrodomesticosPageState extends State<EletrodomesticosPage> {

  var database;

  @override
  void initState() {
    database = EletroDatabaseHelper().getAllEletrodomesticos();
    // Call event to get ny times article

    super.initState();
  }
  // Future getEletrodomesticos() async {
  //   List<EletrodomesticoModel> eletrodomesticos = await getAllEletrodomesticos();
  //   return eletrodomesticos;
  // }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Colors.green,
        title: const Text("Eletrodomésticos"),
      ),
      // drawer: const AppDrawerWidget(),
      body: FutureBuilder(
          future: database,
          builder: (context, snapshot) {
          Row(
            children: [
              const Text('Adicionar eletrodoméstico'),
              IconButton(
                  onPressed: () {
                    //navegar para pagina adicionar eletrodomestico
                  }, icon: const Icon(
                Icons.add,
                color: Colors.black,
              ))
            ],
          );

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),

          );
        } else if (snapshot.hasError){
          print("${snapshot.hasError}");
          return Center(
            child: Row(
              children: [
                Text('Error: ${snapshot.error}'),

                IconButton(
                    onPressed: () {
                  //recall fetch function
                }, icon: const Icon(
                    Icons.replay_sharp,
                  color: Colors.black,
                ))
              ],
            ),
          );
        } else {
          return ListView.builder(
              itemCount: database.items.length,
              itemBuilder: (context, index) {
            final item = database.items[index];

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