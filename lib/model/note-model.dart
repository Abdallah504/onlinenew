import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel{
  final String id;
  final String title;
  final String desc;

  NoteModel({required this.id,required this.title , required this.desc});

  factory NoteModel.fromFirestore(DocumentSnapshot doc){
    Map<String,dynamic> data = doc.data() as Map<String,dynamic>;
    return NoteModel(
        id: doc.id,
        title: data['title'],
        desc: data['desc']);
  }
}