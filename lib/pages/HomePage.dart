import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mate_graphics_app/pages/Widgets/CursorWidget.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Color primaryColor = Color.fromRGBO(255,58,88,1);
  Size? size = null;
  String eval = "";
  bool keyboardActive = false;

  Map<String, String> data = {"min":''};

  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(),
        body: Center(
          child: Container(
            width: size!.width,
            // color: Colors.amber,
            child: Center(
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
    
                        SizedBox(height:20,),
                        Image.asset('assets/big.png',width: 150,),
                        SizedBox(height:20,),
                        GestureDetector(
                          onTap: (){
                            keyboardActive = !keyboardActive;
                            setState(() {
                              
                            });
                          },
                          child:  Container(width: size!.width*0.9,height: 80,decoration:BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromRGBO(255,58,88,.2)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(child: Padding(
                              padding: const EdgeInsets.only(left:30.0),
                              child: Text("2D:",style: TextStyle(fontFamily: 'Fredoka',color: primaryColor),),
                            ),flex: 1),
                            Expanded(child: Stack(

                              children: [
                                Center(child: Row(
                                  children: [
                                   Align(alignment: Alignment.centerLeft,child: Text(eval==""?"":eval,style: TextStyle(fontFamily: 'Fredoka',color: eval==""?Color.fromRGBO(255,58,88,.2):primaryColor),)),

                                    keyboardActive?Cursorwidget():Container()
                                  ],
                                )),
                                Align(alignment: Alignment.centerLeft,child: Text(eval==""?"2*x^2 + 30":"",style: TextStyle(fontFamily: 'Fredoka',color: eval==""?Color.fromRGBO(255,58,88,.2):primaryColor),)),
                              ],
                            ),flex: 4,),
                            Expanded(child: IconButton(icon:Icon(Icons.send_rounded),color: primaryColor,onPressed: () async {
                                //Sen eval

                                keyboardActive = false;
                                setState(() {
                                  
                                });
                              load(context);
                              var request = http.Request('GET', Uri.parse('https://opt-api.herokuapp.com/optimize?funtion='+eval));
                              request.body = '''''';

                              http.StreamedResponse response = await request.send();

                              if (response.statusCode == 200) {


                                final dataresp = await response.stream.bytesToString();
                                final decode = jsonDecode(dataresp);

                                //get image
                                var request2 = http.Request('GET', Uri.parse('https://opt-api.herokuapp.com/imageByIdNameJpg?idName='+decode['idName'].toString()));
                                request2.body = '''''';

                                http.StreamedResponse response2 = await request2.send();

                                if (response2.statusCode == 200) {
                                  String nameImage = await response2.stream.bytesToString();
                                  nameImage = 'https://analysis-project.lulosys.com/public/storage/'+nameImage;

                                 final puntoMinimo = jsonDecode(decode['puntos'].replaceAll("'", "").replaceAll("b", "")); 
                                 

                                  
                              data = {
                                "min":puntoMinimo['min'].toString(),
                                "img":nameImage
                              };
                                }

                              }



                              print("Enviar");

                            
                              Navigator.pop(context);
                              setState(() {
                                
                              });
                            }),flex: 1,)
                          ],
                        ),
                        ),
                        ),

                        //Body

                        data['min'] == ''?  Expanded(
                          child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Envia un funcion para empezar",style: TextStyle(fontFamily: "Fredoka",color: primaryColor),)
                                ],
                            
                          ),
                        ): SingleChildScrollView(
                          child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  
                                  SizedBox(height: 20,),
                                  Text("El punto minimo para $eval es: " + data['min'].toString(),style: TextStyle(fontFamily: "Fredoka",color: primaryColor),),

                                  Image.network(data['img'].toString()),
                                ],
                              ),
                        ),
    
                      ],
                    ),
                  ),

                  //teclado
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          curve: keyboardActive?Curves.easeOut:Curves.easeIn,

                          color: Colors.white,
                          width: size!.width,
                          height: keyboardActive?size!.height/2:0,
                          child: Center(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Center(
                                child: Container( 
                                  width: size!.width,
                                  // color: primaryColor,
                                  child: Column(children: [


                                    Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                      ClipOval(
                                        child: TextButton(onPressed: (){
                                          eval += "1";
                                          setState(() {
                                            
                                          });
                                      
                                        }, child: Text("1",style: TextStyle(fontSize: 35,fontFamily: "Fredoka",color: primaryColor),)),
                                      ),
                                      ClipOval(
                                        child: TextButton(onPressed: (){
                                          eval += "2";
                                          setState(() {
                                            
                                          });
                                      
                                                                           }, child: Text("2",style: TextStyle(fontSize: 35,fontFamily: "Fredoka",color: primaryColor),)),
                                      ),
                                      ClipOval(
                                        child: TextButton(onPressed: (){
                                          eval += "3";
                                          setState(() {
                                            
                                          });
                                      
                                                                           }, child: Text("3",style: TextStyle(fontSize: 35,fontFamily: "Fredoka",color: primaryColor),)),
                                      ),
                                    ],),


                                    Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                      ClipOval(
                                        child: TextButton(onPressed: (){
                                          eval += "4";
                                          setState(() {
                                            
                                          });
                                      
                                                                           }, child: Text("4",style: TextStyle(fontSize: 35,fontFamily: "Fredoka",color: primaryColor),)),
                                      ),
                                      ClipOval(
                                        child: TextButton(onPressed: (){
                                          eval += "5";
                                          setState(() {
                                            
                                          });
                                      
                                                                           }, child: Text("5",style: TextStyle(fontSize: 35,fontFamily: "Fredoka",color: primaryColor),)),
                                      ),
                                      ClipOval(
                                        child: TextButton(onPressed: (){
                                          eval += "6";
                                          setState(() {
                                            
                                          });
                                      
                                                                           }, child: Text("6",style: TextStyle(fontSize: 35,fontFamily: "Fredoka",color: primaryColor),)),
                                      ),
                                    ],),


                                    Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                      ClipOval(
                                        child: TextButton(onPressed: (){
                                          eval += "7";
                                          setState(() {
                                            
                                          });
                                      
                                                                           }, child: Text("7",style: TextStyle(fontSize: 35,fontFamily: "Fredoka",color: primaryColor),)),
                                      ),
                                      ClipOval(
                                        child: TextButton(onPressed: (){
                                          eval += "8";
                                          setState(() {
                                            
                                          });
                                      
                                                                           }, child: Text("8",style: TextStyle(fontSize: 35,fontFamily: "Fredoka",color: primaryColor),)),
                                      ),
                                      ClipOval(
                                        child: TextButton(onPressed: (){
                                          eval += "9";
                                          setState(() {
                                            
                                          });
                                      
                                                                           }, child: Text("9",style: TextStyle(fontSize: 35,fontFamily: "Fredoka",color: primaryColor),)),
                                      ),
                                    ],),


                                    Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                      ClipOval(
                                        child: TextButton(onPressed: (){
                                          eval += "*";
                                          setState(() {
                                            
                                          });
                                      
                                                                           }, child: Text("*",style: TextStyle(fontSize: 35,fontFamily: "Fredoka",color: primaryColor),)),
                                      ),
                                      ClipOval(
                                        child: TextButton(onPressed: (){
                                          eval += "0";
                                          setState(() {
                                            
                                          });
                                      
                                                                           }, child: Text("0",style: TextStyle(fontSize: 35,fontFamily: "Fredoka",color: primaryColor),)),
                                      ),
                                      ClipOval(
                                        child: TextButton(onPressed: (){
                                          eval += "x";
                                          setState(() {
                                            
                                          });
                                      
                                                                           }, child: Text("x",style: TextStyle(fontSize: 35,fontFamily: "Fredoka",color: primaryColor),)),
                                      ),
                                    ],),

                                    Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                      ClipOval(
                                        child: TextButton(onPressed: (){
                                          eval += "-";
                                          setState(() {
                                            
                                          });
                                      
                                                                           }, child: Text("-",style: TextStyle(fontSize: 35,fontFamily: "Fredoka",color: primaryColor),)),
                                      ),
                                      ClipOval(
                                        child: TextButton(onPressed: (){
                                          eval += "^";
                                          setState(() {
                                            
                                          });
                                      
                                                                           }, child: Text("^",style: TextStyle(fontSize: 35,fontFamily: "Fredoka",color: primaryColor),)),
                                      ),
                                      ClipOval(
                                        child: TextButton(onPressed: (){
                                          
                                          eval += "+";
                                          setState(() {
                                            
                                          });
                                      
                                                                           
                                        }, child: Text("+",style: TextStyle(fontSize: 35,fontFamily: "Fredoka",color: primaryColor),)),
                                      ),
                                    ],),

                                    Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Expanded(child: Container(),flex: 2),
                                      Expanded(
                                        child: TextButton(onPressed: (){

                                          final pos = eval.length - 1;
                                          try {
                                            eval = eval.substring(0, pos);
                                             
                                          } catch (e) {
                                            // print(e); 
                                          }
                                          setState(() {
                                             
                                           });
                                        }, child: Icon(Icons.backspace_rounded, color: primaryColor,)),
                                      ),

                                    ],),
                                  ]),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
load(BuildContext context,{bool colorSuave = false }){
    return 
    showDialog(
      // barrierColor: 
      // useSafeArea: tue,
    barrierColor:colorSuave == false  ? Color.fromRGBO(64, 62, 65,0.9): Colors.transparent ,
     barrierDismissible: false,
     context: context,builder: (context){return AlertDialog(
     elevation: 0,
      backgroundColor: Colors.transparent,
      content: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(100)
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: Colors.white,)
            ],
          ),
        ),
      ),
    );});
 }

  

}