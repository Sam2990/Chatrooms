import 'package:flutter/material.dart';
import 'package:flutter2/message.dart';
import 'dart:async';
import 'main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  int selectedIndex=0;
  PageController pageController=PageController();
  String ? user;

  void initState(){
    super.initState();
    get();
  }

  void get()async{
  final SharedPreferences preferences= await SharedPreferences.getInstance();
  user = preferences.getString('name');
  }
  TextEditingController crickettc =TextEditingController();
  TextEditingController cameratc =TextEditingController();
  TextEditingController mictc =TextEditingController();
  TextEditingController booktc =TextEditingController();

  Future<void>?addmsg(String msg,String group,String? username) async {
      await FirebaseFirestore.instance.collection(group).add({"name":username,"msg":msg,"time":FieldValue.serverTimestamp()});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: NavigationRail(
              backgroundColor: Colors.white12,
              destinations: [
                //NavigationRailDestination(icon:Icon(Icons.home), label: Text('')),
                NavigationRailDestination(icon:Icon(Icons.sports_cricket), label: Text('cricket'),),
                NavigationRailDestination(icon:Icon(Icons.camera_alt_outlined), label: Text('')),
                NavigationRailDestination(icon:Icon(Icons.mic), label: Text('')),
                NavigationRailDestination(icon:Icon(Icons.book_online_sharp), label: Text('')),
              ],
              selectedIndex: selectedIndex,onDestinationSelected:(newindex){
                setState(() {
                  selectedIndex = newindex;
                  pageController.animateToPage(newindex, duration: Duration(milliseconds: 280), curve: Curves.easeInOut);
                });
            },),
          ),
          Expanded(child:PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: pageController,

            children: [
 //111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
              Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey[200],
                ),
                child: Column(
                  children: [
                   Padding(
                     padding: const EdgeInsets.only(top: 48.0),
                     child: Text('Cricket',style: TextStyle(
                       fontSize: 24,
                       color: Colors.black45,
                     ),),
                   ),
                    Builder(
                      builder: (context) {
                        return Expanded(
                          child:StreamBuilder(
                            stream: FirebaseFirestore.instance
                            .collection('cricket')
                           .orderBy("time",descending: true)
                            .snapshots(),
                            builder: ( BuildContext context,AsyncSnapshot snapshot){
                              if(snapshot.hasError){
                                return const Text('has error');
                              }else if(snapshot.connectionState == ConnectionState.waiting){
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }else if(snapshot.hasData){
                               return //Text(snapshot.data!.docs[2].toString());
                                  ListView.builder(

                                    itemCount: snapshot.data!.docs.length,
                                    reverse: true,
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: (context,index){
                                      if(snapshot.data!.docs.length <1){
                                        return Text('..');
                                      }
                                      return message(user: user, name: snapshot.data!.docs[index]['name'],
                                          msg: snapshot.data!.docs[index]['msg']) ;
                                    });
                              }else{
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          )
                        );
                      }
                    ),
                    Row(
                      children: [
                        Container(
                            width:240,
                          height: 48,
                          child: TextField(
                            controller: crickettc,
                            decoration: InputDecoration(
                              hintText: 'Type message'
                            ),
                          )),
                        IconButton(icon: Icon(Icons.send_sharp),onPressed: (){
                            addmsg(crickettc.text, 'cricket', user);
                            crickettc.clear();
                        }),
                      ],
                    ),
                    SizedBox(
                      height: 24,
                      width: 240,
                    )
                  ],
                ),
              ),
              /*Container(

                child: Column(
                children: [
                  Expanded(
                    child: Container(

                    ),
                  ),
                  Row(
                    children: [
                      Container(
                          width:240,
                          height: 48,
                          child: TextField()),
                      Icon(Icons.send_sharp),
                    ],
                  ),
                  SizedBox(
                    height: 24,
                    width: 240,
                  )
                ],
              ),),*/
  //22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
              Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey[200],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 48.0),
                      child: Text('Photography',style: TextStyle(
                        fontSize: 24,
                        color: Colors.black45,
                      ),),
                    ),
                    Builder(
                        builder: (context) {
                          return Expanded(
                              child:StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('camera')
                                    .orderBy("time",descending: true)
                                    .snapshots(),
                                builder: ( BuildContext context,AsyncSnapshot snapshot){
                                  if(snapshot.hasError){
                                    return const Text('has error');
                                  }else if(snapshot.connectionState == ConnectionState.waiting){
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }else if(snapshot.hasData){
                                    return //Text(snapshot.data!.docs[2].toString());
                                      ListView.builder(

                                          itemCount: snapshot.data!.docs.length,
                                          reverse: true,
                                          physics: BouncingScrollPhysics(),
                                          itemBuilder: (context,index){
                                            if(snapshot.data!.docs.length <1){
                                              return Text('..');
                                            }
                                            return message(user: user, name: snapshot.data!.docs[index]['name'],
                                                msg: snapshot.data!.docs[index]['msg']) ;
                                          });
                                  }else{
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                },
                              )
                          );
                        }
                    ),
                    Row(
                      children: [
                        Container(
                            width:240,
                            height: 48,
                            child: TextField(
                              controller: cameratc,
                              decoration: InputDecoration(
                                  hintText: 'Type message'
                              ),
                            )),
                        IconButton(icon: Icon(Icons.send_sharp),onPressed: (){
                          addmsg(cameratc.text, 'camera', user);
                          cameratc.clear();
                        }),
                      ],
                    ),
                    SizedBox(
                      height: 24,
                      width: 240,
                    )
                  ],
                ),
              ),
  //33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
              Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey[200],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 48.0),
                      child: Text('Music',style: TextStyle(
                        fontSize: 24,
                        color: Colors.black45,
                      ),),
                    ),
                    Builder(
                        builder: (context) {
                          return Expanded(
                              child:StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('mic')
                                    .orderBy("time",descending: true)
                                    .snapshots(),
                                builder: ( BuildContext context,AsyncSnapshot snapshot){
                                  if(snapshot.hasError){
                                    return const Text('has error');
                                  }else if(snapshot.connectionState == ConnectionState.waiting){
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }else if(snapshot.hasData){
                                    return //Text(snapshot.data!.docs[2].toString());
                                      ListView.builder(

                                          itemCount: snapshot.data!.docs.length,
                                          reverse: true,
                                          physics: BouncingScrollPhysics(),
                                          itemBuilder: (context,index){
                                            if(snapshot.data!.docs.length <1){
                                              return Text('..');
                                            }
                                            return message(user: user, name: snapshot.data!.docs[index]['name'],
                                                msg: snapshot.data!.docs[index]['msg']) ;
                                          });
                                  }else{
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                },
                              )
                          );
                        }
                    ),
                    Row(
                      children: [
                        Container(
                            width:240,
                            height: 48,
                            child: TextField(
                              controller: mictc,
                              decoration: InputDecoration(
                                  hintText: 'Type message'
                              ),
                            )),
                        IconButton(icon: Icon(Icons.send_sharp),onPressed: (){
                          addmsg(mictc.text, 'mic', user);
                          mictc.clear();
                        }),
                      ],
                    ),
                    SizedBox(
                      height: 24,
                      width: 240,
                    )
                  ],
                ),
              ),
  //4444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
              Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey[200],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 48.0),
                      child: Text('Litrature',style: TextStyle(
                        fontSize: 24,
                        color: Colors.black45,
                      ),),
                    ),
                    Builder(
                        builder: (context) {
                          return Expanded(
                              child:StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('book')
                                    .orderBy("time",descending: true)
                                    .snapshots(),
                                builder: ( BuildContext context,AsyncSnapshot snapshot){
                                  if(snapshot.hasError){
                                    return const Text('has error');
                                  }else if(snapshot.connectionState == ConnectionState.waiting){
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }else if(snapshot.hasData){
                                    return //Text(snapshot.data!.docs[2].toString());
                                      ListView.builder(

                                          itemCount: snapshot.data!.docs.length,
                                          reverse: true,
                                          physics: BouncingScrollPhysics(),
                                          itemBuilder: (context,index){
                                            if(snapshot.data!.docs.length <1){
                                              return Text('..');
                                            }
                                            return message(user: user, name: snapshot.data!.docs[index]['name'],
                                                msg: snapshot.data!.docs[index]['msg']) ;
                                          });
                                  }else{
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                },
                              )
                          );
                        }
                    ),
                    Row(

                      children: [
                        Container(
                            width:240,
                            height: 48,
                            child: TextField(
                              controller: booktc,
                              decoration: InputDecoration(
                                  hintText: 'Type message'
                              ),
                            )),
                        IconButton(icon: Icon(Icons.send_sharp),onPressed: (){
                          addmsg(booktc.text, 'book', user);
                          booktc.clear();
                        }),
                      ],
                    ),
                    SizedBox(
                      height: 24,
                      width: 240,
                    )
                  ],
                ),
              ),
            ],
          )
          )
        ],
      ),
    );
  }
}
