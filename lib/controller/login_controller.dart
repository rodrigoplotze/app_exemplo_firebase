class LoginController {
  //
  // Criação de um nova conta de usuário
  // no Firebase Authentication
  //
  Future<bool> criarConta(nome, email, senha) async {
    return true;
  }

  //
  // LOGIN
  // Efetuar o login de um usuário previamente cadastrado
  // no serviço Firebase Authentication
  //
  Future<bool> login(email, senha) async {
    return true;
  }

  //
  // ESQUECEU A SENHA
  // Envia uma mensagem de email para recuperação de senha para
  // um conta de email válida
  //
  Future<bool> esqueceuSenha(String email) async {
    return true;
  }

  //
  // LOGOUT
  //
  Future<bool> logout() async{
    return true;
  }

  //
  // ID do Usuário Logado
  //
  Future<String> idUsuario() async{
    return "";
  }

  //
  // NOME do Usuário Logado
  //
  Future<String> usuarioLogado() async {
    return "";
  }
}
