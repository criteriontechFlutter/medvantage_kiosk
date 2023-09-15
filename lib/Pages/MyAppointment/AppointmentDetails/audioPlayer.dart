import 'dart:async';

import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart' as ap;

import '../../../AppManager/app_color.dart';
import '../../../AppManager/my_text_theme.dart';


class AudioPlayers extends StatefulWidget {
  /// Path from where to play recorded audio
  final ap.AudioSource source;

  /// Callback when audio file should be removed
  /// Setting this to null hides the delete button
  final VoidCallback onDelete;

  const AudioPlayers({
    required this.source,
    required this.onDelete,
  });

  @override
  AudioPlayersState createState() => AudioPlayersState();
}

class AudioPlayersState extends State<AudioPlayers> {
  static const double _controlSize = 56;
  static const double _deleteBtnSize = 24;

  final _audioPlayer = ap.AudioPlayer();
  late StreamSubscription<ap.PlayerState> _playerStateChangedSubscription;
  late StreamSubscription<Duration?> _durationChangedSubscription;
  late StreamSubscription<Duration> _positionChangedSubscription;

  @override
  void initState() {
    _playerStateChangedSubscription =
        _audioPlayer.playerStateStream.listen((state) async {
          if (state.processingState == ap.ProcessingState.completed) {
            await stop();
          }
          setState(() {});
        });
    _positionChangedSubscription =
        _audioPlayer.positionStream.listen((position) => setState(() {}));
    _durationChangedSubscription =
        _audioPlayer.durationStream.listen((duration) => setState(() {}));
    _init();

    super.initState();
  }

  Future<void> _init() async {
    await _audioPlayer.setAudioSource(widget.source);
  }

  @override
  void dispose() {
    _playerStateChangedSubscription.cancel();
    _positionChangedSubscription.cancel();
    _durationChangedSubscription.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Material(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildControl(),
              _buildSlider(constraints.maxWidth),
              Material(
                child: IconButton(
                  icon: const Icon(Icons.delete,
                      color: Colors.red),
                  onPressed: () {
                    _audioPlayer.stop().then((value) => widget.onDelete());
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildControl() {
    Icon icon;
    Color color;

    if (_audioPlayer.playerState.playing) {
      icon = Icon(Icons.pause, color: AppColor.orangeButtonColor, size: 30);
      color = AppColor.orangeButtonColor.withOpacity(0.1);
    } else {
      final theme = Theme.of(context);
      icon = Icon(Icons.play_arrow, color: AppColor.orangeButtonColor, size: 30);
      color = AppColor.orangeButtonColor.withOpacity(0.1);
    }

    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          child:
          SizedBox(width: _controlSize, height: _controlSize, child: icon),
          onTap: () {
            if (_audioPlayer.playerState.playing) {
              pause();
            } else {
              play();
            }
          },
        ),
      ),
    );
  }

  Widget _buildSlider(double widgetWidth) {
    final position = _audioPlayer.position;
    final duration = _audioPlayer.duration;
    bool canSetValue = false;
    if (duration != null) {
      canSetValue = position.inMilliseconds > 0;
      canSetValue &= position.inMilliseconds < duration.inMilliseconds;
    }

    double width = widgetWidth - _controlSize - _deleteBtnSize;
    width -= _deleteBtnSize;

    return Material(
      child: Column(
        children: [
          SizedBox(
            width: width,
            child: Slider(
              activeColor: AppColor.orangeButtonColor,
              inactiveColor: AppColor.greyLight,
              onChanged: (v) {
                if (duration != null) {
                  final position = v * duration.inMilliseconds;
                  _audioPlayer.seek(Duration(milliseconds: position.round()));
                }
              },

              value: canSetValue && duration != null
                  ? position.inMilliseconds / duration.inMilliseconds
                  : 0.0,
            ),
          ),
          SizedBox(
            width: width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_audioPlayer.duration==null? '': _audioPlayer.duration.toString().split('.')[0],
                  style: MyTextTheme().smallBCB,),
                const Expanded(child: SizedBox()),
                Text(_audioPlayer.position.toString().split('.')[0],
                  style: MyTextTheme().smallBCB.copyWith(

                  ),),
              ],
            ),
          ),

        ],
      ),
    );
  }

  Future<void> play() async{
    await AndroidAudioManager().stopBluetoothSco();
    await AndroidAudioManager().setBluetoothScoOn(false);

    await AndroidAudioManager().setMode(AndroidAudioHardwareMode.inCommunication);

    await AndroidAudioManager().setSpeakerphoneOn(true);

    print('Speajerssssssssssssssssssssssssssssssss'+(await AndroidAudioManager().isSpeakerphoneOn()).toString());
    // AndroidAudioManager().setMode(AndroidAudioHardwareMode.normal);
    return _audioPlayer.play();
  }

  Future<void> pause() {
    return _audioPlayer.pause();
  }
  Future<void> stop() async {
    await _audioPlayer.stop();
    return _audioPlayer.seek(const Duration(milliseconds: 0));
  }
}