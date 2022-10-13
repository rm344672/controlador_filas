
import 'package:cloud_firestore/cloud_firestore.dart';

class Filas {
  int? pos_atual;
  int? ultima_pos;

  DocumentReference? reference;


  Filas({this.pos_atual, required this.ultima_pos});

      Filas.fromMap(Map<String, dynamic> map, {this.reference})
      : pos_atual = map['id_atual'],
        ultima_pos = map['doc_user'];


    Map<String, dynamic> toJson() =>
      {"id_atual": pos_atual, "doc_user": ultima_pos};

    Filas.fromSnapshot(QueryDocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>,
            reference: snapshot.reference);
}

