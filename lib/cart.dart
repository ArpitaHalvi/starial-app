import 'package:flutter/material.dart';
import 'package:starial_app/ui_helper/util.dart';

class CartScreen extends StatelessWidget{
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const cartItems = [
      {"name":'Trimax Gold', "price": "₹99(+₹4.00 Tax)","image": "cart-product1.png"},
      {"name":'Apsara Pencil', "price": "₹45 (+₹4.00 Tax)","image": "cart-product2.jpg"},
      {"name":'Trimax Gold', "price": "₹99(+₹4.00 Tax)","image": "cart-product1.png"},
      {"name":'Apsara Pencil', "price": "₹45 (+₹4.00 Tax)","image": "cart-product2.jpg"},
    ];
    const priceDetails = [
      {"name":"Subtotal","price": 152}, {"name":"Delivery Charge", "price": 10}, {"name": "Total","price": 162}
    ];
    return Scaffold(
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(children: [
            Container(height: 420, decoration: BoxDecoration(gradient: gradientOne()),
              child: Column(children: [
              Padding(
              padding: const EdgeInsets.only(top: 40, left: 20,right: 20),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.center,children: [
                backButton(),
                Text("Cart", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),textAlign: TextAlign.center,)
              ],),
              ),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5,left: 20,right: 20),
                    child: SizedBox(
                      height: 320,
                      child: ListView.separated(itemBuilder: (context,index){
                        return Card(color: Colors.white,shadowColor: Colors.grey.shade50,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(children: [
                              Image.asset("assets/images/${cartItems[index]["image"]}", height: 110, fit: BoxFit.contain),
                              SizedBox(width: 5),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                                  Text("${cartItems[index]["name"]}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                  Text("${cartItems[index]["price"]}", style: TextStyle(color: Colors.grey.shade500, fontSize: 15)),
                                  SizedBox(
                                    width: 200,
                                    height: 60,
                                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                                        SizedBox(
                                          width: 120,
                                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                                            Container(width: 35,height: 35,decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(50), color: Colors.grey.shade100),
                                                child: TextButton(onPressed: (){}, style: TextButton.styleFrom(
                                                padding: EdgeInsets.zero),child: Icon(Icons.expand_more, size: 25,color: Colors.grey))),
                                            Text("1"),
                                            Container(width: 35,height: 35,decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(50), color: Colors.grey.shade100),
                                                child: TextButton(onPressed: (){}, style: TextButton.styleFrom(
                                                padding: EdgeInsets.zero),child: Icon(Icons.expand_less, size: 25,color: Colors.grey,))),
                                          ],),
                                        ),
                                        Container(width: 35,height: 35,decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(50), color: Colors.grey.shade100),
                                        child: TextButton(onPressed: (){},style: TextButton.styleFrom(
                                          padding: EdgeInsets.zero, // removes extra padding
                                        ),
                                            child: Icon(Icons.delete, color: Colors.grey,size: 20,)))
                                    ],),
                                  ),
                                ],),
                              )
                            ],),
                          ),
                        );
                      }, itemCount: cartItems.length, separatorBuilder: (context,index){
                        return SizedBox(height: 10);
                      },),
                    ),
                  ),
                ),
              ],),
            ),
            Container(
              width: double.infinity,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5,left: 20),
                child: Column(children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("Delivery Address", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      TextButton(onPressed: (){}, child: Image.asset("assets/images/right-arrow.png"))]),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                    Row(children: [
                      Container(width: 70,height: 70,decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),image: DecorationImage(image: AssetImage("assets/images/map.png"),fit: BoxFit.cover)),
                        child: CircleAvatar(backgroundColor: Colors.transparent,child: Icon(Icons.location_on, size: 30,))
                      ),
                      SizedBox(width: 10),
                      SizedBox(width: 220,child: Text("43, Electronics City Phase 1, Electronic City", softWrap: true,style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)))
                    ],),
                    TextButton(onPressed: (){}, child: Image.asset("assets/images/check-mark.png")),
                  ]),
                ],),
              ),
            ),
            Container(
              width: double.infinity,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10,left: 20),
                child: Column(children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("Payment Method", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        TextButton(onPressed: (){}, child: Image.asset("assets/images/right-arrow.png"))]),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                    Row(children: [
                      Container(width: 70,height: 70,decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20), color: Color.fromRGBO(245, 246, 250, 1)),
                          child: Image.asset("assets/images/visa.png")
                      ),
                      SizedBox(width: 10),
                      Column(children: [
                        Text("Visa Classic", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                        Text("**** 7690", softWrap: true,style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold))
                      ],),
                    ],),
                    TextButton(onPressed: (){}, child: Image.asset("assets/images/check-mark.png")),
                  ]),
                ],),
              ),
            ),
            Container(
              width: double.infinity,
              color: Colors.white,
              height: 150,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                  Text("Order Info",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(width: double.infinity,height: 100,
                    child: ListView.builder(itemBuilder: (context,index){
                       return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children:[
                         Text("${priceDetails[index]["name"]}", style: TextStyle(color: Colors.grey.shade600, fontSize: 16)),
                         Padding(
                           padding: const EdgeInsets.only(right: 20.0),
                           child: Text("₹${priceDetails[index]["price"]}", style: TextStyle(fontSize: 16),),
                         )
                       ]);
                    },itemCount: priceDetails.length),
                  )
                ],),
              ),
            ),
            Container(
              color: Colors.white,
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(width: double.infinity,decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Color.fromRGBO(0, 174, 255, 1)),child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextButton(onPressed: (){}, child: Text("Checkout", style: TextStyle(color: Colors.white, fontSize: 20),)),
                  )),
              ),
            ),
            ],),
        ),
    );
  }
}
