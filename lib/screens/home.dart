import 'package:flutter/material.dart';

class homeWidget extends StatelessWidget {
  const homeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Controle de filas"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60.0, bottom: 30.0),
              child: Center(
                child: Container(
                    width: 150,
                    height: 100,
                    child: Image.asset('images/queue-logo.png')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Digite seu email'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    labelText: 'Senha',
                    hintText: 'Digite a sua senha'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: ElevatedButton(onPressed: () {
                      Navigator.pushNamed(context, "/admin");
                    }, child: const Text("Login")),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: ElevatedButton(onPressed: () {}, child: const Text("Cadastrar")),
                  )
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}
