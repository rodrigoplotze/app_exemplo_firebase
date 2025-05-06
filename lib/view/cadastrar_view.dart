// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../controller/login_controller.dart';
import 'components/botoes.dart';
import 'components/text_field.dart';

class CadastrarView extends StatefulWidget {
  const CadastrarView({super.key});

  @override
  State<CadastrarView> createState() => _CadastrarViewState();
}

class _CadastrarViewState extends State<CadastrarView> {
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
              'Criar Conta',
              style: TextStyle(fontSize: 60),
            ),
            SizedBox(height: 60),
            campoTexto('Nome', ctrl.txtNome, Icons.person),
            campoTexto('Email', ctrl.txtEmail, Icons.email),
            campoTexto('Senha', ctrl.txtSenha, Icons.password, senha: true),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                botaoCancelar(context, 'cancelar'),
                ElevatedButton(
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(140, 40),
                  ),
                  onPressed: () {
                    //
                    // TO-DO: Criar Conta
                    //
                    ctrl.criarConta(context);
                  },
                  child: Text('salvar'),
                ),
              ],
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
