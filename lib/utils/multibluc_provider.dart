// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gerenciamento_energia_bloc/data/db/db.dart';
// import 'package:gerenciamento_energia_bloc/pages/bloc_comodos/comodo_bloc.dart';
// import 'package:gerenciamento_energia_bloc/pages/bloc_gerenciarComodo/gerenciar_comodo_bloc.dart';
// import 'package:gerenciamento_energia_bloc/pages/bloc_gerenciarComodo/gerenciar_comodo_state.dart';
// import 'package:gerenciamento_energia_bloc/pages/comodos/main_comodos_folder/main_comodos.dart';

// class MultiBlocProviderPage extends StatelessWidget {
//   const MultiBlocProviderPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.deepOrangeAccent,
//       body: RepositoryProvider(
//         create: (context) => ComodoBancodeDados.instance,
//         child: MultiBlocProvider(providers: [
//           BlocProvider<ComodoBloc>(
//             create: (context) =>
//                 ComodoBloc(database: ComodoBancodeDados.instance),
//           ),
//           BlocProvider<GerenciarComodoBloc>(
//             create: (context) =>
//                 GerenciarComodoBloc(database: ComodoBancodeDados.instance, statusS: GerenciarComodoStatusS.initial),
//           ),
//         ], child: const MainComodosPage()),
//       ),
//     );
//   }
// }
