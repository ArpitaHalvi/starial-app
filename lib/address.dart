import 'package:flutter/material.dart';
import 'package:starial_app/ui_helper/util.dart';

class AddressScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Stack(
          children: [
            Positioned(top: 0,left: 0,right: 0,child:
              Container(
                 width: double.infinity,
                 height: 600,
                 decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/loc.png"), fit: BoxFit.cover))
              ),
            ),
            Positioned(top: 0,left: 0,right: 0,child: Container(
              width: double.infinity,height: 200,
              decoration: BoxDecoration(gradient: gradientOne()),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40,horizontal: 20),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [backButton(), Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text("Address", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                )],),
              )
            )),
            Positioned(left: 0,right: 0,bottom: 0,child:
            Container(
              width: double.infinity,
              height: 400,
              decoration: BoxDecoration(gradient: LinearGradient(colors: [
                Color.fromRGBO(17, 0, 111, 1),
                Color.fromRGBO(0, 174, 255, 1),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
              ),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.start,children: [Text("Address", style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),), Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), color: Color.fromRGBO(245, 246, 250, 1)
                    ),
                    child: TextField(decoration: InputDecoration(
                      hintText: "43, Electronics City Phase 1, Electronic City",
                      hintStyle: TextStyle(color: Color.fromRGBO(143, 149, 158, 1), fontSize: 17),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey.shade300))
                    ),
                    ),
                  ),
                  ]),
                  Column(crossAxisAlignment: CrossAxisAlignment.start,children: [Text("Floor / Landmark", style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),), Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), color: Color.fromRGBO(245, 246, 250, 1)
                    ),
                    child: TextField(decoration: InputDecoration(
                        hintText: "Add your nearest landmark",
                        hintStyle: TextStyle(color: Color.fromRGBO(143, 149, 158, 1), fontSize: 17),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey.shade300))
                    ),
                    ),
                  ),
                  ]),
                  Row(children: [
                    Text("Save as primary address", style: TextStyle(fontSize: 20, color: Colors.white),),
                  ],),
                  Container(width: double.infinity,decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Color.fromRGBO(0, 174, 255, 1)),child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextButton(onPressed: (){}, child: Text("Save Address", style: TextStyle(color: Colors.white, fontSize: 20),)),
                  )),
                ],
              ),
            ),
          ),
        )
        ]),
      );
  }
}