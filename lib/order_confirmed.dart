import 'package:flutter/material.dart';
import 'package:starial_app/ui_helper/util.dart';

class OrderConfirmed extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child:
        Stack(children: [
              Positioned(left: 20,top: 40,child: backButton()),
              Positioned(top:150,left: 0,right: 0,child:
                Stack(children: [
                   Image.asset("assets/images/circle-bg.png"),
                   Positioned(top: 30,left: 50,child:
                   Image.asset("assets/images/phone-bg.png")),
                   Positioned(left: 130,top: 60,child:
                   Image.asset("assets/images/delivery-boy2.png", height: 250,)),
                   Positioned(bottom: 150,left: 0,right: 0,child:
                     Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.center,children: [
                       Text("Order Confirmed!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),textAlign: TextAlign.center,),
                       Text("Your order has been confirmed, we will send you confirmation email shortly.", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.grey),textAlign: TextAlign.center,),
                     ],),
                   )
                ],),
              ),
              Positioned(bottom: 0,left: 0,right: 0,child:
                  SizedBox(height: 250,child:
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
                      Container(width: double.infinity,decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: Colors.grey.shade100),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: TextButton(onPressed: (){}, child: Text("Go to Orders", style: TextStyle(fontSize: 17, color: Colors.grey.shade700, fontWeight: FontWeight.bold),textAlign: TextAlign.center)),
                          )),
                      Container(width: double.infinity,decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color:Color.fromRGBO(0, 174, 255, 1)),
                         child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextButton(onPressed: (){}, child: Text("Continue Shopping", style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),textAlign: TextAlign.center)),
                      )
                      ),
                    ]),
                  ))
              )
            ],),
      ),
    );
  }
}