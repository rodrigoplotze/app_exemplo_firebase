// ignore_for_file: prefer_const_constructors

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import 'view/cadastrar_view.dart';
import 'view/login_view.dart';
import 'view/principal_view.dart';

void main() {
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
        'principal': (context) => PrincipalView(),
      },
    );
  }
}
