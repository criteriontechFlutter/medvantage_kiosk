import 'dart:async';

import 'package:audio_session/audio_session.dart';
import '../../../Localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart' as ap;
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';

import '../../../AppManager/app_color.dart';
import '../../../AppManager/my_text_theme.dart';
import '../../../AppManager/widgets/my_button.dart';
import 'appointment_details_modal.dart';
import 'audioPlayer.dart';

// enum _DeviceAvailability {
//   no,
//   maybe,
//   yes,
// }

class _DeviceWithAvailability {
  // BluetoothDevice device;
  // _DeviceAvailability availability;
  int? rssi;
}

class AudioRecorder extends StatefulWidget {
  final void Function(String path) onStop;

  const AudioRecorder({required this.onStop});

  @override
  _AudioRecorderState createState() => _AudioRecorderState();
}

class _AudioRecorderState extends State<AudioRecorder> {
  bool _isRecording = false;
  bool _isPaused = false;
  int _recordDuration = 0;
  Timer? _timer;
  Timer? _ampTimer;
  final _audioRecorder = Record();
  Amplitude? _amplitude;

  @override
  void initState() {
    _isRecording = false;
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _ampTimer?.cancel();
    _audioRecorder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: true);

    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildRecordStopControl(),
              _buildPauseResumeControl(),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          _buildText(),
          if (_amplitude != null) ...[
            // const SizedBox(height: 40),
            // Text('Current: ${_amplitude?.current ?? 0.0}'),
            // Text('Max: ${_amplitude?.max ?? 0.0}'),
          ],
        ],
      ),
    );
  }

  Widget _buildRecordStopControl() {
    late Icon icon;
    late Color color;

    if (_isRecording || _isPaused) {
      icon = Icon(Icons.stop, color: AppColor.orangeButtonColor, size: 30);
      color = AppColor.orangeButtonColor.withOpacity(0.1);
    } else {
      final theme = Theme.of(context);
      icon = Icon(Icons.mic, color: AppColor.orangeButtonColor, size: 30);
      color = AppColor.orangeButtonColor.withOpacity(0.1);
    }

    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          child: SizedBox(width: 56, height: 56, child: icon),
          onTap: () {
            _isRecording ? _stop() : _start();
          },
        ),
      ),
    );
  }

  Widget _buildPauseResumeControl() {
    if (!_isRecording && !_isPaused) {
      return const SizedBox.shrink();
    }

    late Icon icon;
    late Color color;

    if (!_isPaused) {
      icon = Icon(Icons.pause, color: AppColor.orangeButtonColor, size: 30);
      color = AppColor.orangeButtonColor.withOpacity(0.1);
    } else {
      final theme = Theme.of(context);
      icon =
          Icon(Icons.play_arrow, color: AppColor.orangeButtonColor, size: 30);
      color = AppColor.orangeButtonColor.withOpacity(0.1);
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
      child: ClipOval(
        child: Material(
          color: color,
          child: InkWell(
            child: SizedBox(width: 56, height: 56, child: icon),
            onTap: () {
              _isPaused ? _resume() : _pause();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildText() {
    // ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: true);

    if (_isRecording || _isPaused) {
      return _buildTimer();
    }

    return Text('start Recording'.toString(),
      style: MyTextTheme().mediumGCB,
    );
  }

  Widget _buildTimer() {
    final String minutes = _formatNumber(_recordDuration ~/ 60);
    final String seconds = _formatNumber(_recordDuration % 60);

    return Text(
      '$minutes : $seconds',
      style: MyTextTheme().smallBCB.copyWith(color: Colors.red),
    );
  }

  String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0' + numberStr;
    }

    return numberStr;
  }

  Future<void> _start() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        await AndroidAudioManager().setMode(AndroidAudioHardwareMode.normal);
        // await AndroidAudioManager().setBluetoothScoOn(true);
        // await AndroidAudioManager().startBluetoothSco();
        await _audioRecorder.start(
          //   encoder: AudioEncoder.AMR_NB
        );

        bool isRecording = await _audioRecorder.isRecording();
        setState(() {
          _isRecording = isRecording;
          _recordDuration = 0;
        });

        _startTimer();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _stop() async {
    _timer?.cancel();
    _ampTimer?.cancel();
    final path = await _audioRecorder.stop();

    widget.onStop(path!);

    setState(() => _isRecording = false);
  }

  Future<void> _pause() async {
    _timer?.cancel();
    _ampTimer?.cancel();
    await _audioRecorder.pause();

    setState(() => _isPaused = true);
  }

  Future<void> _resume() async {
    _startTimer();
    await _audioRecorder.resume();

    setState(() => _isPaused = false);
  }

  void _startTimer() {
    _timer?.cancel();
    _ampTimer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() => _recordDuration++);
    });

    _ampTimer =
        Timer.periodic(const Duration(milliseconds: 200), (Timer t) async {
          _amplitude = await _audioRecorder.getAmplitude();
          setState(() {});
        });
  }
}

class MyRecorder extends StatefulWidget {
  // final bool checkAvailability;
  const MyRecorder({
    Key? key,

    // this.checkAvailability = true
  }) : super(key: key);

  @override
  _MyRecorderState createState() => _MyRecorderState();
}

class _MyRecorderState extends State<MyRecorder> with WidgetsBindingObserver {
  AppointmentDetailsModal modal = AppointmentDetailsModal();
  String filePath = '';

  bool showPlayer = false;
  ap.AudioSource? audioSource;

  //
  // List<_DeviceWithAvailability> devices =
  // List<_DeviceWithAvailability>.empty(growable: true);
  //
  // List<_DeviceWithAvailability> myDevice =
  // List<_DeviceWithAvailability>.empty(growable: true);

  // Availability
  // StreamSubscription<BluetoothDiscoveryResult>? _discoveryStreamSubscription;
  bool _isDiscovering = false;

  final String _findDevice = 'Bluetooth';

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // Avoid memory leak (`setState` after dispose) and cancel discovery
    // _discoveryStreamSubscription?.cancel();
    AndroidAudioManager().setBluetoothScoOn(false);
    AndroidAudioManager().stopBluetoothSco();
    AndroidAudioManager().setMode(AndroidAudioHardwareMode.normal);

    super.dispose();
  }

  @override
  void initState() {
    showPlayer = false;
    get();
    super.initState();
  }

  get() async {
    // WidgetsBinding.instance.addObserver(this);
    // await AndroidAudioManager().setBluetoothScoOn(true);
    // await AndroidAudioManager().startBluetoothSco();
    // _isDiscovering = widget.checkAvailability;

    // Setup a list of the bonded devices
    // FlutterBluetoothSerial.instance
    //     .getBondedDevices()
    //     .then((List<BluetoothDevice> bondedDevices) {
    //   setState(() {
    //     devices = bondedDevices
    //         .map(
    //           (device) => _DeviceWithAvailability(
    //         device,
    //         widget.checkAvailability
    //             ? _DeviceAvailability.maybe
    //             : _DeviceAvailability.yes,
    //       ),
    //     )
    //         .toList();
    //   });
    // });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        _restartDiscovery();
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  void _restartDiscovery() {
    setState(() {
      _isDiscovering = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print((devices.map((e) => e.device.name).toList()));
    // print((devices.map((e) => e.device.isConnected).toList()));

    return Container(
      color: AppColor.orangeButtonColor,
      child: SafeArea(
        child: Scaffold(
          body: _recorder(),
        ),
      ),
    );
  }

  Widget _recorder() {

    return showPlayer
        ? Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: AudioPlayers(
            source: audioSource!,
            onDelete: () {
              setState(() => showPlayer = false);
            },
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        MyButton(
          width: 200,
          color: AppColor.orangeButtonColor,
          title: 'saveRecording'.toString(),
          onPress: () async {
            await modal.controller
                .addDocumentInList(filePath, 'assets/audio.svg');
            Navigator.pop(context);
          },
        ),
      ],
    )
        : Center(
      child: AudioRecorder(
        onStop: (path) {
          filePath = path;
          setState(() {
            audioSource = ap.AudioSource.uri(Uri.parse(path));
            showPlayer = true;
          });
        },
      ),
    );
  }

  Widget _searchAgainWidget() {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: true);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Lottie.asset('assets/search.json'),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              children: [
                Text(
                  localization.getLocaleData.deviceNotPaired.toString(),
                  textAlign: TextAlign.center,
                  style: MyTextTheme().mediumBCB,
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    localization.getLocaleData.or.toString(),
                    textAlign: TextAlign.center,
                    style: MyTextTheme().mediumGCB,
                  ),
                ),
                Text(
                  localization.getLocaleData.connectedToSomeOtherDevice.toString(),
                  textAlign: TextAlign.center,
                  style: MyTextTheme().mediumBCB,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              const Expanded(child: SizedBox()),
              Expanded(
                flex: 3,
                child: MyButton(
                  color: AppColor.orangeButtonColor,
                  title: localization.getLocaleData.searchAgain.toString(),
                  onPress: () {
                    _restartDiscovery();
                  },
                ),
              ),
              const Expanded(child: SizedBox()),
              Expanded(
                flex: 3,
                child: MyButton(
                  color: AppColor.orangeButtonColor,
                  title: localization.getLocaleData.pairDevice.toString(),
                  onPress: () async {
                    // AppSettings.openBluetoothSettings();
                  },
                ),
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
        ],
      ),
    );
  }
}
