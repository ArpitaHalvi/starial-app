import 'package:flutter/material.dart';
import 'package:starial_app/ui_helper/util.dart';

class UniformDedicatedPage extends StatelessWidget {
  UniformDedicatedPage({super.key});

  final List<Map<String,dynamic>> uniformsFor = [
    {'title':'Uniforms for boys','image':'boy.png','desc':'Shirt, pants, shoes and many more',
      'gradientColors': <Color>[Color.fromRGBO(0, 149, 255, 1),Color.fromRGBO(157, 209, 255, 1)]},
    {'title':'Uniforms for girls','image':'girl.png','desc':'Skirts, shirts, shots and many more',
      'gradientColors': <Color>[Color.fromRGBO(255, 54, 228, 1),Color.fromRGBO(255, 190, 237, 1)]
    },
  ];

  final uniformItems = [
    {'title':'Ties','image': 'ties.png'},
    {'title':'Socks','image': 'socks.png'},
    {'title':'Belts','image': 'belts.png'},
    {'title':'Shoes','image': 'shoes.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column( crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,height: 120,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                   Colors.lightBlue, Colors.white
                ],begin: Alignment.topCenter, end: Alignment.bottomCenter),
                border: Border(bottom: BorderSide(color: Colors.grey.shade200))
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      // color: Colors.grey,
                      border: Border.all(
                          // color: colors.darkColor3
                          color: Colors.grey.shade300
                      ),
                      borderRadius: BorderRadius.circular(30,),
                    ),
                    // height: 30,
                    child: TextField(
                      style: TextStyle(
                        // color: Theme.of(context).colorScheme.fontColor,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                      // controller: searchController,
                      autofocus: false,
                      enabled: true,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              // color: colors.grad1Color
                              color: Colors.blue
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        contentPadding:
                        const EdgeInsets.fromLTRB(15.0, 5.0, 0, 5.0),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        // fillColor: colors.grad1Color,
                        fillColor: Colors.white,
                        filled: true,
                        isDense: true,
                        // hintText: getTranslated(context, 'searchHint'),
                        hintText: 'Search for uniforms',
                        hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          // color: Theme.of(context).colorScheme.fontColor,
                          color: Colors.grey,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.all(4.0),
                              child: CircleAvatar(
                                // backgroundColor: colors.primary,
                                backgroundColor: Colors.transparent,
                                child: const Padding(
                                    padding: EdgeInsets.all(2.0),
                                    child: Icon(Icons.search, color: Colors.black,)
                                ),
                              ),
                            ),
                          ),
                        ),
                        // suffixIcon:
                        //  searchController.text != ''
                        //     ? Padding(
                        //   padding: const EdgeInsets.all(5.0),
                        //   child: IconButton(
                        //     onPressed: () {
                        //       FocusScope.of(context).unfocus();
                        //       searchController.clear();
                        //       offset = 0;
                        //       isLoadingmore = true;
                        //       query = '';
                        //       offset = 0;
                        //       getProduct('0');
                        //       setState(() {});
                        //     },
                        //     icon: Icon( Icons.close, color: Theme.of(context).colorScheme.fontColor,
                        //     ),
                        //   ),
                        // ) :
                        suffixIcon:  Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: CircleAvatar(
                            backgroundColor:Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: GestureDetector(
                                onTap: () {
                                  // lastWords = '';
                                  // if (!_hasSpeech) {
                                  //   initSpeechState();
                                  // } else {
                                  //   showSpeechDialog();
                                  // }
                                },
                                // child: Selector<ThemeNotifier, ThemeMode>(
                                //   selector: (_, themeProvider) =>
                                //       themeProvider.getThemeMode(),
                                //   builder: (context, data, child) {
                                //     return (data == ThemeMode.system &&
                                //         MediaQuery.of(context)
                                //             .platformBrightness ==
                                //             Brightness.light) ||
                                //         data == ThemeMode.light
                                //         ? SvgPicture.asset(
                                //       DesignConfiguration
                                //           .setSvgPath(
                                //           'voice_search'),
                                //       height: 18,
                                //       width: 18,
                                //     )
                                //         : SvgPicture.asset(
                                //       DesignConfiguration
                                //           .setSvgPath(
                                //           'voice_search_white'),
                                //       height: 15,
                                //       width: 15,
                                //     );
                                //   },
                                // ),
                                child: Icon(Icons.mic),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  Padding(padding: const EdgeInsets.only(left: 15.0),
                    child: Text('Choose your schools', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: SizedBox(
                      height: 80,
                      child: ListView.builder(scrollDirection: Axis.horizontal,itemBuilder: (context,index){
                        return Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: InkWell(
                            onTap: (){},
                            child: Container(
                              width: 80, height: 80,
                               padding: EdgeInsets.all(5),
                               decoration: BoxDecoration(
                                 color: Colors.grey.shade100,
                                 borderRadius: BorderRadius.circular(10)
                               ),
                               // child: Image.asset('assets/images/shirt.png'),
                            ),
                          ),
                        );
                      },itemCount: 8,),
                    ),
                  )
            ],),),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(width: double.infinity,height: 250,
                // color: Colors.pink,
                child: ListView.builder(scrollDirection: Axis.horizontal,itemBuilder: (context,index){
                 return Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 11.0),
                   child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
                     Image.asset('assets/images/${uniformsFor[index]['image']}',width: 163,height: 150,),
                     Container(
                       width: 163,height: 68,
                       decoration: BoxDecoration(
                         gradient: LinearGradient(colors: uniformsFor[index]['gradientColors'], begin: index == 0 ? Alignment.centerLeft : Alignment.centerRight, end: index == 0 ? Alignment.centerRight : Alignment.centerLeft),
                         borderRadius: BorderRadius.circular(10)
                       ),
                       child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
                         Text(uniformsFor[index]['title'], style: TextStyle(fontSize: 14,color: Colors.white, fontWeight: FontWeight.bold),),
                         Text(uniformsFor[index]['desc'],style: TextStyle(fontSize: 9, color: Colors.white),)
                       ],),
                     )
                   ],),
                 );
              },itemCount: uniformsFor.length),),
            ),
            Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,children: [
              Text('Featured Deals', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
              Text('Grab exciting offers on school uniforms before they run out!', style: TextStyle(fontSize: 9),),
              SizedBox(height: 15,),
              Row(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(3, (index){
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(width: 109,height: 156,decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10)
                    ),),
                  );
                })
              ),
              SizedBox(height: 10,)
            ],),
            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text('Other uniform items', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: SizedBox(
                    height: 80,
                    child: ListView.builder(scrollDirection: Axis.horizontal,itemBuilder: (context,index){
                      return Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: InkWell(
                          onTap: (){},
                          child: Container(
                            width: 80, height: 80,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Column(
                              children: [
                                Image.asset('assets/images/${uniformItems[index]['image']}', height: 55,),
                                Align(alignment: Alignment.bottomLeft,child: Text('${uniformItems[index]['title']}', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 0),))
                              ],
                            ),
                          ),
                        ),
                      );
                    },itemCount: uniformItems.length,),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
