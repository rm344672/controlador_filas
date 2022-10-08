class User {
  int? id;
  final String nome;
  final String email;
  final String senha;
  final String celular;

  User({
    this.id,
    required this.nome,
    required this.email,
    required this.senha,
    required this.celular,
  });
}