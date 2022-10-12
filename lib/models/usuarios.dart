import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  int? id;
  final String nome;
  final String email;
  final String telefone;
  final bool admin;

  DocumentReference? reference;

  Usuario(
      {this.id,
      required this.nome,
      required this.email,
      required this.telefone,
      required this.admin});

  Usuario.fromMap(Map<String, dynamic> map, {this.reference})
      : nome = map['nome'],
        email = map['email'],
        telefone = map['telefone'],
        admin = map['admin'];

  Usuario.fromSnapshot(QueryDocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>,
            reference: snapshot.reference);

  factory Usuario.fromJson(DocumentSnapshot docSnapshot) {
    return Usuario(
      nome: docSnapshot.get('nome'),
      email: docSnapshot.get('email'),
      telefone: docSnapshot.get('telefone'),
      admin: docSnapshot.get('admin'),
    );
  }

  Map<String, dynamic> toJson() =>
      {"nome": nome, "email": email, "telefone": telefone, "admin": admin};
}
