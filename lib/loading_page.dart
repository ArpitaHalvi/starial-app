import 'dart:async';

import 'package:flutter/material.dart';
import 'package:starial_app/home_page.dart';

class LoadingPage extends StatefulWidget{
  const LoadingPage({super.key});


  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  late Timer _timer;
  final icons = ['✏️','🖊️','📚','🎒','📖','📃'];
  final sentences = ['Arranging books and organizing desks...\nHold tight!',
    'Sharpening pencils and stacking notebooks... \nJust a moment',
    'Packing bags and zipping zippers...\nWe’re getting ready!',
    'Highlighting key points and underlining goals...\nAlmost ready!'
  ];
  int currentIndex = 0;
  int currIndex = 0;
  bool isMounted = true;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer){
      setState(() {
        currIndex = (currIndex + 1) % sentences.length;
      });
    });
    _startReel();
  }

  void _startReel () async {
    while(isMounted){
      await Future.delayed(Duration(milliseconds: 500));
      if(!isMounted) break;
      setState(() {
        currentIndex = (currentIndex + 1) % icons.length;
      });
    }
  } 

  @override
  void dispose() {
    isMounted = false;
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       body: Container(
         decoration: BoxDecoration(
           // gradient: LinearGradient(colors: [
           //     Color(0xFF3b82f6),  Color(0xFF60a5fa),Color(0xFF93c5fd)
           // ], begin: Alignment.topCenter, end: Alignment.bottomCenter)
           color: Colors.white
         ),
         child: Center(child:
           Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               AnimatedSwitcher(duration: Duration(milliseconds: 200),
                 // Fade Animation
                 transitionBuilder: (Widget child, Animation<double> animation){
                    // return FadeTransition(opacity: animation, child:
                       // ScaleTransition(
                       //   scale: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
                       //   child: child,),
                    // );
                   return SlideTransition(
                     position: Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset.zero).animate(animation),
                     child: FadeTransition(opacity: animation, child: child,),
                   );
                 },
                 // child: Image.asset('assets/images/${images[currentIndex]}', width: 50, height: 50, color: Colors.white,),
                 child: Text(icons[currentIndex], key: ValueKey<String>(icons[currentIndex]),style: TextStyle(fontSize: 50),),
                 // Slide Animation
                 // transitionBuilder: (Widget child, Animation<double> animation){
                 //    final offsetAnimation =  Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset.zero).animate(animation);
                 //    return SlideTransition(position: offsetAnimation, child: child);
                 // },
               ),
               AnimatedSwitcher(duration: Duration(milliseconds: 600),
                 // Fade Animation
                 transitionBuilder: (Widget child, Animation<double> animation){
                   return FadeTransition(opacity: animation, child:
                   ScaleTransition(
                     scale: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
                     child: child,),
                   );
                 },
                 child: Padding(
                   padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30),
                   child: RichText(textAlign: TextAlign.center,text: TextSpan(style: TextStyle(fontSize: 15, color: Colors.black54,fontWeight: FontWeight.bold), children: [
                     TextSpan(text: sentences[currIndex].split('\n')[0]),
                     TextSpan(text: '\n'),
                     TextSpan(text: sentences[currIndex].split('\n')[1], style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black87)),
                   ])),
                 ),
               ),
             ],
           )
           ,),
       )
     );
  }
}