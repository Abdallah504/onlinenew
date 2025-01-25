import 'package:flutter/material.dart';
import 'package:onlinenew/logic/fire-provider.dart';
import 'package:onlinenew/screens/noteScreens/add-note.dart';
import 'package:provider/provider.dart';

class NoteList extends StatefulWidget {
  const NoteList({super.key});

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FireProvider>(
        builder: (context ,provider, _){
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.black,
              child: Icon(Icons.add,color: Colors.white,),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNote()));
              },
            ),
            appBar: AppBar(
              title: Text('Note App'),
            ),
            body:provider.Notes!=[]? SingleChildScrollView(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: provider.Notes.length,
                  itemBuilder: (context,index){
                    return ListTile(
                      title: Text(provider.Notes[index].title,style: TextStyle(color: Colors.black),),
                      subtitle: Text(provider.Notes[index].desc,style: TextStyle(color: Colors.black),),
                      trailing: IconButton(onPressed: (){
                        print(provider.Notes[index].id);
                         provider.firestore.collection('notes').doc(provider.Notes[index].id).delete().then((v){
                           provider.fetchingData();
                         });
                      },icon: Icon(Icons.delete,color: Colors.red,),),
                    );
                  }),
            ):Center(
              child: CircularProgressIndicator(color: Colors.orange,),
            ),
          );
        });
  }
}
