import 'package:flutter/material.dart';
import 'package:onlinenew/logic/fire-provider.dart';
import 'package:provider/provider.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<FireProvider>(
        builder: (context,provider,_){
          return Scaffold(
            body: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        hintText: 'Title',
                        labelText: 'Title'
                      ),
                    ),
                    SizedBox(height: 20,),
                    TextField(
                      controller: _descController,
                      decoration: InputDecoration(
                          hintText: 'Desc',
                          labelText: 'Desc'
                      ),
                    ),
                    SizedBox(height: 10,),
                    ElevatedButton(onPressed: (){
                      provider.addNote(title: _titleController.text, desc: _descController.text,context: context).then((v){
                        Navigator.pop(context);
                      });
                    },
                        child: Text('Submit'))
                  ],
                ),
              ),
            ),
          );
        });
  }
}
