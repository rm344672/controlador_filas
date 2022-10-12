import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gestor_fila/models/Filas.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EntrarFilaWidget extends StatefulWidget {
  const EntrarFilaWidget({Key? key}) : super(key: key);

  @override
  State<EntrarFilaWidget> createState() => _EntrarFilaWidgetState();
}

class _EntrarFilaWidgetState extends State<EntrarFilaWidget> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(700, 1400));
    return Scaffold(
        appBar: AppBar(
          title: const Text("Entrar em fila"),
        ),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
            padding: const EdgeInsets.only(left: 5.0),
            child: ElevatedButton(
                onPressed: () async {
                  var result = await FirebaseFirestore.instance.collection(
                    "fila").where("id_fila", isEqualTo: 1).get();
                  Filas filas = Filas.fromSnapshot(result.docs.first);
                  Navigator.pushNamed(context, arguments:  filas, "/fila");
                },
                child: const Text("Entrar na fila de Espera")),
          )
        ])));
  }
}
