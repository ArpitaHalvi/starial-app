import 'package:flutter/material.dart';

class TipDeliveryPartner extends StatelessWidget {
  TipDeliveryPartner({super.key});

  Color purpleColor = Color(0xFF600F66);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Container(
            width: 400,
            height: 170,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/images/tip-delivery-partner-banner.png'),fit: BoxFit.cover)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Tip your delivery partner',style: TextStyle(fontFamily: 'SFProDisplay',color: purpleColor,fontWeight: FontWeight.bold,fontSize: 20),),
                  SizedBox(width: 225,child: Text('Your kindness means a lot! 100% of your tip will go directly to your delivery partner',style: TextStyle(fontFamily: 'SFProDisplay',color: purpleColor,fontWeight: FontWeight.bold,fontSize: 10),)),
                  SizedBox(height: 20,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 77,
                        height: 40,
                        padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Color(0xFFE88DFF),width: 2),
                          gradient: LinearGradient(
                              // colors: [Color(0xFFF6F6F6),Color(0xFFFF26CC)],
                              // colors: [Color(0xFFF6F6F6),Color(0xFFFF67DB)],
                              // colors: [Color(0xFFF6F6F6),Color(0xFFFFADDD)],
                              colors: [Color(0xFFF6F6F6),Color(0xFFFF99D0)],
                              begin: Alignment.topLeft,end: Alignment.bottomRight,
                              stops: [0.04, 1.0,],
                          )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.check,color: purpleColor,),
                            SizedBox(width: 5,),
                            Text('\u20B920',style: TextStyle(fontFamily: 'SFProDisplay',color: purpleColor,fontWeight: FontWeight.bold,fontSize: 14),)
                          ],
                        ),
                      ),
                      Container(
                        width: 77,
                        height: 40,
                        padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Color(0xFFECD2FF),width: 2),
                          color: Color(0xFFECD2FF),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.emoji_emotions_outlined,color: purpleColor,),
                            SizedBox(width: 5,),
                            Text('\u20B930',style: TextStyle(fontFamily: 'SFProDisplay',color: purpleColor,fontWeight: FontWeight.bold,fontSize: 14),)
                          ],
                        ),
                      ),
                      Container(
                        width: 77,
                        height: 40,
                        padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Color(0xFFED8CF1),width: 2),
                          color: Color(0xFFECC5FF),
                        ),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.emoji_emotions_outlined,color: purpleColor,),
                                SizedBox(width: 5,),
                                Text('\u20B940',style: TextStyle(fontFamily: 'SFProDisplay',color: purpleColor,fontWeight: FontWeight.bold,fontSize: 14),)
                              ],),
                            ),
                            Positioned(top: 0,left: 0,right: 0,child: Image.asset('assets/images/most-tipped-tag.png',width: 41,height: 27),)
                          ]
                        ),
                      ),
                      Container(
                        width: 77,
                        height: 40,
                        padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Color(0xFFEEB7FF),width: 2),
                          color: Color(0xFFEEB7FF),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.emoji_emotions_outlined,color: purpleColor,),
                            SizedBox(width: 5,),
                            Text('\u20B950',style: TextStyle(fontFamily: 'SFProDisplay',color: purpleColor,fontWeight: FontWeight.bold,fontSize: 14),)
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
