import 'package:flutter/material.dart';
class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {

  Future<String> getdata()async{
   return await Future.delayed(Duration(seconds: 5),(){
     return Future.value("5");
   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        FutureBuilder<String>(
        future: getdata(), // function where you call your api
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {  // AsyncSnapshot<Your object type>
          if( snapshot.connectionState == ConnectionState.waiting){
            return  Center(child: Text('Please wait its loading...'));
          }else{
            if (snapshot.hasError)
              return Center(child: Text('Error: ${snapshot.error}'));
            else
              return Center(child: new Text('${snapshot.data}',style: TextStyle(fontSize: 20),));  // snapshot.data  :- get your object which is pass from your downloadData() function
          }
        },
      )
          ],
        ),
      ),

    );
  }
}
