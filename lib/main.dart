import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'people.dart';

import 'package:flutter/foundation.dart';


TextEditingController lastnameController = new TextEditingController();
TextEditingController firstnameController = new TextEditingController();
TextEditingController emailController = new TextEditingController();

Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  /*var ref = FirebaseDatabase.instance.reference();
  var peopleRef = ref.child("people");
  peopleRef.reference().get().then((DataSnapshot? snapshot) {
    print(
        'Connected to directly configured database and read ${snapshot!.value}');
  });*/

  runApp(Form());

}
var ok = false;

class PeopleDao{

  final DatabaseReference _peopleRef =
  FirebaseDatabase.instance.reference().child('people/');

  void savePeople(People people) {
    _peopleRef.push().set(people.toJson()).catchError((e){
      print(e);
    }).then((value) {
      print("ok");
    });
  }

  Query getPeopleQuery(){
    return _peopleRef;
  }
}

class Form extends StatelessWidget {
  Form({Key? key}) : super(key: key);
 // final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
       home: Scaffold(
         resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Form"),
        ),
        body: BodyWidget()
      ),
    );
  }
}

class BodyWidget extends StatefulWidget{

  BodyWidget({Key? key}) : super(key: key);
  final peopleDao = PeopleDao();
  //final CounterStorage storage;
  @override
  State<StatefulWidget> createState() => BodyWidgetState();

}

class BodyWidgetState extends State<BodyWidget> {

  @override
  void initState() {
    super.initState();
  }

  void test() {
    final people = People(lastnameController.text,firstnameController.text,emailController.text);
    widget.peopleDao.savePeople(people);
    lastnameController.clear();
    firstnameController.clear();
    emailController.clear();
    setState(() {});
  }

  Widget defaultContainer(){
    return Container(
      color: Colors.purple,
      height: 200,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  <Widget> [
            Row(
                children: <Widget>[
                  Text("First name:",
                    textAlign: TextAlign.left,
                  ),
                  Flexible(
                    child: TextField(
                      controller: firstnameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'First name',
                      ),
                    ),
                  )
                ]
            ),
            Row(
                children: <Widget>[
                  Text("Last name:",
                    textAlign: TextAlign.left,
                  ),
                  Flexible(
                    child: TextField(
                      controller: lastnameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Last name',
                      ),
                    ),
                  )
                ]
            ),
            Row(
                children: <Widget>[
                  Text("E-mail:",
                    textAlign: TextAlign.left,
                  ),
                  Flexible(
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'E-mail',
                      ),
                    ),
                  )
                ]
            ),
            FlatButton(
                onPressed: (){
                  test();
                },
                child: Text("Ok"),
                textColor: Colors.purple                    ),
            Container( child: defaultContainer()),
          ]
      ),
    );
  }
}





