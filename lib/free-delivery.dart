import 'package:flutter/material.dart';

class FreeDeliveryPopUp extends StatefulWidget {
  FreeDeliveryPopUp({super.key});


  @override
  State<FreeDeliveryPopUp> createState() => _FreeDeliveryPopUpState();
}

class _FreeDeliveryPopUpState extends State<FreeDeliveryPopUp> {
  Color freeDeliveryFontColor = Color.fromRGBO(0, 195, 255, 1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: 395, height: 385,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('FREE DELIVERY', style: TextStyle(color: freeDeliveryFontColor, fontSize: 42, fontWeight: FontWeight.bold, letterSpacing: -2),),
              SizedBox(height: 10,),
              Image.asset('assets/images/delivery-bike.png'),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 5),
                child: Text('Congrats you have a free delivery on your first order above \u20B9100',style: TextStyle(
                  color: freeDeliveryFontColor, fontWeight: FontWeight.w500, letterSpacing: 0
                ),textAlign: TextAlign.center,),
              ),
              SizedBox(height: 10,),
              InkWell(onTap: (){},
                child: Container(
                  width: 348, height: 58,
                  decoration: BoxDecoration(
                    color: freeDeliveryFontColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(child: Text('Got it!', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
