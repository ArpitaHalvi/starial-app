import 'package:flutter/material.dart';
import 'package:starial_app/ui_helper/util.dart';


class HomePage extends StatefulWidget{
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage>{
  var cateImages = ["cate1.png","cate2.png","cate3.png","cate4.png"];
  var categories = ["Pencils, Pens and Markers","School Supplies","Office Essentials","Stationary Basics"];
  final imageListOne = [
    ClipRRect(borderRadius: BorderRadius.circular(20),child: Image.asset("assets/images/offer1.png", height: 150)),
    ClipRRect(borderRadius: BorderRadius.circular(20),child: Image.asset("assets/images/offer1.png", height: 150)),
    ClipRRect(borderRadius: BorderRadius.circular(20),child: Image.asset("assets/images/offer1.png", height: 150)),
  ];
  final imageListTwo = [
    Container(width: 230,height: 300,decoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.grey.shade200,blurRadius: 10,spreadRadius: 4, offset: Offset(0, 4))], color: Colors.grey.shade400, borderRadius: BorderRadius.circular(10)),),
    Container(width: 230,height: 300,decoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.grey.shade200,blurRadius: 10,spreadRadius: 4, offset: Offset(0, 4))], color: Colors.grey.shade400, borderRadius: BorderRadius.circular(10)),),
    Container(width: 230,height: 300,decoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.grey.shade200,blurRadius: 10,spreadRadius: 4, offset: Offset(0, 4))], color: Colors.grey.shade400, borderRadius: BorderRadius.circular(10)),),
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        SingleChildScrollView(
        child: Column(
          children: [
            Container(
               width: double.infinity,
                 height: 300,
                 decoration: BoxDecoration(gradient: gradientOne()),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                 Padding(padding: const EdgeInsets.only(top: 30, left: 25), child: Text("Starial", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),),
                 Padding(padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20), child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Column(
                         mainAxisAlignment: MainAxisAlignment.start,
                         children: [
                           Row(
                             children: [
                             Image.asset("assets/images/location.png", height: 40),
                             SizedBox(width: 10),
                             Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text("JIC, MCI colony", style: TextStyle(fontSize: 30)),
                                 Text("Katanga, Jabalpur", style: TextStyle(fontWeight: FontWeight.bold)),
                               ],
                             )],
                           ),
                         ],
                       ),
                     Container(decoration: BoxDecoration(boxShadow: [BoxShadow(spreadRadius: 1, blurRadius: 6, color: Colors.grey.shade500)], borderRadius: BorderRadius.circular(50)),
                       child: CircleAvatar(
                         backgroundColor: Colors.white,
                         child: Padding(
                           padding: const EdgeInsets.all(5.0),
                           child: Image.asset("assets/images/person.png", height: 60),
                         )
                       ),
                     )
                   ],),
                 ),
                 Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), child: searchBar(),),
                 Padding(padding: const EdgeInsets.all(20), child: SizedBox(
                       width: double.infinity,
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Column(children: [Image.asset("assets/images/category1.png",height: 35,),Text("All", style: Theme.of(context).textTheme.headlineSmall)],),
                           Column(children: [Image.asset("assets/images/category2.png",height: 30,),Text("Art & Craft", style: Theme.of(context).textTheme.headlineSmall)],),
                           Column(children: [Image.asset("assets/images/category3.png",height: 30,),Text("Writing Materials", style:Theme.of(context).textTheme.headlineSmall)],),
                           Column(children: [Image.asset("assets/images/category4.png",height: 30,),Text("Fancy Stationery", style: Theme.of(context).textTheme.headlineSmall)],),
                       ],
                     ),
                   ),
                 ),
               ],
               )
             ),
            Container(width: double.infinity, color: Colors.white, child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Previous Search Results", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                      child: squareObjects(itemCount: 2)
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Daily Essentials", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
                               Container(decoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.grey.shade400, offset: Offset(0, 3),blurRadius: 5, spreadRadius: 2)], borderRadius: BorderRadius.circular(50)),
                                   child: Image.asset("assets/images/essential1.png", height: 80)),
                               Container(decoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.grey.shade400, offset: Offset(0, 3),blurRadius: 5, spreadRadius: 2)], borderRadius: BorderRadius.circular(50)),
                                   child: Image.asset("assets/images/essential2.png", height: 80)),
                               Container(decoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.grey.shade400, offset: Offset(0, 3),blurRadius: 5, spreadRadius: 2)], borderRadius: BorderRadius.circular(50)),
                                   child: Image.asset("assets/images/essential3.png", height: 80)),
                               Container(decoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.grey.shade400, offset: Offset(0, 3),blurRadius: 5, spreadRadius: 2)], borderRadius: BorderRadius.circular(50)),
                                   child: Image.asset("assets/images/essential4.png", height: 80)),
                            ],),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(width: double.infinity, decoration: BoxDecoration(gradient: LinearGradient(
                  colors: [Color.fromRGBO(159, 225, 255, 0),Color.fromRGBO(127, 229, 255, 1)], begin: Alignment.topCenter,end: Alignment.bottomCenter)
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                    Text("May Offers", style: TextStyle(fontFamily: 'KolkerBrush', fontSize: 60)),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    // child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                    //   Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),boxShadow: [BoxShadow(offset: Offset(0, 4),color: Colors.grey.shade700,blurRadius: 5,spreadRadius: 1)]),child:
                    //   ClipRRect(borderRadius: BorderRadius.circular(20),child: Image.asset("assets/images/offer1.png", height: 150),))
                    // ]),
                    child: imageSlider(imageList: imageListOne)
                  )
                ],),
              ),
            ),
            Container(width: double.infinity, color: Colors.white, child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 30),
                child: ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.asset("assets/images/classmate.png"))
              ),
            ),
            Container(width: double.infinity, color: Colors.white, child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 40),
                child: GridView.builder(itemCount: 4,shrinkWrap: true, physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 20,mainAxisSpacing: 0,childAspectRatio: 1),
                    itemBuilder: (context,index){
                       return Column(
                         mainAxisAlignment: MainAxisAlignment.start,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           Image.asset("assets/images/${cateImages[index]}", fit: BoxFit.contain),
                           Text(categories[index], textAlign: TextAlign.center,),
                         ],
                       );
                    }),
              ),
            ),
            Container(color: Colors.white, child: Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
                  Container(
                    decoration: BoxDecoration(boxShadow: [BoxShadow(blurRadius: 5,spreadRadius: 2,color: Colors.grey.shade500, offset: Offset(0, 3))],borderRadius: BorderRadius.circular(20)),
                    child: ClipRRect(borderRadius: BorderRadius.circular(20),child:
                      Image.asset("assets/images/board1.png",height: 100),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(boxShadow: [BoxShadow(blurRadius: 5,spreadRadius: 2,color: Colors.grey.shade500, offset: Offset(0, 3))],borderRadius: BorderRadius.circular(20)),
                    child: ClipRRect(borderRadius: BorderRadius.circular(20),child:
                      Image.asset("assets/images/board2.png",height: 100),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(boxShadow: [BoxShadow(blurRadius: 5,spreadRadius: 2,color: Colors.grey.shade500, offset: Offset(0, 3))],borderRadius: BorderRadius.circular(20)),
                    child: ClipRRect(borderRadius: BorderRadius.circular(20),child:
                      Image.asset("assets/images/board3.png",height: 100),
                    ),
                  ),
                ]),
              ),
            ),
            Container(color: Colors.white,child: Padding(padding: const EdgeInsets.symmetric(horizontal: 20.0), child: rectangleObjects())),
            Container(color: Colors.white,child: Padding(padding: const EdgeInsets.symmetric(horizontal: 20.0), child: rectangleObjects(crossAxisCount: 1, itemCount: 1, childAspectRatio: 2))),
            Container(color: Colors.white, child: Padding(padding: const EdgeInsets.symmetric(horizontal: 20.0), child: circleObjects())),
            Container(color: Colors.white,child: Padding(padding: const EdgeInsets.symmetric(vertical: 20.0), child: imageSlider(imageList: imageListTwo, height: 300),)),
            Container(color: Colors.white, child: Padding(padding: const EdgeInsets.symmetric(horizontal: 20.0), child: squareObjects(itemCount: 4))),
            Container(color: Colors.white,child: Padding(padding: const EdgeInsets.symmetric(horizontal: 20.0), child: rectangleObjects())),
            Container(color: Colors.white,child: Padding(padding: const EdgeInsets.symmetric(horizontal: 20.0), child: rectangleObjects(crossAxisCount: 1, itemCount: 1, childAspectRatio: 2))),
            Container(color: Colors.white, child: Padding(padding: const EdgeInsets.symmetric(horizontal: 20.0), child: squareObjects())),
            endOfPage()
          ],
        ),
      ),
        bottomNavbar(context),
     ])
    );
  }
}

