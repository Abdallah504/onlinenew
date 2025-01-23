import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MainAppProvider extends ChangeNotifier{

File? imageFile;
final ImagePicker picker = ImagePicker();

List<String> media = [];

Future<void>pickImage()async{
  final XFile? image= await picker.pickImage(source: ImageSource.gallery);
  if(image !=null){
    imageFile = File(image.path);
    notifyListeners();
  }
  notifyListeners();
}

Future<void>uploadImage(context)async{

  try{
    if(imageFile!=null){
      print(imageFile!.path);
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final path = 'uploads/$fileName';
      await Supabase.instance.client.storage.from('images').upload(path, imageFile!)
          .then((v){
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Image Uploaded')));
        //imageFile = null;
        notifyListeners();
      });
    }
  }catch(e){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('No image to upload')));
    notifyListeners();
  }
  notifyListeners();
}


Future<List<String>>getAllImages()async{
  print('Media before $media');
  try{
    final response = await Supabase.instance.client.storage.from('images').list(path: 'uploads');

    if(response !=null){

      media = response.map((file){
        return Supabase.instance.client.storage.from('images')
            .getPublicUrl('uploads/${file.name}');
      }

  ).toList();
      print('Media After $media');
      return media;
    }
  }catch(e){
    print(e);
    return [];
  }
  return[];
}


}