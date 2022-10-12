
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:gestor_fila/models/usuarios.dart';

class Filas {
  int? id_fila;
  final int? id_atual;
  final int? id_ultimo;

  DocumentReference? reference;


  Filas({this.id_fila, required this.id_atual, required this.id_ultimo});

      Filas.fromMap(Map<String, dynamic> map, {this.reference})
      : id_fila = map['id_fila'],
        id_atual = map['id_atual'],
        id_ultimo = map['id_ultimo'];


    Map<String, dynamic> toJson() =>
      {"id_fila": id_fila, "id_atual": id_atual, "fim": id_ultimo};

    Filas.fromSnapshot(QueryDocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>,
            reference: snapshot.reference);
}

