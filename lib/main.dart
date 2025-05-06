// ignore_for_file: prefer_const_constructors

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'controller/login_controller.dart';
import 'controller/tarefa_controller.dart';
import 'view/cadastrar_view.dart';
import 'view/login_view.dart';
import 'view/tarefa_view.dart';

final g = GetIt.instance;

void main() {
  g.registerSingleton<LoginController>(LoginController());
  g.registerSingleton<TarefaController>(TarefaController());

  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MainView(),
    ),
  );
}

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista Tarefas',
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'cadastrar': (context) => CadastrarView(),
        'login': (context) => LoginView(),
        'principal': (context) => TarefaView(),
      },
    );
  }
}
