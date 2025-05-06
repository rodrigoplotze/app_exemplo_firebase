import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../view/components/mensagem.dart';

class LoginController extends ChangeNotifier {
  var txtNome = TextEditingController();
  var txtEmail = TextEditingController();
  var txtSenha = TextEditingController();
  var txtEmailEsqueceuSenha = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;

  //
  // Criação de um nova conta de usuário
  // no Firebase Authentication
  //
  void criarConta(context) {
    try {} on FirebaseAuthException catch (e) {
      String mensagem;
      switch (e.code) {
        case 'email-already-in-use':
          mensagem = 'Este e-mail já está em uso.';
          break;
        case 'invalid-email':
          mensagem = 'E-mail inválido.';
          break;
        case 'weak-password':
          mensagem = 'A senha deve conter pelo menos 6 caracteres.';
          break;
        default:
          mensagem = 'Erro: ${e.message}';
      }

      erro(context, mensagem);
    } catch (e) {
      // Erro genérico
      erro(context, 'Erro inesperado. Tente novamente.');
    }
  }

  //
  // LOGIN
  // Efetuar o login de um usuário previamente cadastrado
  // no serviço Firebase Authentication
  //
  void login(context) {
    try {
      //
      // TO-DO
      //
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'invalid-email':
          message = 'O e-mail informado é inválido.';
          break;
        case 'user-disabled':
          message = 'Este usuário foi desativado.';
          break;
        case 'user-not-found':
          message = 'Usuário não encontrado.';
          break;
        case 'wrong-password':
          message = 'Senha incorreta.';
          break;
        default:
          message = 'Erro desconhecido: ${e.message}';
      }
      erro(context, message);
    }
  }

  //
  // ESQUECEU A SENHA
  // Envia uma mensagem de email para recuperação de senha para
  // um conta de email válida
  //
  void esqueceuSenha(context, String email) {
    try {
      //
      // TO-DO
      //
    } on FirebaseAuthException catch (e) {
      String mensagem;
      switch (e.code) {
        case 'invalid-email':
          mensagem = 'O e-mail informado é inválido.';
          break;
        case 'user-not-found':
          mensagem = 'Nenhum usuário encontrado com este e-mail.';
          break;
        default:
          mensagem = 'Erro: ${e.message}';
      }
      erro(context, mensagem);
    } catch (e) {
      erro(context, 'Erro inesperado. Tente novamente mais tarde.');
    }
  }

  //
  // LOGOUT
  //
  logout(context) {
    try {
      //
      // TO-DO
      //
      // Após logout, você pode navegar para a tela de login, por exemplo:
      Navigator.of(context).pushReplacementNamed('/login');
    } catch (e) {
      erro(context, 'Não foi possível efetuar logout');
    }
  }

  //
  // ID do Usuário Logado
  //
  String? idUsuario() {
    final user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }

  //
  // NOME do Usuário Logado
  //
  Future<String> usuarioLogado() async {
    return "";
  }
}
