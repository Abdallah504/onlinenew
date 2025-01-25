
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:onlinenew/model/note-model.dart';

class FireProvider extends ChangeNotifier{
final FirebaseFirestore firestore = FirebaseFirestore.instance;

List<NoteModel> Notes = [];

Future<void>addNote({required String title,required String desc,context})async{
  if( title.isNotEmpty && desc.isNotEmpty){
    Map<String,dynamic> data ={
      'title':title,
      'desc':desc
    };
    await firestore.collection('notes').doc(DateTime.now().toString()).set(data).then((v){
      fetchingData();
      notifyListeners();
    });
    //     .add(data).then((v){
    //   fetchingData();
    //   notifyListeners();
    // });
    notifyListeners();
  }else{
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('PLease fill the needed data')));
  }
  notifyListeners();
}

Future<List<NoteModel>>fetchingData()async{
  Notes = [];
  try{
    QuerySnapshot snapshot = await firestore.collection('notes').get();
    notifyListeners();
    List<NoteModel> items = snapshot.docs.map((doc){
      return NoteModel.fromFirestore(doc);
    }).toList();
    Notes = items;
    notifyListeners();
    return Notes;

  }catch(e){
    print(e);
    notifyListeners();
    return [];
  }

}




}