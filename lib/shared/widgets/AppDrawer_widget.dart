import 'package:flutter/material.dart';
import 'package:gerenciamento_energia_bloc/features/comodos/presentation/pages/home/main_comodos.dart';

class AppDrawerWidget extends StatelessWidget {
  const AppDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(children: [
      AppBar(
        title: const Text('Bem vindo usuário!'),
        automaticallyImplyLeading: false,
      ),
      const Divider(),
      ListTile(
        leading: const Icon(Icons.shop),
        title: const Text('Gerenciar'),
        onTap: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const MainComodosPage()));
        },
      ),
      const Divider(),
      ListTile(
          leading: const Icon(Icons.shop),
          title: const Text('Estatistica'),
          onTap: () {
            // Navigator.of(context).pushReplacementNamed(AppRoutes.ESTATISTICA);
          })
    ]));
  }
}
          
          // Divider(),
          // ListTile(
          //   leading: Icon(Icons.delivery_dining),
          //   title: Text('Pedidos'),
          //   onTap: () {
          //     Navigator.of(context).pushReplacementNamed(AppRoutes.ORDERS);
          //   },
          // ),
          // Divider(),
          // ListTile(
          //   leading: Icon(Icons.edit),
          //   title: Text('Gerenciar Produtos'),
          //   onTap: () {
          //     Navigator.of(context).pushReplacementNamed(AppRoutes.PRODUCTS);
          //   },
          // )
