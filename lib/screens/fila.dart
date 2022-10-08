import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gestor_fila/screens/entrar_fila.dart';

class FilaWidget extends StatefulWidget {
  const FilaWidget({Key? key}) : super(key: key);

  @override
  State<FilaWidget> createState() => _FilaWidgetState();
}

class _FilaWidgetState extends State<FilaWidget> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(700, 1400));
    return Scaffold(
        appBar: AppBar(
          title: const Text("Aguardando vez"),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                      decoration: InputDecoration(labelText: "Sua posicao"))),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EntrarFilaWidget()));
                    },
                    child: const Text("Sair da fila")),
              )
            ])));
  }
}
