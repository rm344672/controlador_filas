import 'dart:ffi';

import 'package:gestor_fila/models/user.dart';

class filas {
  int? id;
  final int lugar;
  final User user;

  filas({
    this.id,
    required this.lugar,
    required this.user
  });
}