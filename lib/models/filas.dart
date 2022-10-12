
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:gestor_fila/models/usuarios.dart';

class Filas {
  int? id_atual;
  String doc_user;

  DocumentReference? reference;


  Filas({required this.id_atual, required this.doc_user});

      Filas.fromMap(Map<String, dynamic> map, {this.reference})
      : id_atual = map['id_atual'],
        doc_user = map['doc_user'];


    Map<String, dynamic> toJson() =>
      {"id_atual": id_atual, "doc_user": doc_user};

    Filas.fromSnapshot(QueryDocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>,
            reference: snapshot.reference);
}

