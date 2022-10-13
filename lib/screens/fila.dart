
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gestor_fila/screens/entrar_fila.dart';
import 'dart:developer';
import 'package:flutter/foundation.dart';


import '../models/Filas.dart';
import '../models/usuarios.dart';

class FilaWidget extends StatefulWidget {
  const FilaWidget({Key? key}) : super(key: key);
  
  
  @override
  State<FilaWidget> createState() => _FilaWidgetState();
}

class _FilaWidgetState extends State<FilaWidget> {

  @override
  Widget build(BuildContext context) {
    
    final args = ModalRoute.of(context)!.settings.arguments as Filas;

    ScreenUtil.init(context, designSize: const Size(700, 1400));
    return Scaffold(
      appBar: AppBar(
        title: const Text("Controle de filas - Admin"),
      ),
      body: SizedBox(
        height: double.maxFinite,
        child: Stack(
          children: [
            const Positioned(
              child: Padding(
                  padding: EdgeInsets.only(top: 50.0),
                  child: Align(
                    alignment: FractionalOffset.topCenter,
                    child: Text("Sua posição atual na fila:",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.none,
                            fontSize: 20)),
                  )),
            ),
            buildInfoUser(context, args.doc_user)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () => {
            deleteFila(args),
            Navigator.pushNamed(context, "/entrar_na_fila")},
          label: const Text('Sair da Fila')),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }


   deleteFila(Filas fila) async {
    
    final CollectionReference docs= FirebaseFirestore.instance
    .collection("fila");

    docs.get().then((QuerySnapshot snapshot){
    snapshot.docs.forEach((DocumentSnapshot element) {
      if(fila.id_atual == element.get('id_atual')){
          FirebaseFirestore.instance.collection('fila')
          .doc(element.id)
          .delete();   
      }
    });
    });
  }

  Widget buildInfoUser(BuildContext context, doc_user) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("fila_user")
            .where("doc_user", isEqualTo: doc_user)
            .snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.data == null || snapshot.data!.docs == null) {
            return Container(child: const Text("Nenhum usuário na fila"));
          } else {
            return buildFilaRefresh(context, snapshot.data!.docs);
          }
        }));
  }

  Widget buildFilaRefresh(
    BuildContext context, List<QueryDocumentSnapshot> snapshot){
      if (snapshot.isEmpty && snapshot[0] == null){
        return Container(child: const Text("Nenhum usuário na fila")); 
      }
    
    Filas fila = Filas.fromSnapshot(snapshot[0]);
    return Positioned(
                child: Align(
              alignment: FractionalOffset.center,
              child: Center(
                child: Text(fila.id_atual.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.none,
                        fontSize: 32)),
              ),
            ));
  }
}