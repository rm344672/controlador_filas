import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                decoration: InputDecoration(
                    labelText: 'Email', hintText: 'Digite seu email'),
              ),
            ),
            const Padding(
              padding:
                  EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    labelText: 'Senha', hintText: 'Digite a sua senha'),
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
                          onPressed: () {
                            Navigator.pushNamed(context, "/entrar_na_fila");
                          },
                          child: const Text("Login")),
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
}
