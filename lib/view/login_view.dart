// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../controller/login_controller.dart';
import 'components/botoes.dart';
import 'components/text_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  
  final ctrl = GetIt.I.get<LoginController>();

  @override
  void initState() {
    super.initState();
    ctrl.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 50, 30, 50),
        child: Column(
          children: [
            Text(
              'Login',
              style: TextStyle(fontSize: 60),
            ),
            SizedBox(height: 60),
            campoTexto('Email', ctrl.txtEmail, Icons.email),
            campoTexto('Senha', ctrl.txtSenha, Icons.password, senha: true),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Esqueceu a senha?"),
                        content: Container(
                          height: 150,
                          child: Column(
                            children: [
                              Text(
                                "Identifique-se para receber um e-mail com as instruções e o link para criar uma nova senha.",
                              ),
                              SizedBox(height: 25),
                              campoTexto(
                                'Email',
                                ctrl.txtEmailEsqueceuSenha,
                                Icons.email,
                              ),
                            ],
                          ),
                        ),
                        actionsPadding: EdgeInsets.all(20),
                        actions: [
                          botaoCancelar(context, 'cancelar'),
                          ElevatedButton(
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size(140, 40),
                            ),
                            onPressed: () {
                              ctrl.esqueceuSenha(context);
                            },
                            child: Text('enviar'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('Esqueceu a senha?'),
              ),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(140, 40),
              ),
              onPressed: () {
                //
                // TO-DO: Login
                //
                ctrl.login(context);
              },
              child: Text('entrar'),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Ainda não tem conta?'),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'cadastrar');
                  },
                  child: Text('Cadastre-se'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
