import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:pido/src/models/sub_models/time_left.dart';
import 'package:pido/src/utils/app_shared.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:timeago/timeago.dart' as timeago;

String formatDate(BuildContext context,String date) {
  late String result;
  try {
    result = timeago.format(DateTime.now().subtract(DateTime.now()
        .difference(DateFormat("yyyy-MM-dd HH:mm:ss", 'en').parse(date))),
        
        locale: context.locale.languageCode
        );
  } on FormatException catch (e) {
    print(date);
    print(e.message);
  }
  return result;
}

Future<BitmapDescriptor> getMarkerBitmap(int size, {String? text}) async {
  if (kIsWeb) size = (size / 2).floor();

  final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
  final Canvas canvas = Canvas(pictureRecorder);
  final Paint paint1 = Paint()..color = Colors.orange;
  final Paint paint2 = Paint()..color = Colors.white;

  canvas.drawCircle(Offset(size / 2, size / 2), size / 2.0, paint1);
  canvas.drawCircle(Offset(size / 2, size / 2), size / 2.2, paint2);
  canvas.drawCircle(Offset(size / 2, size / 2), size / 2.8, paint1);

  if (text != null) {
    TextPainter painter = TextPainter(textDirection: ui.TextDirection.ltr);
    painter.text = TextSpan(
      text: text,
      style: TextStyle(
          fontSize: size / 3,
          color: Colors.white,
          fontWeight: FontWeight.normal),
    );
    painter.layout();
    painter.paint(
      canvas,
      Offset(size / 2 - painter.width / 2, size / 2 - painter.height / 2),
    );
  }

  final img = await pictureRecorder.endRecording().toImage(size, size);
  final data = await img.toByteData(format: ui.ImageByteFormat.png) as ByteData;

  return BitmapDescriptor.fromBytes(data.buffer.asUint8List());
}



Future<BitmapDescriptor> convertImageFileToBitmapDescriptor(
    File imageFile, int size,
    {String? text,
    bool addBorder = false,
    Color borderColor = Colors.red,
    double borderSize = 10,
    Color titleColor = Colors.red,
    Color titleBackgroundColor = Colors.red}) async {
  final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
  final Canvas canvas = Canvas(
    pictureRecorder,
  );
  final Paint paint = Paint()..color = titleBackgroundColor;
  final TextPainter textPainter = TextPainter(
    textDirection: ui.TextDirection.ltr,
  );
  final double radius = size / 2;

  //make canvas clip path to prevent image drawing over the circle
  final Path clipPath = Path();
  clipPath.addRRect(RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.toDouble(), size.toDouble()),
      Radius.circular(100)));
  clipPath.addRRect(RRect.fromRectAndRadius(
      Rect.fromLTWH(size / 2.toDouble(), size + 20.toDouble(), 10, 10),
      Radius.circular(100)));
  canvas.clipPath(clipPath);

  //paintImage
  final Uint8List imageUint8List = await imageFile.readAsBytes();
  final ui.Codec codec = await ui.instantiateImageCodec(imageUint8List);
  final ui.FrameInfo imageFI = await codec.getNextFrame();
  paintImage(
      canvas: canvas,
      rect: Rect.fromLTWH(0, 0, size.toDouble(), size.toDouble()),
      image: imageFI.image);

  //convert canvas as PNG bytes
  final _image =
      await pictureRecorder.endRecording().toImage(size, (size * 1.1).toInt());
  final data = await _image.toByteData(format: ui.ImageByteFormat.png);

  //convert PNG bytes as BitmapDescriptor
  return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
}
void setServerDate(String serverDate){
  Duration duration= DateTime.now().difference(DateFormat("yyyy-MM-dd HH:mm:ss", 'en').parse(serverDate));

  AppShared.serverTime=duration;
}
TimeLeft  getRemainingTime(DateTime endDate){

  Duration remaining= endDate.difference( DateTime.now().add(AppShared.serverTime));
  print('remaining ${remaining.inSeconds}');
  TimeLeft result=TimeLeft(
    duration: remaining
  );
  return result;


}
Map<String, dynamic> decodeResponse(String str){

  return json.decode(str) as Map<String, dynamic>;
}

