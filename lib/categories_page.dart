import 'package:flutter/material.dart';
import 'package:starial_app/ui_helper/util.dart';

class CategoriesPage extends StatelessWidget{
  final imageList = [
  Container(width: 230,height: 300,decoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.grey.shade200,blurRadius: 10,spreadRadius: 4, offset: Offset(0, 4))], color: Colors.grey.shade400, borderRadius: BorderRadius.circular(10)),),
  Container(width: 230,height: 300,decoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.grey.shade200,blurRadius: 10,spreadRadius: 4, offset: Offset(0, 4))], color: Colors.grey.shade400, borderRadius: BorderRadius.circular(10)),),
  Container(width: 230,height: 300,decoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.grey.shade200,blurRadius: 10,spreadRadius: 4, offset: Offset(0, 4))], color: Colors.grey.shade400, borderRadius: BorderRadius.circular(10)),),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Stack(
         children: [
           SingleChildScrollView(
             child: Column(children: [
               Container(width: double.infinity,decoration: BoxDecoration(
                 gradient: gradientOne(),
               ),
                 child: Column(children: [
                     Padding(
                       padding: const EdgeInsets.only(top: 40, left: 15,right: 15,bottom: 10),
                       child: searchBar(searchText: "Stemfield International School", fontS: 15.0),
                     ),
                     Padding(
                       padding: const EdgeInsets.symmetric(vertical: 30.0),
                       child: imageSlider(imageList: imageList, height: 300),
                     )
                 ],),
               ),
               Container(
                 decoration: BoxDecoration(gradient:
                 LinearGradient(colors: [
                   Color.fromRGBO(255, 255, 255, 0),
                   Color.fromRGBO(255, 255, 255, 1)],
                   begin: Alignment.topCenter,
                   end: Alignment.bottomCenter
                 )),
                 child: Column(children: [
                  Text("Schools", style: TextStyle(fontSize: 30)),
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 20.0),
                     child: circleObjects(),
                   ),
                 ])
               ),
               Container(color: Colors.white, width: double.infinity,child: Padding(padding: const EdgeInsets.symmetric(horizontal: 20.0), child: rectangleObjects(crossAxisCount: 1, itemCount: 1, childAspectRatio: 2)),),
               Container(width: double.infinity,color: Colors.white,child: Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Column(children: [
                 Text("Uniform Accessories" ,style: TextStyle(fontSize: 30)),
                 rectangleObjects()
               ],)),),
               endOfPage()
             ],
             ),
           ),
           bottomNavbar(context),
         ],
       ),
    );
  }
}

//Padding(
//                        padding: const EdgeInsets.symmetric(vertical: 40.0),
//                        child:
//                          Row(mainAxisAlignment: MainAxisAlignment.center,children: [
//                            Container(width: 230,height: 300,decoration: BoxDecoration(boxShadow: [
//                              BoxShadow(color: Colors.grey.shade200,blurRadius: 10,spreadRadius: 4, offset: Offset(0, 4))
//                            ], color: Colors.grey.shade400, borderRadius: BorderRadius.circular(10)),
//                            )
//                          ]),
//                      )