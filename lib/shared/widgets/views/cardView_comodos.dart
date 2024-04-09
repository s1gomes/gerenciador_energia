// import 'package:flutter/material.dart';
// import 'package:gerenciador_energia/data/dadosFixos.dart';
// import 'package:gerenciador_energia/models/comodos.dart';
// import 'package:gerenciador_energia/shared/widgets/comodosItems.dart';
// import 'package:gerenciador_energia/utils/app_routes.dart';

// class CardViewComodo extends StatelessWidget {
//   const CardViewComodo({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//         children: comodosCategorias.map((comodo) {
//       return ListView.builder(
//         itemCount: comodosCategorias.length,
//         itemBuilder: (context, index) {
//           Container(
//             child: Row(children: [
//               if (comodosCategorias.isEmpty)
//               ComodoItem(comodo: comodo) ??
//               const Text("Ainda não há comodos cadastrados")  
//             ]),
//           );
//         },
//       );
//     }).toList());
//   }
// }

//     // return ListView.builder(
//     //   itemCount: ,
//     //   itemBuilder: (context, index) {
//     //     Container(
//     //       child: Row(
//     //         children: comodosCategorias.map((comodo) {
//     //         return ComodoItem(comodo: comodo);
//     //         }).toList()
//     //       ),
//     //     );
        
//     //   },
//     // );