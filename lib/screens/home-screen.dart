import 'package:flutter/material.dart';
import 'package:onlinenew/logic/main-app-provider.dart';
import 'package:onlinenew/screens/second-screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MainAppProvider>(
        builder: (context , provider,_){
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: Text('Supabase',style: TextStyle(color: Colors.green),),
              actions: [
                IconButton(onPressed: (){
                  provider.getAllImages().then((v){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SecondScren()));
                  });

                }, icon: Icon(Icons.image,color: Colors.white,))
              ],
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                provider.imageFile!=null?Image.file(provider.imageFile!,height: 200,width: 200,): Text('No picked image',style: TextStyle(color: Colors.black),),
                SizedBox(height: 30,),
                ElevatedButton(onPressed: (){
                  provider.pickImage();
                },
                    child: Text('Pick Image')),

                SizedBox(height: 20,),
                ElevatedButton(onPressed: (){
                  provider.uploadImage(context);
                }, child: Text('Upload Image'))
              ],
            ),
          );
        }
    );
  }
}
// Note App title , subtitle , image  => Note List , Not Detail