import 'package:easy_localization/easy_localization.dart';
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
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.black,
              onPressed: (){
                // if(context.locale.languageCode=='en'){
                //   context.setLocale(Locale('ar'));
                // }else{
                //   context.setLocale(Locale('en'));
                // }
                showDialog(context: context, builder: (context){
                  return Dialog(
                    child: Container(
                      height: 200,
                      width: 200,

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ListTile(
                              onTap: (){
                                context.setLocale(Locale('en')).then((v){
                                  Navigator.pop(context);
                                });
                              },
                              leading: Text('EN',style: TextStyle(color: Colors.green),),
                              title: Text('English'),
                            ),
                            ListTile(
                              onTap: (){
                                context.setLocale(Locale('ar')).then((v){
                                  Navigator.pop(context);
                                });
                              },
                              leading: Text('AR',style: TextStyle(color: Colors.green),),
                              title: Text('Arabic'),
                            ),
                            ListTile(
                              onTap: (){
                                context.setLocale(Locale('fr')).then((v){
                                  Navigator.pop(context);
                                });
                              },
                              leading: Text('FR',style: TextStyle(color: Colors.green),),
                              title: Text('France'),
                            )
                          ],
                        ),
                      ),
                    ),

                  );
                });
              },
              child: Icon(Icons.language,color: Colors.green,),
            ),
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