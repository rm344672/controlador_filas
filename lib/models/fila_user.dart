import 'package:cloud_firestore/cloud_firestore.dart';

class FilaUser {
  int? pos_fila;
  final String? doc_user;

  DocumentReference? reference;

  FilaUser({this.pos_fila, required this.doc_user});

  FilaUser.fromMap(Map<String, dynamic> map, {this.reference})
    : pos_fila = map['pos_fila'],
    doc_user = map['doc_user'];

  Map<String, dynamic> toJson() =>
    {"pos_fila": pos_fila, "doc_user": doc_user};
 
  FilaUser.fromSnapshot(QueryDocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>,
            reference: snapshot.reference);
}