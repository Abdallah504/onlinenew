import 'package:flutter/material.dart';
import 'package:onlinenew/logic/main-app-provider.dart';
import 'package:provider/provider.dart';

class SecondScren extends StatefulWidget {
  const SecondScren({super.key});

  @override
  State<SecondScren> createState() => _SecondScrenState();
}

class _SecondScrenState extends State<SecondScren> {


  @override
  Widget build(BuildContext context) {
    return Consumer<MainAppProvider>(
        builder: (context ,provider, _){
          return Scaffold(
            appBar: AppBar(),
            body:provider.media != []? SingleChildScrollView(
              child: ListView.builder(

                shrinkWrap: true,
                  itemCount:provider.media.length ,
                  itemBuilder: (context ,index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(provider.media[index].toString(),height: 200,width: 200,)
                    );
                  }),
            ):Center(
              child: Text('No Image Found',style: TextStyle(color: Colors.black),),
            ),
          );
        });
  }
}
