import 'dart:async';
import 'dart:math';
import 'dart:core';
import 'package:digi_doctor/Pages/voiceAssistantProvider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:flutter/material.dart';
import 'package:mic_stream/mic_stream.dart';
import 'Dashboard/OrganSymptom/organ_modal.dart';

enum Command {
  start,
  stop,
  change,
}

const AUDIO_FORMAT = AudioFormat.ENCODING_PCM_16BIT;

class MicStreamExampleApp extends StatefulWidget {
  const MicStreamExampleApp({super.key});

  @override
  MicStreamExampleAppState createState() => MicStreamExampleAppState();
}

class MicStreamExampleAppState extends State<MicStreamExampleApp>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  Stream? stream;
  late StreamSubscription variableStreamListener;

  late StreamSubscription listener;
  List<int>? currentSamples = [];
  List<int> visibleSamples = [];
  int? localMax;
  int? localMin;

  late AnimationController controller;

  final Color _iconColor = Colors.white;
  bool isRecording = false;
  bool memRecordingState = false;
  late bool isActive;
  DateTime? startTime;

  int page = 0;

  @override
  void initState() {
    VoiceAssistantProvider listenVM =
        Provider.of<VoiceAssistantProvider>(context, listen: false);
    Timer(const Duration(seconds: 1000), () async {
      listenVM.listeningPage = 'main dashboard';
      Navigator.pop(context);
      _stopListening();
    });
    listenVM.listeningPage = 'bhojpuri';
    print("Init application");
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        listenVM.updateLoading = false;
        initPlatformState();
        hideSuggesstion = false;
      });
    });

  }

  // Responsible for switching between recording / idle state
  void _controlMicStream({Command command: Command.change}) async {
    switch (command) {
      case Command.change:
        _changeListening();
        break;
      case Command.start:
        _startListening();
        break;
      case Command.stop:
        _stopListening();
        break;
    }
  }

  Future<bool> _changeListening() async =>
      !isRecording ? await _startListening() : _stopListening();

  late int bytesPerSample;
  late int samplesPerSecond;

  Future<bool> _startListening() async {
    if (isRecording) return false;
    MicStream.shouldRequestPermission(true);
    stream = await MicStream.microphone(
        audioSource: AudioSource.DEFAULT,
        sampleRate: 16000,
        channelConfig: ChannelConfig.CHANNEL_IN_MONO,
        audioFormat: AUDIO_FORMAT);
    await Future.delayed(const Duration(milliseconds: 200) ,(){
      variableStreamListener = stream!.listen((event) {
        print('its working');
        print(event.toString());
        channel.sink.add(event);
      });
    }
    );


    bytesPerSample = (await MicStream.bitDepth)! ~/ 8;
    samplesPerSecond = (await MicStream.sampleRate)!.toInt();
    localMax = null;
    localMin = null;
    setState(() {
      hideSuggesstion = true;
      isRecording = true;
      startTime = DateTime.now();
    });
    visibleSamples = [];
    listener = stream!.listen(_calculateSamples);

    /// SOCKET CODE SOCKET CODE SOCKET CODE SOCKET CODE SOCKET CODE SOCKET CODE SOCKET CODE SOCKET CODE
    /// SOCKET CODE SOCKET CODE SOCKET CODE SOCKET CODE SOCKET CODE SOCKET CODE SOCKET CODE SOCKET CODE
    /// SOCKET CODE SOCKET CODE SOCKET CODE SOCKET CODE SOCKET CODE SOCKET CODE SOCKET CODE SOCKET CODE

    // final wsUrl = Uri.parse('ws://172.16.19.162:8001/listen');
    // var channel = WebSocketChannel.connect(wsUrl);
    //
    // channel.stream.listen((message) async{
    //  print('1234567890');
    //
    //   channel.sink.add([72, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100]);
    //   channel.sink.close(status.goingAway);
    // });

    ///  SOCKET CODE SOCKET CODE SOCKET CODE SOCKET CODE SOCKET CODE SOCKET CODE SOCKET CODE SOCKET CODE
    ///  SOCKET CODE SOCKET CODE SOCKET CODE SOCKET CODE SOCKET CODE SOCKET CODE SOCKET CODE SOCKET CODE
    ///  SOCKET CODE SOCKET CODE SOCKET CODE SOCKET CODE SOCKET CODE SOCKET CODE SOCKET CODE SOCKET CODE
    return true;
  }

  void _calculateSamples(samples) {
    if (page == 0) {
      _calculateWaveSamples(samples);
    } else if (page == 1) {
      _calculateIntensitySamples(samples);
    }
  }

  void _calculateWaveSamples(samples) {
    bool first = true;
    visibleSamples = [];
    int tmp = 0;
    for (int sample in samples) {
      if (sample > 128) sample -= 255;
      if (first) {
        tmp = sample * 128;
      } else {
        tmp += sample;
        visibleSamples.add(tmp);
        localMax ??= visibleSamples.last;
        localMin ??= visibleSamples.last;
        localMax = max(localMax!, visibleSamples.last);
        localMin = min(localMin!, visibleSamples.last);
        tmp = 0;
      }
      first = !first;
    }
    print(visibleSamples.length);
  }

  void _calculateIntensitySamples(samples) {
    currentSamples ??= [];
    int currentSample = 0;
    eachWithIndex(samples, (i, int sample) {
      currentSample += sample;
      if ((i % bytesPerSample) == bytesPerSample - 1) {
        currentSamples!.add(currentSample);
        currentSample = 0;
      }
    });

    if (currentSamples!.length >= samplesPerSecond / 10) {
      visibleSamples
          .add(currentSamples!.map((i) => i).toList().reduce((a, b) => a + b));
      localMax ??= visibleSamples.last;
      localMin ??= visibleSamples.last;
      localMax = max(localMax!, visibleSamples.last);
      localMin = min(localMin!, visibleSamples.last);
      currentSamples = [];
      setState(() {});
    }
  }

  bool _stopListening() {
    channel.sink.add("hello from close");
    variableStreamListener.cancel();
    variableStreamListener.pause();
    if (!isRecording) return false;
    listener.cancel();
    setState(() {
      isRecording = false;
      currentSamples = null;
      startTime = null;
    });


    return true;
  }

  bool? hideSuggesstion = false;
  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    if (!mounted) return;
    isActive = true;

    Statistics(false);

    controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this)
          ..addListener(() {
            if (isRecording) setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              controller.reverse();
            } else if (status == AnimationStatus.dismissed) {
              controller.forward();
            }
          })
          ..forward();
  }

  Color _getBgColor() => (isRecording) ? Colors.red : Colors.cyan;
  Icon _getIcon() =>
      (isRecording) ? const Icon(Icons.stop) : const Icon(Icons.keyboard_voice);
  var channel =
      WebSocketChannel.connect(Uri.parse('ws://172.16.19.162:8001/listen'));

  OrganModal symptomscheckermodal = OrganModal();
  @override
  Widget build(BuildContext context) {
    VoiceAssistantProvider listenVM =
        Provider.of<VoiceAssistantProvider>(context, listen: true);

    return WillPopScope(
      onWillPop: () async {
        print('yessssss');

        listenVM.listeningPage = 'main dashboard';
        return true;
      },
      child: Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   onPressed: _controlMicStream,
        //   foregroundColor: _iconColor,
        //   backgroundColor: _getBgColor(),
        //   tooltip: (isRecording) ? "Stop recording" : "Start recording",
        //   child: _getIcon(),
        // ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StreamBuilder(
              stream: channel.stream,
              builder: (context, snapshot) {
                print(snapshot.data.toString());
                if (snapshot.data.toString() != 'null') {
                  symptomscheckermodal.symptomsNLP(
                      context, snapshot.data.toString(),true);
                }
                return Container(
                    height: 260,
                    decoration:   BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.purple.shade900,
                          Colors.indigo.shade900,
                          Colors.indigo.shade900,
                        ],
                      ),
                    ),
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Visibility(
                          visible: hideSuggesstion == false,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.white),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('सर् मे दर्ध है',
                                        style: TextStyle(
                                          color: Colors.white,
                                        )),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.white),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('पेटवा पीरात ह',
                                        style: TextStyle(
                                          color: Colors.white,
                                        )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Visibility(
                          visible: snapshot.hasData,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.indigo,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                      child: Text(
                                    ' ${snapshot.data.toString()}',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 25),
                                  )),
                                )),
                          ),
                        ),
                        Visibility(
                          visible: listenVM.getLoading == false,
                          replacement: const CircularProgressIndicator(),
                          child: InkWell(
                            onTap: _controlMicStream,
                            child: Container(
                              height: 73,
                              width: 73,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    (!isRecording)
                                        ? Colors.purple
                                        : Colors.red.shade400,
                                    (!isRecording)
                                        ? Colors.blueAccent
                                        : Colors.red.shade900,
                                  ],
                                ),
                              ),
                              child: Icon(
                                (!isRecording) ? Icons.mic : Icons.stop,
                                size: 35,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text((!isRecording) ? 'Tap to speak' : 'Stop',
                              style: const TextStyle(
                                color: Colors.white,
                              )),
                        ),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${snapshot.connectionState}',
                                style: const TextStyle(
                                    color: Colors.white10, fontSize: 10),
                              ),
                            )),
                      ],
                    )));
              },
            ),
            // CustomPaint(
            //   painter: WavePainter(
            //     samples: visibleSamples,
            //     color: _getBgColor(),
            //     localMax: localMax,
            //     localMin: localMin,
            //     context: context,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      isActive = true;
      print("Resume app");

      _controlMicStream(
          command: memRecordingState ? Command.start : Command.stop);
    } else if (isActive) {
      memRecordingState = isRecording;
      _controlMicStream(command: Command.stop);

      print("Pause app");
      isActive = false;
    }
  }

  @override
  void dispose() {
    listener.cancel();
    controller.dispose();
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }
}

class WavePainter extends CustomPainter {
  int? localMax;
  int? localMin;
  List<int>? samples;
  late List<Offset> points;
  Color? color;
  BuildContext? context;
  Size? size;

  // Set max val possible in stream, depending on the config
  // int absMax = 255*4; //(AUDIO_FORMAT == AudioFormat.ENCODING_PCM_8BIT) ? 127 : 32767;
  // int absMin; //(AUDIO_FORMAT == AudioFormat.ENCODING_PCM_8BIT) ? 127 : 32767;

  WavePainter(
      {this.samples, this.color, this.context, this.localMax, this.localMin});

  @override
  void paint(Canvas canvas, Size? size) {
    this.size = context!.size;
    size = this.size;

    Paint paint = new Paint()
      ..color = color!
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    if (samples!.length == 0) return;

    points = toPoints(samples);

    Path path = Path();
    path.addPolygon(points, false);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldPainting) => true;

  // Maps a list of ints and their indices to a list of points on a cartesian grid
  List<Offset> toPoints(List<int>? samples) {
    List<Offset> points = [];
    if (samples == null)
      samples = List<int>.filled(size!.width.toInt(), (0.5).toInt());
    double pixelsPerSample = size!.width / samples.length;
    for (int i = 0; i < samples.length; i++) {
      var point = Offset(
          i * pixelsPerSample,
          0.5 *
              size!.height *
              pow((samples[i] - localMin!) / (localMax! - localMin!), 5));
      points.add(point);
    }
    return points;
  }

  double project(int val, int max, double height) {
    double waveHeight =
        (max == 0) ? val.toDouble() : (val / max) * 0.5 * height;
    return waveHeight + 0.5 * height;
  }
}

class Statistics extends StatelessWidget {
  final bool isRecording;
  final DateTime? startTime;

  // final String url = "https://github.com/anarchuser/mic_stream";

  Statistics(this.isRecording, {this.startTime});

  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      const ListTile(
          leading: Icon(Icons.title),
          title: Text("Microphone Streaming Example App")),
      ListTile(
        leading: const Icon(Icons.keyboard_voice),
        title: Text((isRecording ? "Recording" : "Not recording")),
      ),
      ListTile(
          leading: const Icon(Icons.access_time),
          title: Text((isRecording
              ? DateTime.now().difference(startTime!).toString()
              : "Not recording"))),
    ]);
  }
}

Iterable<T> eachWithIndex<E, T>(
    Iterable<T> items, E Function(int index, T item) f) {
  var index = 0;

  for (final item in items) {
    f(index, item);
    index = index + 1;
  }

  return items;
}

bhojpuriSheet(context) {
  showModalBottomSheet(
    context: context,
    // color is applied to main screen when modal bottom screen is displayed
    barrierColor: Colors.black54,
    //background color for modal bottom screen
    backgroundColor: Colors.transparent,
    //elevates modal bottom screen
    elevation: 10,
    // gives rounded corner to modal bottom screen
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50.0),
    ),
    builder: (BuildContext context) {
      // UDE : SizedBox instead of Container for whitespaces
      return const Padding(
        padding: EdgeInsets.all(8.0),
        child: SizedBox(height: 260, child: MicStreamExampleApp()),
      );
    },
  );
}
