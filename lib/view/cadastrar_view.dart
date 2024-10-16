// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';

import '../controller/login_controller.dart';
import 'components/botoes.dart';
import 'components/mensagem.dart';
import 'components/text_field.dart';

class CadastrarView extends StatefulWidget {
  const CadastrarView({super.key});

  @override
  State<CadastrarView> createState() => _CadastrarViewState();
}

class _CadastrarViewState extends State<CadastrarView> {
  var txtNome = TextEditingController();
  var txtEmail = TextEditingController();
  var txtSenha = TextEditingController();

  @override
  void initState() {
    super.initState();
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
            campoTexto('Nome', txtNome, Icons.person),
            campoTexto('Email', txtEmail, Icons.email),
            campoTexto('Senha', txtSenha, Icons.password, senha: true),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                botaoCancelar(context, 'cancelar'),
                botaoAcao(
                  context,
                  'salvar',
                  criarConta(context),
                ),
              ],
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  //
  // CRIAR CONTA DO USUÁRIO
  //
  criarConta(context) async {
    bool resultado = await LoginController().criarConta(
      txtNome.text,
      txtEmail.text,
      txtSenha.text,
    );

    if (resultado) {
      sucesso(context, 'Usuário criado com sucesso.');
      Navigator.pop(context);
    } else {
      erro(context, 'Não foi possível criar o usuário.');
    }
  }
}
