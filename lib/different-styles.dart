import 'package:flutter/material.dart';
import 'package:starial_app/ui_helper/util.dart';

class DifferentStyles extends StatelessWidget {
  const DifferentStyles({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Default Category Style',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
              defaultCategoryStyle(),
              Text('Category Style 1', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              categoryStyle1(),
              Text('Category Style 2', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              categoryStyle2(),
              Text('Category Style 3', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              categoryStyle3(),
              Text('Category Style 4', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              categoryStyle4(),
              Text('Subcategory Default Style', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              defaultSubCategoryStyle(),
              Text('Subcategory Style 1', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              subcategoryStyle1(),
              Text('Subcategory Style 2', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              subcategoryStyle2(),
              Text('Subcategory Style 3', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              subcategoryStyle3(),
            ],
          ),
        )
      ),
    );
  }
}
