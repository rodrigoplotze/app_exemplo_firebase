import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/tarefa.dart';
import 'login_controller.dart';

class TarefaController {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<bool> adicionar(context, Tarefa t) async {
    return true;
  }

  Future<bool> atualizar(context, uid, Tarefa t) async {
    return true;
  }

  Future<bool> excluir(context, uid) async {
    return true;
  }

  Stream<QuerySnapshot> listar() {
    var resultado = db
        .collection('tarefas')
        .where('uid', isEqualTo: LoginController().idUsuario());

    return resultado.snapshots();
  }
}
