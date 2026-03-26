import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qrc/generator.dart';
import 'package:qrc/saveqr.dart';
import 'package:qrc/widget/app_bar.dart';
import 'package:screenshot/screenshot.dart';

class GenerateQrCodeView extends StatefulWidget {
  const GenerateQrCodeView({super.key});

  @override
  State<GenerateQrCodeView> createState() => _GenerateQrCodeViewState();
}

class _GenerateQrCodeViewState extends State<GenerateQrCodeView> {
  ScreenshotController screenshotController = ScreenshotController();
  File? file;
  bool showImage = false;
  String? data;

  @override
  void initState() {
    super.initState();
  }

  Future<void> saveImage(Uint8List value) async {
    if (file != null) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: AppBarTitle(showHomeButton: true),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton.icon(
              onPressed: () async {
                final response = await Navigator.pushNamed(
                  context,
                  "/prepare-qrc",
                );
                if (response != null) {
                  setState(() {
                    showImage = true;
                    data = response as String;
                  });
                }
              },
              label: Text("Données"),
            ),
            if (showImage) ...[
              Screenshot(
                controller: screenshotController,
                child: Container(
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(color: Colors.blue),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: QrCode(data: data ?? ""),
                      ),

                      Text(
                        "@by cgtech",
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  screenshotController.capture().then((value) async {
                    if (value != null) {
                      final dir = await getTemporaryDirectory();
                      file = File("${dir.path}/captured.png");
                      await file!.writeAsBytes(value.toList());
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SaveqrView(file: file!),
                        ),
                      );
                    }
                  });
                },
                label: Text("Enreigistrer"),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
