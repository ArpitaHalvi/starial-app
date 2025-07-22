import 'package:flutter/material.dart';

class NovelsDedicatedPage extends StatelessWidget {
  NovelsDedicatedPage({super.key});

  final List<Map<String, dynamic>> novels = [
    {'title':'Fiction books','desc':'Get yourself or your loved ones their favourite stories at lowest price!','image':'novels1.png'},
    {'title':'Non-Fiction books','desc':'Dive deep into learning and productivity, get self help books now!','image':'novels2.png'},
    {'title':'Children books','desc':'Books that children loves. Stories, poems, drawings, we have it all!','image':'novels3.png'},
    {'title':'Book sets','desc':'Get books sets at your doorstep, grab exciting offers now!','image': '','images':['novels4.png','novels5.png','novels6.png']},
  ];

  Widget buildImageSection(int index){
     return novels[index]['image'] != '' ? Stack(
       children: [
         Container(
           width: 115,
           height: 140,
           decoration: BoxDecoration(
               image: DecorationImage(image: AssetImage('assets/images/${novels[index]['image']}'),fit: BoxFit.cover, alignment: Alignment.topCenter)
           ),
         ),
         Positioned(bottom: 0,left: 0,right: 0,
           child: Container(width: 115,height: 30,decoration: BoxDecoration(
             gradient: LinearGradient(colors: [
               Color.fromRGBO(0, 0, 0, 0.6),Color.fromRGBO(0, 0, 0, 0.2),Color.fromRGBO(0, 0, 0, 0)
             ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
           ),),
         )
       ],
     ) :
     ClipRect(
       child: SizedBox(
         width: 155,
         height: 150,
         child: Stack(clipBehavior: Clip.none,children: [
           Positioned(top: 20,left: 45,child: Image.asset('assets/images/${novels[index]['images'][2]}',width: 115,height: 140,)),
           Positioned(top: 10,left: 25,child: Image.asset('assets/images/${novels[index]['images'][1]}',width: 115,height: 140)),
           Image.asset('assets/images/${novels[index]['images'][0]}',width: 115,height: 150),
         ],),
       ),
     );
  }

  Widget buildTextSection(int index){
    return SizedBox(
      width: 160,
      child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: index %2 == 0 ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Text(novels[index]['title'],softWrap: true, textAlign: TextAlign.right, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,letterSpacing: 0)),
          Text(novels[index]['desc'],softWrap: true,textAlign: index %2 == 0 ? TextAlign.left : TextAlign.right,style: TextStyle(fontSize: 10, height: 1)),
          SizedBox(height: 5,),
          InkWell(onTap: (){},child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [BoxShadow(blurRadius: 6.5, spreadRadius: 0, color: Color.fromRGBO(0, 0, 0, 0.09))]
            ),
            child: Text('Check out', style: TextStyle(fontSize: 10),),
          ),)
        ],),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
           SizedBox(
             height: 700,
             child: ListView.builder(itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 5),
                  child: Container(
                    width: double.infinity,
                    height: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(colors: [Color.fromRGBO(159, 213, 230, 1), Color.fromRGBO(255, 255, 255, 0)], begin: Alignment.bottomCenter,end: Alignment.topCenter)
                    ),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,crossAxisAlignment: CrossAxisAlignment.end,
                      children: (index % 2 == 0) ? [
                        buildImageSection(index),
                      buildTextSection(index)
                      ] : [
                        buildTextSection(index),
                        buildImageSection(index)
                      ],
                    ),
                  ),
                );
             },itemCount: 4,),
           )
        ],),
      ),
    );
  }
}
