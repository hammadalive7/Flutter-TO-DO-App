
import 'package:flutter/material.dart';
import 'package:flutter_to_do/UI/theme.dart';
import 'package:get/get.dart';

class NotifiedPage extends StatelessWidget {
  final String? lebal;
  const NotifiedPage({Key? key, required this.lebal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: pinkClr,
        centerTitle: true,
        leading: IconButton(
          onPressed: ()=>Get.back(),
          icon: Icon(Icons.arrow_back_ios, color: yellowClr,),
        ),
        title: Text(this.lebal.toString().split("|")[0], style: TextStyle(color: Colors.black),),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 20),
            height: 450,
            width: 330,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                    color: PrimaryClr,
            ),
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      this.lebal.toString().split("|")[1],
                      style: TextStyle(color: Get.isDarkMode?Colors.black:Colors.white,
                      fontSize: 30,
                      ),),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    this.lebal.toString().split("|")[2],
                    style: TextStyle(color: Get.isDarkMode?Colors.black:Colors.white,
                      fontSize: 20,
                    ),

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
