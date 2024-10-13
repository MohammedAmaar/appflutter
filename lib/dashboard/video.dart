import 'dart:ui';

import 'package:flutter/material.dart';

import '../main.dart';
class Videos extends StatefulWidget {
  const Videos({super.key});

  @override
  State<Videos> createState() => _videosState();
}

class _videosState extends State<Videos> {
  @override
  Widget build(BuildContext context) {
    final List<MenuItem> menuData1 = [
      MenuItem(title: "Course 1", icon: Icons.play_arrow, onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => course1()));
      }),
      MenuItem(title: "Course 2", icon: Icons.play_arrow, onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => course1()));
      })

    ];

    return   SafeArea(child: Scaffold(
      appBar: AppBar(

        title: const Text("Videos"),
        centerTitle: true,
        actions: [
          // IconButton(icon: Icon(Icons.shopping_cart),onPressed: (){},),
          IconButton(icon: const Icon(Icons.search),onPressed: (){},),
          // IconButton(icon: Icon(Icons.menu_book),onPressed: (){},),
        ],
        elevation: 0,
        backgroundColor: Colors.red,
        shadowColor: Colors.black,



      ),
      body: Center(
        child: Column(
          children: [
            ListView(
              
                   clipBehavior: Clip.none,
                   padding: EdgeInsets.all(5),
                  // margin: EdgeInsets.zero,

                   shrinkWrap: true,
                    children: [
                      ...menuData1.map((data2) => InkWell(
                        onTap: data2.onTap,
                        child:  Container(
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(5),
                          child: ListTile(

                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.circular(5),

                            ),
                            leading: Icon(data2.icon),
                            title: Text(data2.title,style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),),


                          ),
                        ),

                      ),
                      ),

                    ],
                  ),

              ],


        ),
      ),
    ),);
  }
}
class course1 extends StatefulWidget {
  const course1({super.key});

  @override
  State<course1> createState() => _course1State();
}

class _course1State extends State<course1> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(child: Scaffold(
      appBar: AppBar(

        title: const Text("coures1"),
        centerTitle: true,
        actions: [
          // IconButton(icon: Icon(Icons.shopping_cart),onPressed: (){},),
          IconButton(icon: const Icon(Icons.search),onPressed: (){},),
          // IconButton(icon: Icon(Icons.menu_book),onPressed: (){},),
        ],
        elevation: 0,
        backgroundColor: Colors.red,
        shadowColor: Colors.black,



      ),
    ));
  }
}
