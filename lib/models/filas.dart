
import 'package:cloud_firestore/cloud_firestore.dart';

class Filas {
  int? pos_atual;
  int? ultima_pos;

  DocumentReference? reference;


  Filas({this.pos_atual, required this.ultima_pos});

      Filas.fromMap(Map<String, dynamic> map, {this.reference})
      : pos_atual = map['pos_atual'],
        ultima_pos = map['ultima_pos'];


    Map<String, dynamic> toJson() =>
      {"pos_atual": pos_atual, "ultima_pos": ultima_pos};

    Filas.fromSnapshot(QueryDocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>,
            reference: snapshot.reference);
}

