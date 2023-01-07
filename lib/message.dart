import 'package:flutter/material.dart';

class message extends StatelessWidget {
  String msg;
  String? user;
  String name;

  message({
    required this.user,
    required this.name,
    required this.msg,
});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: name==user?MainAxisAlignment.end:MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            //margin: EdgeInsets.all(16),
            constraints: BoxConstraints(maxWidth: 200),
            decoration: BoxDecoration(
              borderRadius: name==user?BorderRadius.only(bottomLeft: Radius.circular(12),bottomRight: Radius.circular(12) ,topLeft: Radius.circular(12) )
                  :BorderRadius.only(bottomRight: Radius.circular(12),bottomLeft:Radius.circular(12) ,topRight: Radius.circular(12)),
              color: name == user?Colors.blue:Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                       // color: Colors.white60
                    ),
                    child: Text(name,style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(12),
                  //margin: EdgeInsets.all(16),
                  constraints: BoxConstraints(maxWidth: 200),
                  decoration: BoxDecoration(
                    //borderRadius: name==user?BorderRadius.only(bottomLeft: Radius.circular(12),bottomRight: Radius.circular(12) ,topLeft: Radius.circular(12) )
                      //  :BorderRadius.only(bottomRight: Radius.circular(12),bottomLeft:Radius.circular(12) ,topRight: Radius.circular(12)),
                    color: name == user?Colors.white60:Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                 child: Text(msg,),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
