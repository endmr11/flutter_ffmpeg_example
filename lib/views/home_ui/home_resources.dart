import 'dart:io';

mixin HomeResources {
  final String title = 'Home';
  final String outputUrl = '/storage/emulated/0/Documents/output.mp4';

  String? videoUrlName;
  String? audioUrlName;
  String? outputUrlName;

  File? videoFile;
  File? audioFile;
}
