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

// Container endOfPage(){
//   return Container(
//     color: Colors.white,
//     child: Padding(
//       padding: const EdgeInsets.only(top: 10,bottom: 70),
//       child: Row(children: [
//         Image.asset("assets/images/endOfPage.jpg",height: 200),
//         SizedBox(width: 200,child: Text("Oops, you reached the end of the page",textAlign: TextAlign.center, softWrap: true,))
//       ],),
//     ),
//   );
// }

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
GridView rectangleObjects({int itemCount= 2, List<String> items= const ["Value 1", "Value 2"], int crossAxisCount = 2, double childAspectRatio = 1.5}){
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

Widget showProductsHorizontally(List<Map<String,dynamic>> products, String title,
    {int itemCount = 4}){
  return Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
    Padding(padding: const EdgeInsets.only(top: 10,left: 15.0),
      child: Text(title,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.black),),
    ),
    SizedBox(height: 10,),
    Padding(padding: const EdgeInsets.only(left: 15.0),
      child: SizedBox(
        height: 230,
        child: ListView.builder(scrollDirection: Axis.horizontal,itemBuilder: (context,idx){
        return Padding(
          padding: const EdgeInsets.only(right: 4.0),
          child: SizedBox(
            width: 120,
            height: 180,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                Container(width: 110,height: 100,decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12)
                ),
                  child: Image.asset("assets/images/${products[idx]['image']}"),
                ),
                SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(231, 247, 255, 1),
                    border: Border.all(color: Color.fromRGBO(26, 175, 250, 1)),
                    borderRadius: BorderRadius.circular(4)
                ),child: Text('short detail', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold),),),
                Text(products[idx]['title'], style: TextStyle(fontWeight: FontWeight.w700, letterSpacing: 0),overflow: TextOverflow.ellipsis,maxLines: 2,),
                Row(mainAxisAlignment: MainAxisAlignment.start,children: [
                  Row(children: List.generate(5, (index){
                    // int rating  = double.tryParse(product['rating'] ?? 0)?.toInt() ?? 0;
                    return Icon(Icons.star, color: index < products[idx]['rating'] ? Colors.amber: Colors.grey,size: 13);
                  }),
                  ),
                  SizedBox(width: 5,),
                  // Text('(${product['no_of_ratings']})', style: TextStyle(color: Colors.grey, fontSize: 13),)
                  Text('(${products[idx]['noOfRatings']})', style: TextStyle(color: Colors.grey, fontSize: 13),)
                ]),
                Text(products[idx]['price'],style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
              ],),
            )
          ),
        );
        },itemCount: itemCount,),
      ),
    ),
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 15),
      child: Container(
        padding: EdgeInsets.all(15),
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('See more products like this', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),),
          Icon(Icons.chevron_right)
        ],
      ),),
    ),

  ],);
}

Widget horizontalCategoryList(List<Map<String, dynamic>> featuredDeals){
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       Text('Featured Deals', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
       SizedBox(height: 10,),
       Container(
         width: double.infinity,
         height: 150,
         // color: Colors.pink,
         child: ListView.builder(scrollDirection: Axis.horizontal,itemCount: featuredDeals.length,itemBuilder: (context,index){
           return Padding(
             padding: const EdgeInsets.only(left: 11.0),
             child: SizedBox(
               width: 112,
               height: 130,
               child: Stack(
                   children: [
                      ClipRRect(borderRadius: BorderRadius.circular(10),
                        child: Image.asset('assets/images/${featuredDeals[index]['image']}', fit: BoxFit.fill,width: 112,)
                      ),
                      Positioned(bottom: 0,left: 0,right: 0,
                          child: Container(
                            width: 112,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                              gradient: LinearGradient(colors: [
                                Color.fromRGBO(0,0,0,1),
                                Color.fromRGBO(0,0,0,0),
                              ],begin: Alignment.bottomCenter, end: Alignment.topCenter)
                            ),
                          )
                      ),
                      Positioned(
                          bottom: 5,left: 5, right: 5,
                          child: Text(featuredDeals[index]['title'], style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,)
                      )
                   ]
               ),
             ),
           );
         }),
       )
    ],)
  );
}

Column endOfPage(context){
  return Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
    SizedBox(width: 250,height: 200,
        child: Text('It doesn’t just end here !',
          style: TextStyle(fontSize: 50,fontWeight: FontWeight.w900,color: Color.fromRGBO(96, 96, 96, 1),letterSpacing: 0),
        )),
    SizedBox(width: 160,
      child: ElevatedButton(style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shadowColor: Color.fromRGBO(0, 0, 0, 0.65),
          elevation: 4
      ), onPressed: (){
        // Navigator.push(context, MaterialPageRoute(builder: (context)=> Explore()));
      }, child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Text('Keep Exploring', style: TextStyle(color: Color.fromRGBO(96, 96, 96, 1), fontWeight: FontWeight.w500),), Icon(Icons.open_in_new, color: Color.fromRGBO(96, 96, 96, 1),size: 20,)],)),
    )
  ],);
}