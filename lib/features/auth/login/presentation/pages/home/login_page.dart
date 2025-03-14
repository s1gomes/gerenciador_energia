import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gerenciamento_energia_bloc/features/comodos/presentation/pages/home/main_comodos.dart';
import '../../../../../comodos/presentation/bloc/bloc_comodos/comodo_bloc.dart';
import '../../../../../comodos/presentation/bloc/bloc_comodos/comodo_event.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 213, 212, 209),
      appBar: AppBar(
        title: Text("Comodos"),
        // leading: IconButton(onPressed: () {
        //
        // }, icon: const Icon(
        //   Icons.arrow_back,
        //   color: Colors.black,
        // ),
        // ),
        actions: [

        ],
      ),

      body: Column(
        children: [
          Container(
            height: 100,
            width: double.infinity,
            decoration: const BoxDecoration(color: Colors.black),
          ),
          const SizedBox(
            height: 300,
          ),
          Center(
            child: GestureDetector(
              onTap: () async {
                setState(() {
                  loading = true;
                  context.read<ComodoBloc>().add(GetComodos());
                });

                // List allComodos =
                //     await ComodoBancodeDados.instance.recuperarTodos();
                Future.delayed(const Duration(milliseconds: 500), () {
                  loading = false;
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainComodosPage(),
                      ));
                });
              },
              child: Column(
                children: [
                  Container(
                    height: 50,
                    width: 100,
                    decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(18)),
                        shape: BoxShape.rectangle),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 12.0, right: 8),
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          // height: 50,
                          // width: 25,
                          child: loading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Icon(
                                  Icons.login,
                                  color: Colors.white,
                                ),
                        ),
                      ],
                    ),
                  ),
                  //  AdaptativeButton(
                  // label: "Draggable",
                  // onPressed: () {
                  //   Navigator.pushReplacement(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => const DraggableTest(),
                  //       ));
                  // }),
                  //  AdaptativeButton(
                  // label: "DragStayTest",
                  // onPressed: () {
                  //   Navigator.pushReplacement(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => const DragStayTest(),
                  //       ));
                  // }),
                  //  AdaptativeButton(
                  // label: "DragStayTargetTest",
                  // onPressed: () {
                  //   Navigator.pushReplacement(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => const DragStayTargetTest(),
                  //       ));
                  // })

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
