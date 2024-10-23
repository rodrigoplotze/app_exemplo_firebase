// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../controller/login_controller.dart';
import '../controller/tarefa_controller.dart';
import '../model/tarefa.dart';
import 'components/text_field.dart';

class PrincipalView extends StatefulWidget {
  const PrincipalView({super.key});

  @override
  State<PrincipalView> createState() => _PrincipalViewState();
}

class _PrincipalViewState extends State<PrincipalView> {
  var txtTitulo = TextEditingController();
  var txtDescricao = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Expanded(
                child: Text(
              'Tarefas',
              style: TextStyle(color: Colors.white),
            )),
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
                        LoginController().logout();
                      },
                      icon: Icon(Icons.exit_to_app, size: 22),
                      label: Text(
                        snapshot.data.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
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
        child: Center(
          child: StreamBuilder<QuerySnapshot>(
            stream: TarefaController().listar(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Center(
                    child: Text('Não foi possível conectar.'),
                  );
                case ConnectionState.waiting:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                default:
                  final dados = snapshot.requireData;
                  if (dados.size > 0) {
                    return ListView.builder(
                      itemCount: dados.size,
                      itemBuilder: (context, index) {
                        String id = dados.docs[index].id;
                        dynamic item = dados.docs[index].data();
                        return Card(
                          child: ListTile(
                            leading: Icon(Icons.description),
                            title: Text(item['titulo']),
                            subtitle: Text(item['descricao']),
                            onTap: () {
                              txtTitulo.text = item['titulo'];
                              txtDescricao.text = item['descricao'];
                              salvarTarefa(context, uid: id);
                            },
                            onLongPress: () {
                              TarefaController().excluir(context, id);
                            },
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Text('Nenhuma tarefa encontrada.'),
                    );
                  }
              }
            },
          ),
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
            TextButton(
              onPressed: () => limparCampos(),
              child: Text('cancelar'),
            ),
            ElevatedButton(
              child: Text("salvar"),
              onPressed: () {
                var t = Tarefa(
                  LoginController().idUsuario().toString(),
                  txtTitulo.text,
                  txtDescricao.text,
                );

                txtTitulo.clear();
                txtDescricao.clear();
                if (uid == null) {
                  TarefaController().adicionar(context, t);
                } else {
                  TarefaController().atualizar(context, uid, t);
                }
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
}
