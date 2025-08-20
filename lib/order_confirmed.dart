import 'package:flutter/material.dart';

class OrderConfirmed extends StatelessWidget{
  const OrderConfirmed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xFF7feeff),
            Color(0xFFCBE3FF),
            Colors.white,
            Colors.white,
          ],begin: Alignment.topLeft,end: Alignment.bottomRight)
        ),
        child:
        Stack(children: [
              Positioned(left: 10,top: 30,child: IconButton(onPressed: (){
                Navigator.pop(context);
              }, icon: Icon(Icons.arrow_back_ios,size: 25,))),
              Positioned(top: 150,left: 0,right: 0,child:
                Stack(children: [
                   Image.asset("assets/images/circle-bg.png"),
                   Positioned(top: 30,left: 50,child:
                   Image.asset("assets/images/phone-bg.png")),
                   Positioned(left: 120,top: 70,child:
                   Image.asset("assets/images/delivery-boy2.png", height: 250,)),
                   Positioned(bottom: 150,left: 0,right: 0,child:
                     Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.center,children: [
                       Text("Order Confirmed!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30,letterSpacing: 0),textAlign: TextAlign.center,),
                       SizedBox(width: 280,child: Text("Your order has been confirmed, we will send you confirmation email shortly.", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black54,letterSpacing: 0),textAlign: TextAlign.center,)),
                     ],),
                   )
                ],),
              ),
              Positioned(bottom: 0,left: 0,right: 0,child:
                  SizedBox(height: 230,child:
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
                      SizedBox(width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: TextButton(
                                onPressed: (){},
                                child: Text("Track order", style: TextStyle(fontSize: 17, color: Color.fromRGBO(5, 138, 255, 1), fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center)),
                          )),
                      Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: LinearGradient(colors: [
                                Color.fromRGBO(125, 195, 255, 1),
                                Color.fromRGBO(0, 136, 255, 1),
                              ],begin: Alignment.centerLeft,end: Alignment.centerRight)
                          ),
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