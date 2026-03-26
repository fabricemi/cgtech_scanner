import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCode extends StatelessWidget {
  String data;
  QrCode({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.white,
        child: QrImageView(
          data: data,
          version: QrVersions.auto,
          size: 200.0,
          embeddedImage: AssetImage("assets/images/logo.png"),
          embeddedImageStyle: QrEmbeddedImageStyle(size: Size(25, 25)),
        ),
      ),
    );
  }
}
