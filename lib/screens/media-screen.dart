import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_audio/just_audio.dart';
import 'package:video_player/video_player.dart';

class MediaScreen extends StatefulWidget {
  const MediaScreen({super.key});

  @override
  State<MediaScreen> createState() => _MediaScreenState();
}

class _MediaScreenState extends State<MediaScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _pickedFile;
  VideoPlayerController? _videoPlayerController;
  late AudioPlayer _audioPlayer;
  bool isAudioPlaying = false;
  String? _pickFilepath;


  Future<void>pickImage()async{
    final XFile? image= await _picker.pickImage(source: ImageSource.gallery);
    if(image !=null){
      _pickedFile = image;
      _disposeMedia();
    }

  }

  Future<void>pickVideo()async{
    final XFile? video= await _picker.pickVideo(source: ImageSource.gallery);
    if(video !=null){
      _videoPlayerController = VideoPlayerController.file(File(video.path))
          ..initialize().then((v){
            _pickedFile = video;
          });
      _videoPlayerController!.play();
    }

  }

  Future<void>pickAudio()async{
    final result = await FilePicker.platform.pickFiles(
      type: FileType.audio
    );

    if(result !=null){
      final filePath = result.files.single.path;
      setState(() {
        _pickFilepath = filePath;
        print('file :$_pickFilepath');
      });
      await _audioPlayer.setAudioSource(AudioSource.file(filePath!)).then((v){
        _audioPlayer.play();
        print('Audio is playing');
      });

      setState(() {
        isAudioPlaying = true;
      });
    }
  }

  void _disposeMedia(){
    _videoPlayerController?.dispose();
    _videoPlayerController = null;
    if(_audioPlayer !=null){
      _audioPlayer.dispose();
      isAudioPlaying = false;
    }
  }

  @override
  void initState() {
    _audioPlayer = AudioPlayer();
    super.initState();
  }
  @override
  void dispose() {
    _disposeMedia();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(_pickedFile !=null)
              _videoPlayerController !=null?
                  SizedBox(
                    height: 200,
                    width: 100,
                    child: VideoPlayer(_videoPlayerController!)

                    ,
                  ):Image.file(File(_pickedFile!.path)),

            SizedBox(height: 20,),

            ElevatedButton(onPressed: pickImage, child: Text('Pick Image')),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: pickVideo, child: Text('Pick Video')),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: pickAudio, child: Text('Pick Audio'))
          ],
        ),
      ),
    );
  }
}
