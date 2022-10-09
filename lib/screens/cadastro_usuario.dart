import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gestor_fila/models/usuarios.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CadastroWidget extends StatefulWidget {
  const CadastroWidget({Key? key}) : super(key: key);

  @override
  State<CadastroWidget> createState() => _CadastroWidgetState();
}

class _CadastroWidgetState extends State<CadastroWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(700, 1400));
    return Scaffold(
        appBar: AppBar(
          title: const Text("Cadastro de Usuários"),
        ),
        body: Center(
            child: Form(
                key: _formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Nome', hintText: 'Digite seu nome'),
                            controller: _nomeController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Insira o nome do usuário";
                              }
                              return null;
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 15, bottom: 0),
                        child: TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Email',
                                hintText: 'Digite a seu email'),
                            controller: _emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Insira o email do usuário";
                              }
                              return null;
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 15, bottom: 0),
                        child: TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Telefone',
                                hintText: 'Digite a seu telefone'),
                            controller: _telefoneController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Insira o telefone do usuário";
                              }
                              return null;
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 15, bottom: 0),
                        child: TextFormField(
                            obscureText: true,
                            decoration: const InputDecoration(
                                labelText: 'Senha',
                                hintText: 'Digite a sua senha'),
                            controller: _senhaController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Insira o senha do usuário";
                              }
                              return null;
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 15, bottom: 0),
                        child: TextFormField(
                            obscureText: true,
                            decoration: const InputDecoration(
                                labelText: 'Confirme a Senha',
                                hintText: 'Digite a sua senha novamente'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Insira o email do usuário";
                              } else if (value != _senhaController.text) {
                                return "Senhas diferentes";
                              }
                              return null;
                            }),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        Usuario usuario = Usuario(
                                            nome: _nomeController.text,
                                            email: _emailController.text,
                                            telefone: _telefoneController.text,
                                            senha: _senhaController.text);
                                        insert(usuario);
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: const Text("Cadastrar")),
                              )
                            ],
                          ))
                    ]))));
  }

  insert(Usuario usuario) async {
    FirebaseFirestore.instance.collection("usuarios").add(usuario.toJson());
  }
}
