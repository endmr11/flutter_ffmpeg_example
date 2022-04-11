import 'dart:io';

import 'package:ffmpeg_kullanimi/views/home_ui/home_resources.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';

import 'home.dart';

abstract class HomeViewModel extends State<Home> with HomeResources {
  final FlutterFFmpeg _flutterFFmpeg = FlutterFFmpeg();
  VideoPlayerController? videoController;

  Directory? tempDirectory;
  String? assetPath;
  @override
  void initState() {
    super.initState();
    storagePermissionRequest();
  }

  Future<void> videoFilePick() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp4'],
    );

    if (result != null) {
      setState(() {
        videoFile = File(result.files.single.path!);
        videoUrlName = videoFile?.path;
        // ignore: avoid_print
        print(">>>>> ${videoFile?.path}");
      });
    } else {
      // User canceled the picker
    }
  }

  Future<void> audioFilePick() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['aac'],
    );
    if (result != null) {
      setState(() {
        audioFile = File(result.files.single.path!);
        audioUrlName = audioFile?.path;
        // ignore: avoid_print
        print(">>>>> ${audioFile?.path}");
      });
    } else {
      // User canceled the picker
    }
  }

  Future<void> mergeFiles() async {
    //String commandToExecute = '-r 15 -f aac -i $audioUrl -f mp4 -i $videoUrl -y $outputUrl';
    String commandToExecute = '-i $audioUrlName -i $videoUrlName -c copy $outputUrl';
    _flutterFFmpeg.execute(commandToExecute).then((value) {
      setState(() {
        outputUrlName = outputUrl;
        videoController = VideoPlayerController.file(File(outputUrlName!))
          ..initialize().then((val) {
            setState(() {});
          });
      });
      // ignore: avoid_print
      print("DURUM: $value");
    });
  }

/*   Future<void> mergeFiles() async {
    //String commandToExecute = '-r 15 -f aac -i $audioUrl -f mp4 -i $videoUrl -y $outputUrl';
    String commandToExecute = '-i $audioUrl -i $videoUrl -c copy $outputUrl';
    _flutterFFmpeg.execute(commandToExecute).then((value) {
      print("DURUM: $value");
    });
  } */

  Future<void> storagePermissionRequest() async {
    final status = await Permission.storage.request();
    if (status == PermissionStatus.granted) {
      // ignore: avoid_print
      print('Permission Granted');
    } else if (status == PermissionStatus.denied) {
      // ignore: avoid_print
      print('Permission denied');
    } else if (status == PermissionStatus.permanentlyDenied) {
      // ignore: avoid_print
      print('Permission Permanently Denied');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
