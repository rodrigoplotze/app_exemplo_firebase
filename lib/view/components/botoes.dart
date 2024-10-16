import 'package:flutter/material.dart';

Widget botaoCancelar(context, label) {
  return TextButton(
    onPressed: () => Navigator.pop(context),
    child: Text(label),
  );
}

Widget botaoAcao(context, label, funcao) {
  return ElevatedButton(
    style: OutlinedButton.styleFrom(
      minimumSize: const Size(140, 40),
    ),
    onPressed: () => funcao,
    child: Text(label),
  );
}

