import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starial_app/address.dart';
import 'package:starial_app/cart.dart';
import 'package:starial_app/different-styles.dart';
import 'package:starial_app/print_document.dart';
import 'package:starial_app/print_documents_preview.dart';
import 'package:starial_app/scan_file.dart';
import 'package:starial_app/free-delivery.dart';
import 'package:starial_app/home_page.dart';
import 'package:starial_app/categories_page.dart';
import 'package:starial_app/loading_page.dart';
import 'package:starial_app/novels-dedicated-page.dart';
import 'package:starial_app/office_stationery_dedicated_page.dart';
import 'package:starial_app/order_confirmed.dart';
import 'package:starial_app/tip_delivery_partner.dart';
import 'package:starial_app/ui_helper/util.dart';
import 'package:starial_app/uniform-dedicated-page.dart';

import 'DocumentProvider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => DocumentProvider()),
    ],
    child: StarialApp(),
  ),);
}

class StarialApp extends StatelessWidget {
  const StarialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Starial App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
        fontFamily: 'SFProDisplay',
        textTheme: TextTheme(
          headlineSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
        )
      ),
      // home: OfficeStationeryDedicatedPage(),
      // home: NovelsDedicatedPage(),
      // home: UniformDedicatedPage(),
      // home: FreeDeliveryPopUp(),
      // home: HomeScreen(),
      // home: TipDeliveryPartner()
      // home: LoadingPage(),
      // home: LoginScreen(),
      // home: HomePage(),
      // home: CategoriesScreen(),
      // home: CartScreen(),
      // home: AddressScreen(),
      // home: OrderConfirmed(),
      // home: DifferentStyles(),
      // home: ScanFile(),
      // home: PrintDocumentsPreview(),
      home: PrintDocument(),
    );
  }
}


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Timer(Duration(seconds: 3), (){
    //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
    // });
  }
  @override
  Widget build(BuildContext build){
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF00FFFF),
                Color(0xFF00E4FF),
                Color(0xFF00DAFF),
                Color(0xFF009CFF),
                Color(0xFF0084FF),
                Color(0xFF0040FF),
              ]
          )
        ),
        child: Center(child: Image.asset("assets/images/app-logo.png")),
      ),
    );
  }
}

class CountryCode{
  final String flagPath;
  final String dialCode;
  CountryCode({required this.flagPath, required this.dialCode});
}

class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  // void initState() {
  //   super.initState();
  //   Timer(Duration(seconds: 3), (){
  //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoadingPage()));
  //   });
  // }
  final List<CountryCode> countryCodes = [
    CountryCode(flagPath: "assets/images/flag.png", dialCode: '+91'),
    CountryCode(flagPath: "assets/images/flag.png", dialCode: '+1'),
    CountryCode(flagPath: "assets/images/flag.png", dialCode: '+44'),
  ];

  CountryCode? selectedCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF66FFFF), Color(0xFF668CFF)]
                  )
              ),
          ),
          Positioned(top: 50, left: 0, right: 0, child: Image.asset("assets/images/app-logo.png",height: 100,)),
          Positioned(bottom: 0, left: 0, right: 0, child: Padding(padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Container(
                  width: 400,
                  // height: 500,
                  // color: Colors.white,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                    boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 15, spreadRadius: 2)],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Text("Let's Get Started", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            children: [
                              Expanded(flex: 1,child: Container(height: 2,color: Colors.grey.shade300)),
                              Expanded(flex: 1,child: Center(child: Text("Log in or sign up",style: TextStyle(fontWeight: FontWeight.bold)))),
                              Expanded(flex: 1,child: Container(height: 2,color: Colors.grey.shade300)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                          boxShadow: [BoxShadow(blurRadius: 6, color: Colors.grey.shade300, spreadRadius: 3)],
                                          borderRadius: BorderRadius.circular(10), color: Colors.white
                                      ),
                                      child: DropdownButton(value: selectedCode,
                                          hint: Padding(
                                            padding: const EdgeInsets.only(left: 8.0),
                                            child: Image.asset(countryCodes.first.flagPath,height: 35,),
                                          ),
                                          icon: Icon(Icons.arrow_drop_down),
                                        onChanged: (CountryCode? newValue){
                                        setState((){
                                          selectedCode = newValue!;
                                        });
                                      }, underline: SizedBox(),
                                        items: countryCodes.map((code){
                                          return DropdownMenuItem<CountryCode>(value: code,child:
                                             Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,crossAxisAlignment: CrossAxisAlignment.center,children: [Image.asset(code.flagPath, height: 20,), Text(code.dialCode, style: TextStyle(fontSize: 12),)],)
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                          boxShadow: [BoxShadow(blurRadius: 6, color: Colors.grey.shade300, spreadRadius: 3)],
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: TextField(
                                        style: TextStyle(color: Colors.grey.shade500),
                                        keyboardType: TextInputType.phone,
                                        decoration: InputDecoration(
                                            hintText: "00000 00000",
                                            hintStyle: TextStyle(color: Colors.grey.shade400),
                                            contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                                borderSide: BorderSide.none
                                            ),
                                            fillColor: Colors.white, filled: true
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              TextButton(onPressed: (){}, style: TextButton.styleFrom(
                                  backgroundColor: Color(0xFF67B3FF), minimumSize: Size(double.infinity, 20)),
                                  child: Text("Continue", style: TextStyle(color: Colors.white),))
                            ],
                          ),
                        ),
                        Row(children: [
                            Expanded(flex: 2,child: Container(height: 2,color: Colors.grey.shade300)),
                            Expanded(flex: 1,child: Center(child: Text("or",style: TextStyle(fontWeight: FontWeight.bold)))),
                            Expanded(flex: 2,child: Container(height: 2,color: Colors.grey.shade300)),
                          ],
                        ),
                        Padding(padding: const EdgeInsets.all(12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Use email", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: InkWell(onTap: (){},
                                  child: Container(width: 40, height: 40,
                                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 6, spreadRadius: 3,),]),
                                        child: Center(child: Padding(padding: const EdgeInsets.all(7.0), child: Image.asset("assets/images/google-logo2.png"))),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(padding: const EdgeInsets.only(bottom: 20),
                          child: Column(
                            children: [
                              Text("By continuing, you agree to our", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400)),
                              Text("Terms of service  Privacy Policy  Content Policies", style: TextStyle(fontSize: 10)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
          ),
          Positioned(top:50, left:60, right: 0, child: Image.asset("assets/images/delivery-boy.png", height: 480,),),
        ],
      ),
    );
  }
}