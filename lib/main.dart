import 'package:flutter/material.dart';
import 'home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(myapp());
}

class myapp extends StatefulWidget {
  const myapp({Key? key}) : super(key: key);

  @override
  State<myapp> createState() => _myappState();
}

class _myappState extends State<myapp> {
  TextEditingController _textEditingController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 160,
                height: 160,
              ),
              Container(
                width: 160,
                height: 240,
                child: Card(
                  elevation: 10,
                  color: Colors.blue,
                  child: Center(
                    child:Text('WELCOME',style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    shadows: [
                      Shadow(
                        blurRadius: 10,
                        color: Colors.white,
                        offset: Offset(2.0,2.0)
                      )
                    ]

                  ),),)
                ),
              ),
              SizedBox(
                width: 40,
                height: 40,
              ),
             Column(
                 children: [
                   TextField(
                controller: _textEditingController,
                decoration: const InputDecoration(
                  hintText: 'Enter your name',
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 10,
                    ),
                  )
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 34.0),
                child: Container(
                  width: 260,
                    height: 48,
                    child: Builder(
                      builder: (context) {
                        return ElevatedButton(onPressed: (){
                        state(_textEditingController.text);
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>home()));
                        }, child: Text('Continue'));
                      }
                    )),
              )]
             ),


          ]
          ),
        ),
      ),
    );
  }
  Future state(namer)async{
    final SharedPreferences preferences= await SharedPreferences.getInstance();
    preferences.setString('name', namer);
  }
}
