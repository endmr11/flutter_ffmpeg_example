import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'home_view_model.dart';

class HomeView extends HomeViewModel {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Video: >>> $videoUrlName"),
            Text("Ses: >>> $audioUrlName"),
            Text("Çıktı: >>> $outputUrlName"),
            ElevatedButton(
              onPressed: () => videoFilePick(),
              child: const Text("Video Seç"),
            ),
            ElevatedButton(
              onPressed: () => audioFilePick(),
              child: const Text("Ses Seç"),
            ),
            ElevatedButton(
              onPressed: () => mergeFiles(),
              child: const Text("Birleştir"),
            ),
            outputUrlName != null
                ? Container(
                    width: 350,
                    height: 350,
                    color: Colors.black,
                    child: VideoPlayer(videoController!),
                  )
                : const Placeholder(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (videoController != null) {
              videoController!.value.isPlaying ? videoController?.pause() : videoController?.play();
            }
          });
        },
        child: Icon(
          videoController != null
              ? videoController!.value.isPlaying
                  ? Icons.pause
                  : Icons.play_arrow
              : Icons.ac_unit,
        ),
      ),
    );
  }
}
