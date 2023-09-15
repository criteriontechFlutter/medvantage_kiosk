


import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'alert_dialogue.dart';

class FlutterDownloadFiles{
  ReceivePort _port = ReceivePort();

  Future<String?> getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
        // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
        // ignore: avoid_slow_async_io
        if (!await directory.exists()) directory = await getExternalStorageDirectory();
      }
    } catch (err, stack) {
      print("Cannot get download folder path");
    }
    return directory?.path;
  }

  download(context,String url) async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      final downloadsDirectory = await getDownloadPath();
      alertToast(context, 'Downloading...');
      await FlutterDownloader.enqueue(
          url: url,
          savedDir: downloadsDirectory.toString(),
          showNotification: true, // show download progress in status bar (for Android)
          openFileFromNotification: true, // click on notification to open downloaded file (for Android)
          saveInPublicStorage: true
      );
    }
  }


  // call this function in initState
  callInInitState(setState){

    IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];

      if(status == DownloadTaskStatus.complete){
        print('complete................');
      }
      setState((){ });
    });

   // FlutterDownloader.registerCallback(downloadCallback);
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, DownloadTaskStatus status, int progress) {
    final SendPort? send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }


//*********** dispose this  ********
// IsolateNameServer.removePortNameMapping('downloader_send_port');

}