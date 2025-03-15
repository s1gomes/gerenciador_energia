
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../comodos/presentation/pages/home/main_comodos.dart';
import '../../../../eletrodomesticos/presentation/pages/home/eletrodomesticos_page.dart';
import '../../../../estatisticas/presentation/pages/estatistica_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        // Badge(child: Icon(Icons.notifications_sharp)),
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Cômodos',
          ),
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: 'Eletrodomésticos',
          ),
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: 'Estatísticas',
          ),
        ],
      ),
      body:
      <Widget>[

        const MainComodosPage(),
        const EletrodomesticosPage(),
        const EstatisticaPage(),

      ][currentPageIndex],
    );
  }
}