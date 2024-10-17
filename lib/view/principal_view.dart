// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../controller/login_controller.dart';
import '../controller/tarefa_controller.dart';
import '../model/tarefa.dart';
import 'components/botoes.dart';
import 'components/mensagem.dart';
import 'components/text_field.dart';

class PrincipalView extends StatefulWidget {
  const PrincipalView({super.key});

  @override
  State<PrincipalView> createState() => _PrincipalViewState();
}

class _PrincipalViewState extends State<PrincipalView> {
  var txtTitulo = TextEditingController();
  var txtDescricao = TextEditingController();
  List<Tarefa> lista = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(child: Text('Tarefas')),
            FutureBuilder<String>(
              future: LoginController().usuarioLogado(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        textStyle: TextStyle(fontSize: 12),
                      ),
                      onPressed: () {
                        efetuarLogout(context);
                      },
                      icon: Icon(Icons.exit_to_app, size: 14),
                      label: Text(snapshot.data.toString()),
                    ),
                  );
                }
                return Text('');
              },
            ),
          ],
        ),
      ),

      //
      // BODY
      //
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: TarefaController().listar(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Center(child: Text('Não foi possível conectar.'));
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
                final dados = snapshot.requireData;
                if (dados.size > 0) {
                  return ListView.builder(
                    itemCount: lista.length,
                    itemBuilder: (context, index) {
                      String uid = dados.docs[index].id;
                      dynamic item = dados.docs[index].data();
                      return Card(
                        child: ListTile(
                          leading: Icon(Icons.description),
                          title: Text(item['titulo']),
                          subtitle: Text(item['descricao']),
                          onTap: () {
                            txtTitulo.text = item['titulo'];
                            txtDescricao.text = item['descricao'];
                            salvarTarefa(context, uid: uid);
                          },
                          onLongPress: () {
                            executarExcluir(context, uid);
                          },
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: Text('Nenhuma tarefa encontrada.'));
                }
            }
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          salvarTarefa(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  //
  // ADICIONAR TAREFA
  //
  void salvarTarefa(context, {uid}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Adicionar Tarefa"),
          content: SizedBox(
            height: 250,
            width: 300,
            child: Column(
              children: [
                campoTexto('Título', txtTitulo, Icons.description),
                TextField(
                  controller: txtDescricao,
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: 'Descrição',
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actionsPadding: EdgeInsets.fromLTRB(20, 0, 20, 10),
          actions: [
            botaoCancelar('cancelar', limparCampos()),
            ElevatedButton(
              child: Text("salvar"),
              onPressed: () {
                var t = Tarefa(
                  LoginController().idUsuario().toString(),
                  txtTitulo.text,
                  txtDescricao.text,
                );
                executarSalvar(context, t, uid: uid);
              },
            ),
          ],
        );
      },
    );
  }

  limparCampos() {
    txtTitulo.clear();
    txtDescricao.clear();
    Navigator.of(context).pop();
  }

  //
  // EFETUAR LOGOUT
  //
  efetuarLogout(context) async {
    bool resultado = await LoginController().logout();

    if (resultado) {
      sucesso(context, 'Usuário desconectado com sucesso.');
      Navigator.pushReplacementNamed(context, 'login');
    } else {
      erro(context, 'Não foi possível desconectar o usuário');
    }
  }

  //
  // EXECUTAR EXCLUIR
  //
  executarExcluir(context, uid) async {
    bool resultado = await TarefaController().excluir(context, uid);
    if (resultado) {
      sucesso(context, 'Tarefa excluída com sucesso');
    } else {
      erro(context, 'ERRO: Não foi possível excluir a tarefa.}');
    }
  }

  //
  // EXECUTAR SALVAR
  //
  executarSalvar(context, Tarefa t, {uid}) async {
    bool resultado = false;

    txtTitulo.clear();
    txtDescricao.clear();
    if (uid == null) {
      resultado = await TarefaController().adicionar(context, t);
    } else {
      resultado = await TarefaController().atualizar(context, uid, t);
    }

    if (resultado) {
      sucesso(context, 'Operação realizada com sucesso');
    } else {
      erro(context, 'ERRO: Não foi possível realizar a operação.}');
    }
  }
}
