import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../view/components/mensagem.dart';

class LoginController {
  final FirebaseAuth auth = FirebaseAuth.instance;

  //
  // Criação de um nova conta de usuário
  // no Firebase Authentication
  //
  void criarConta(context, nome, email, senha) {
   
  }

  //
  // LOGIN
  // Efetuar o login de um usuário previamente cadastrado
  // no serviço Firebase Authentication
  //
  void login(context, email, senha) {

  }

  //
  // ESQUECEU A SENHA
  // Envia uma mensagem de email para recuperação de senha para
  // um conta de email válida
  //
  void esqueceuSenha(context, String email) {
  }

  //
  // LOGOUT
  //
  logout() {}

  //
  // ID do Usuário Logado
  //
  idUsuario() {
    return "";
  }

  //
  // NOME do Usuário Logado
  //
  Future<String> usuarioLogado() async {
    return "";
  }
}
