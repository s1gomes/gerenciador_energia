// import 'package:flutter/material.dart';
// import 'package:gerenciador_energia/data/dadosFixos.dart';
// import 'package:gerenciador_energia/models/comodos.dart';
// import 'package:gerenciador_energia/shared/widgets/comodosItems.dart';

// class GridViewComodos extends StatelessWidget {
//   const GridViewComodos({
//     super.key,
//     required this.comodos,
//   });
//   final List<Comodos> comodos;
//   // final List<Map<String, dynamic>>> comodos;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(
//         left: 10,
//         right: 10,
//         bottom: 5,
//         top: 5,
//       ),
//       child: Container(
//         height: 300,
//         child: GridView(
//             gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//               // maxCrossAxisExtent: 200,
//               childAspectRatio: 3 / 2,
//               crossAxisSpacing: 20,
//               mainAxisSpacing: 20,
//             ),
//             children: comodos.map((comodo) {
//               return ComodoItem(comodo: comodo);
//             }).toList()),
//       ),
//     );
//   }
// }
