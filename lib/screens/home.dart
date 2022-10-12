import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(700, 1400));
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60.0, bottom: 30.0),
              child: Center(
                child: SizedBox(
                    width: 150,
                    height: 100,
                    child: Image.asset('images/queue-logo.png')),
              ),
            ),
             Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                decoration: const InputDecoration(
                    labelText: 'Email', hintText: 'Digite seu email'),
                    controller: _emailController,
              ),
            ),
             Padding(
              padding:
                  const EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                obscureText: true,
                decoration: const InputDecoration(
                    labelText: 'Senha', hintText: 'Digite a sua senha'),
                    controller: _senhaController,
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: ElevatedButton(
                        child: const Text("Login"),
                          onPressed: () async {

                            await realizarLogin(_emailController.text, _senhaController.text) ? 
                            Navigator.pushNamed(context, "/entrar_na_fila") 
                            : showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context){
                                  return AlertDialog(
                                    title: Text("Usuário/Senha inválido"),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: (){ Navigator.pop(context); },
                                        child: const Text("Ok"),
                                      )
                                    ],
                                  );
                                }
                              );
                          },
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/cadastro");
                          },
                          child: const Text("Cadastrar")),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Future<bool> realizarLogin (String email, String senha) async {

    var result = await FirebaseFirestore.instance.collection("usuarios")
    .where("email", isEqualTo: email)
    .where("senha", isEqualTo: senha)
    .get();


  if (result.docs.isEmpty) {
    return false;
  }
  
  return true;

  }
}
