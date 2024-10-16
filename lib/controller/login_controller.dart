class LoginController {
  //
  // Criação de um nova conta de usuário
  // no Firebase Authentication
  //
  criarConta(context, nome, email, senha) {}

  //
  // LOGIN
  // Efetuar o login de um usuário previamente cadastrado
  // no serviço Firebase Authentication
  //
  login(context, email, senha) {}

  //
  // ESQUECEU A SENHA
  // Envia uma mensagem de email para recuperação de senha para
  // um conta de email válida
  //
  esqueceuSenha(context, String email) {}

  //
  // LOGOUT
  //
  logout() {}

  //
  // ID do Usuário Logado
  //
  idUsuario() {}

  //
  // NOME do Usuário Logado
  //
  Future<String> usuarioLogado() async {
    return "";
  }
}
