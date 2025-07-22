import 'package:flutter/material.dart';
import 'package:starial_app/ui_helper/util.dart';

class OfficeStationeryDedicatedPage extends StatelessWidget {
  OfficeStationeryDedicatedPage({super.key});

  final List<Map<String,dynamic>> products = [
    {'title': 'Camlin double side ruled notebook','rating':5,'noOfRatings':5,'price':'\u20B9135','image':'office-essentials1.png'},
    {'title': 'Camlin double side ruled notebook','rating':3,'noOfRatings':2,'price':'\u20B9135','image':'office-essentials2.png'},
    {'title': 'Camlin double side ruled notebook','rating':2,'noOfRatings':1,'price':'\u20B9135','image':'office-essentials3.png'},
    {'title': 'Camlin double side ruled notebook','rating':4,'noOfRatings':2,'price':'\u20B9135','image':'office-essentials4.png'},
    {'title': 'Camlin double side ruled notebook','rating':1,'noOfRatings':1,'price':'\u20B9135','image':'office-essentials5.png'},
  ];

  final List<Map<String,dynamic>> featuredDeals = [
    {'title':'Electronic items','image':'featured-deal1.png'},
    {'title':'Notebooks','image':'featured-deal2.png'},
    {'title':'Print Documents','image':'featured-deal3.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Container(
                width: double.infinity,
                height: 300,
                color: Colors.white,
                child: Stack(children: [
                  Positioned(top: 30,left: 0,right: 0,child: Image.asset("assets/images/office-stationery-banner.png")),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: IconButton(onPressed: (){
                      Navigator.pop(context);
                    }, icon: Icon(Icons.arrow_back_ios, color: Colors.black,)),
                  )
                ],),
              ),
              showProductsHorizontally(products, 'Office Essentials'),
              horizontalCategoryList(featuredDeals),
              showProductsHorizontally(products, 'Office Essentials'),
          ],),
        ),
      ),
    );
  }
}
