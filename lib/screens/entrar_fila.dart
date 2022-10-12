import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gestor_fila/models/Filas.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gestor_fila/models/usuarios.dart';

class EntrarFilaWidget extends StatefulWidget {
  const EntrarFilaWidget({Key? key}) : super(key: key);

  @override
  State<EntrarFilaWidget> createState() => _EntrarFilaWidgetState();
}

class _EntrarFilaWidgetState extends State<EntrarFilaWidget> {
  Usuario? currentUser = null;
  getCurrentUser() async {
    String? emailUserLogged = FirebaseAuth.instance.currentUser?.email;

    var findUserByEmail = await FirebaseFirestore.instance
        .collection("usuarios")
        .where("email", isEqualTo: emailUserLogged)
        .get();

    Usuario user = Usuario.fromSnapshot(findUserByEmail.docs.first);
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


  Future<Filas> insertFila() async {
    
    var allUsers = FirebaseFirestore.instance.collection('fila');
    
    int newID = await allUsers.get().then((QuerySnapshot snapshot){
      return snapshot.size + 1;
    });

    Filas fila = Filas(
      id_atual: newID,
      doc_user: "teste"
    );
    
    var jsonUser = fila.toJson();

     try {

    FirebaseFirestore.instance.collection("fila").add(jsonUser);

    }on FirebaseAuthException catch (e) {
      //tratar erro
    }

    return fila;

  }
}
