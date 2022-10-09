import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:gestor_fila/models/usuarios.dart';

class filas {
  int? id;
  final int lugar;
  final Usuario user;

  filas({this.id, required this.lugar, required this.user});
}
