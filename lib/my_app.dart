import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gerenciamento_energia_bloc/data/db/db.dart';
import 'package:gerenciamento_energia_bloc/login/login_page.dart';
import 'package:gerenciamento_energia_bloc/pages/bloc_comodos/comodo_bloc.dart';
import 'package:gerenciamento_energia_bloc/pages/bloc_comodos/comodo_state.dart';
import 'package:gerenciamento_energia_bloc/pages/bloc_gerenciarComodo/gerenciar_comodo_bloc.dart';
import 'package:gerenciamento_energia_bloc/pages/bloc_gerenciarComodo/gerenciar_comodo_state.dart';
import 'package:gerenciamento_energia_bloc/pages/comodos/main_comodos_folder/main_comodos.dart';
import 'package:gerenciamento_energia_bloc/utils/multibluc_provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  static MaterialColor green =
      const MaterialColor(_greenPrimaryValue, <int, Color>{
    50: Color(0xFF4CAF50),
    100: Color(0xFF43A047),
    200: Color(0xFF388E3C),
    300: Color(_greenPrimaryValue),
    500: Color(0xFF1B5E20),
    600: Color(0xFF2196F3),
    700: Color(0xFF1E88E5),
    800: Color(0xFF1976D2),
    900: Color(0xFF1565C0),
  });
  static const int _greenPrimaryValue = 0xFF2E7D32;

  @override
  State<MyApp> createState() => _MyAppState();
}

//  RepositoryProvider(
//         create: (context) => ComodoBancodeDados.instance,

class _MyAppState extends State<MyApp> {
  // List<Comodos> todosComodos = comodosCategorias;
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ComodoBancodeDados.instance,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ComodoBloc>(
            create: (context) =>
                ComodoBloc(database: ComodoBancodeDados.instance),
          ),
          BlocProvider<GerenciarComodoBloc>(
            create: (context) =>
                GerenciarComodoBloc(database: ComodoBancodeDados.instance),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const LoginPage(),
          title: 'Gerenciador de energia',
          theme: ThemeData(
              primarySwatch: MyApp.green,
              canvasColor: const Color.fromARGB(255, 195, 239, 189),
              cardColor: const Color.fromARGB(255, 201, 232, 196),
              colorScheme: ColorScheme.fromSeed(
                error: Colors.red,
                seedColor: const Color.fromARGB(255, 213, 227, 210),
                background: const Color.fromARGB(255, 242, 247, 241),
              ),
              useMaterial3: true,
              textTheme: ThemeData.light().textTheme.copyWith(
                  titleSmall: const TextStyle(
                      fontSize: 20, fontFamily: 'RobotoCondensed'))),
        ),
      ),
    );
  }
}
