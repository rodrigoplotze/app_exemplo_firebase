import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/tarefa.dart';
import 'login_controller.dart';

class TarefaController {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  adicionar(context, Tarefa t) {}

  atualizar(context, uid, Tarefa t) {}

  excluir(context, uid) {}

  Stream<QuerySnapshot> listar() {
    var resultado = db
        .collection('tarefas')
        .where('uid', isEqualTo: LoginController().idUsuario());

    return resultado.snapshots();
  }
}
