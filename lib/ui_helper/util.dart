import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


Container searchBar({searchText="Search for items here.", fontS=20.0}){
  return Container(
    height: 50,
    decoration: BoxDecoration(color: Colors.white,boxShadow: [BoxShadow(color: Colors.grey.shade600, spreadRadius: 1, blurRadius: 6, offset: Offset(0, 5))], borderRadius: BorderRadius.circular(40),),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
       Padding(
         padding: const EdgeInsets.only(left: 10.0),
         child: Row(children: [
           InkWell(
             // onTap: (){ Routes.navigateToSearchScreen(context); },
             child: Icon(Icons.search, size: 30,),
           ),
           SizedBox(width: 10,),
           Text(searchText, style: TextStyle(color: Colors.grey, fontSize: fontS),)
         ],),
       ),
       Padding(
         padding: const EdgeInsets.only(right: 10.0),
         child: InkWell(
          // onTap: (){
          //   context.read<HomePageProvider>().setMicClickBtn(true);
          //   Routes.navigateToSearchScreen(context);
          // },
          child: Icon(Icons.mic, size: 30,),
               ),
       )
    ],
    )
  );
}

// TextField(
//       keyboardType: TextInputType.text,
//       decoration: InputDecoration(
//           hintText: 'Search for "$searchText"',
//           hintStyle: TextStyle(color: Colors.grey, fontSize: fontS),
//           fillColor: Colors.white,
//           filled: true,
//           prefixIcon: Icon(Icons.search, size: 30,),
//           suffixIcon: Icon(Icons.mic, size: 30),
//           border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(40),
//               borderSide: BorderSide.none
//           )
//       ),
//     ),

LinearGradient gradientOne(){
  return LinearGradient(
      colors: [
        Color.fromRGBO(161, 159, 255, 1),
        Color.fromRGBO(7, 220, 253, 0.94),
        Color.fromRGBO(84, 209, 234, 0.22),
        Color.fromRGBO(0, 246, 255, 0),
      ],
      begin: Alignment.topCenter, end: Alignment.bottomCenter)
  ;
}

Positioned bottomNavbar(BuildContext context){
  return Positioned(bottom: 0,left: 0,right: 0,child: Container(width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          boxShadow: [BoxShadow(color: Colors.grey.shade500, blurRadius: 15, spreadRadius: 1)],
          gradient: LinearGradient(colors: [Color.fromRGBO(0, 255, 255, 1),Color.fromRGBO(255, 255, 255, 1)], begin: Alignment.topCenter,end: Alignment.bottomCenter)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 20),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
          Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,children: [
            Image.asset("assets/images/nav1.png",height: 30,),
            Text("Home", style: Theme.of(context).textTheme.headlineSmall)
          ],),
          Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,children: [
            Image.asset("assets/images/nav2.png",height: 30,),
            Text("Categories",style: Theme.of(context).textTheme.headlineSmall)
          ],),
          Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,children: [
            Image.asset("assets/images/nav3.png",height: 30,),
            Text("Explore",style: Theme.of(context).textTheme.headlineSmall)
          ],),
          Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,children: [
            Image.asset("assets/images/nav4.png",height: 30,),
            Text("Uniforms",style: Theme.of(context).textTheme.headlineSmall)
          ],),
          Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,children: [
            Icon(Icons.shopping_cart, size: 30,),
            Text("Cart",style: Theme.of(context).textTheme.headlineSmall)
          ],),
        ],),
      )
  )
  );
}

Container endOfPage(){
  return Container(
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.only(top: 10,bottom: 70),
      child: Row(children: [
        Image.asset("assets/images/endOfPage.jpg",height: 200),
        SizedBox(width: 200,child: Text("Oops, you reached the end of the page",textAlign: TextAlign.center, softWrap: true,))
      ],),
    ),
  );
}

CircleAvatar backButton(){
  return CircleAvatar(backgroundColor: Colors.grey.shade200, radius: 25,child: Icon(Icons.arrow_back, color: Colors.black, size: 25),);
}

// It takes array of image names(with extension) as items
GridView circleObjects({int itemCount= 8, List<String> items= const ["Value1", "Value 2"]}){
  return  GridView.builder(itemCount: itemCount,shrinkWrap: true, physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 10,mainAxisSpacing: 10,childAspectRatio: 1),
      itemBuilder: (context,index){
        return CircleAvatar(backgroundColor: Colors.grey.shade400,radius: 40,
              // UNCOMMENT THIS WHEN IMAGES ARE AVAILABLE
              // child: Image.asset("assets/images/${items[index]}"),
        );
  });
}

// It takes array of image names(with extension) as items
GridView squareObjects({int itemCount= 8, List<String> items= const ["Value1", "Value 2"]}){
  return  GridView.builder(itemCount: itemCount,shrinkWrap: true, physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 10,mainAxisSpacing: 10,childAspectRatio: 1),
      itemBuilder: (context,index){
        return Container(width: 80,height: 80, decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.grey.shade400,),
              // UNCOMMENT THIS WHEN IMAGES ARE AVAILABLE
              // child: Image.asset("assets/images/${items[index]}", fit: BoxFit.cover),
        );
      });
}

// It takes array of image names(with extension) as items
GridView rectangleObjects({int itemCount= 2, List<String> items= const ["Value1", "Value 2"], int crossAxisCount = 2, double childAspectRatio = 1.5}){
  return  GridView.builder(itemCount: itemCount,shrinkWrap: true, physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: crossAxisCount, crossAxisSpacing: 15,mainAxisSpacing: 0,childAspectRatio: childAspectRatio),
      itemBuilder: (context,index){
        return Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.grey.shade400),
               // UNCOMMENT THIS WHEN IMAGES ARE AVAILABLE
               // child: Image.asset("assets/images/${items[index]}", fit: BoxFit.cover),
        );
      });
}

// Image Slider
SingleChildScrollView imageSlider({imageList, int currentIndex = 0,double height = 200}){
  return SingleChildScrollView(child:
  Column(children: [
    CarouselSlider(items: imageList, options: CarouselOptions(
        autoPlay: true,
        height: height,
        // enableInfiniteScroll: false,
        autoPlayCurve: Curves.fastOutSlowIn,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayInterval: const Duration(milliseconds: 100),
        enlargeCenterPage: true,
        aspectRatio: 2.0,
        onPageChanged: (index,reason){
          setState(() {
            currentIndex = index;
          });
        }
    ),
    ),
    Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: AnimatedSmoothIndicator(activeIndex: currentIndex,count: imageList.length,
      effect: WormEffect(dotHeight: 5,dotColor: Colors.grey.shade300, activeDotColor: Colors.grey,paintStyle: PaintingStyle.fill),),
    )
     ],)
    ,);
}

void setState(Null Function() param0) {
}