import 'dart:io';
import 'package:flutter/material.dart';

class Cursorwidget extends StatefulWidget {
  const Cursorwidget({super.key});

  @override
  State<Cursorwidget> createState() => _CursorwidgetState();
}

class _CursorwidgetState extends State<Cursorwidget> {

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

@override
  void initState() {
      loop();
    super.initState();
  }
  double opacity = 1;
  @override
  Widget build(BuildContext context) {

    return AnimatedContainer(height: 20,color: Color.fromRGBO(255,58,88, opacity),width: 6,duration: Duration(seconds: 1),);
  }

  loop()async{


      
    while(true){
        try {
          setState(() {
                    
        }); 
        } catch (e) {
         break;
        }
        await Future.delayed(Duration(seconds: 1));
        if(opacity==0){
            opacity=1;
        }else{
            opacity=0; 
        }
    }
   
  }

  
}