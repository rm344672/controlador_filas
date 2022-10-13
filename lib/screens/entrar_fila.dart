import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gestor_fila/models/Filas.dart';
import 'package:gestor_fila/models/Filas_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gestor_fila/models/fila_user.dart';
import 'package:gestor_fila/models/usuarios.dart';

class EntrarFilaWidget extends StatefulWidget {
  const EntrarFilaWidget({Key? key}) : super(key: key);

  @override
  State<EntrarFilaWidget> createState() => _EntrarFilaWidgetState();
}

class _EntrarFilaWidgetState extends State<EntrarFilaWidget> {
  Usuario? currentUser = null;
  String? docUserLogged = null; 
  getCurrentUser() async {
    String? emailUserLogged = FirebaseAuth.instance.currentUser?.email;

    var findUserByEmail = await FirebaseFirestore.instance
        .collection("usuarios")
        .where("email", isEqualTo: emailUserLogged)
        .get();

    Usuario user = Usuario.fromSnapshot(findUserByEmail.docs.first);
    docUserLogged = findUserByEmail.docs.first.reference.id;
    setCurrentUser(user);
  }

  setCurrentUser(Usuario user) {
    currentUser = user;
  }

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

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

                  Navigator.pushNamed(context, arguments: await insertFila(), "/fila");
                },
                child: const Text("Entrar na fila de Espera")),
          )
        ])),
        drawer: Drawer(
          child: ListView(
            children: [
              Divider(),
              Expanded(
                  child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: ListTile(
                  title: Text('Exit'),
                  onTap: () => {
                    FirebaseAuth.instance.signOut(),
                    Navigator.pushNamed(context, '/')
                  },
                ),
              ))
            ],
          ),
        ));
  }


  Future<FilaUser> insertFila() async {
    
    var usuarioLogado = FirebaseFirestore.instance.collection('fila')
    .where("doc_user", isEqualTo: docUserLogged);
    
    if (usuarioLogado == null){
      
    var ultimaPosicao = FirebaseFirestore.instance.collection('fila');

      FilaUser filaUser = FilaUser(
        pos_fila: 1,
        doc_user: docUserLogged
      );

    var jsonUser = filaUser.toJson();

    FirebaseFirestore.instance.collection("fila").add(jsonUser);
   
    final QuerySnapshot snapshot= await FirebaseFirestore.instance
    .collection("fila")
    .get();
    
    Filas.fromSnapshot(snapshot);
    updateFila(fila);

    }
    }

  updateFila(Filas fila) async{

    final QuerySnapshot<Map<String, dynamic>> snapshot= await FirebaseFirestore.instance
    .collection("fila")
    .get();

    DocumentSnapshot element = snapshot.docs.first;

      FirebaseFirestore.instance.collection("fila")
        .doc(element.id)
        .update({"ultima_pos": FieldValue.increment(1)});
   
   }

}
