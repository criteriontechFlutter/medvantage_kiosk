import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayer extends StatefulWidget {
  // ignore: use_key_in_widget_constructor

  final String url;

  const VideoPlayer({Key? key, required this.url}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _VideoPlayerState();
  }
}

class _VideoPlayerState extends State<VideoPlayer> {
  VideoPlayerController? _videoPlayerController1;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController1!.dispose();
    _chewieController!.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController1 = VideoPlayerController.network(widget.url);
    await Future.wait([
      _videoPlayerController1!.initialize(),
    ]);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1!,
      autoPlay: true,
      looping: false,
      // aspectRatio: 16 / 9,
      fullScreenByDefault: false,

      // Try playing around with some of these other options:


      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //
      //   bufferedColor: Colors.lightGreen,
      // ),
      placeholder: Container(
        color: Colors.black,
      ),
      autoInitialize: true,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                children: [
                  Center(
                    child: _chewieController != null &&
                        _chewieController!
                            .videoPlayerController.value.isInitialized
                        ? Chewie(
                      controller: _chewieController!,
                    )
                        : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(),
                        SizedBox(height: 20),
                        Text('Loading'),
                      ],
                    ),
                  ),
                  SafeArea(
                    child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
