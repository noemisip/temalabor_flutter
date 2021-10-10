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
  runApp(Form());

}
var ok = false;

class PeopleDao{

  final DatabaseReference _peopleRef =
  FirebaseDatabase.instance.reference().child('people');

  void savePeople(People people) {
    _peopleRef.push().set(people.toJson());
  }
  Query getPeopleQuery(){
    return _peopleRef;
  }
  /*void tryagain(){
  _peopleRef.child("1").set({
  'title': 'Mastering EJB',
  'description': 'Programming Guide for J2EE'
  });
  }*/

}

class Form extends StatelessWidget {
  Form({Key? key}) : super(key: key);
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       home: Scaffold(
        appBar: AppBar(
          title: Text("Form"),
        ),
        body: FutureBuilder(
          future: _fbApp,
          builder: (context, snapshot){
            if(snapshot.hasError){
              print(' you have an error ${ snapshot.error.toString()}');
              return Text('Something went wrong!');
            }
            else if ( snapshot.hasData){
              return BodyWidget();
            }
            else {
              return Center(
              child: CircularProgressIndicator(),
              );
            }
          },
        )//BodyWidget(),
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

  String datas = "";

  @override
  void initState() {
    super.initState();

  }

  void test(){
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

/* Widget getWidget(){
     child: if(ok == true) {
      return okContainer();
     }
        else{
       return defaultContainer();
     }
    }*/

/*  Widget okContainer(){
      return Container(
        color: Colors.green,
        height: 200,

      );
    }
*/




