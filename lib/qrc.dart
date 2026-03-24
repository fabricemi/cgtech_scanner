import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qrc/widget/theme_button.dart';
import 'package:url_launcher/url_launcher.dart';

class QrcView extends StatefulWidget {
  const QrcView({super.key});

  @override
  State<QrcView> createState() => _QrcViewState();
}

class _QrcViewState extends State<QrcView> {
  final MobileScannerController _controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    detectionTimeoutMs: 500,
    formats: [BarcodeFormat.qrCode],
    returnImage: false,
    torchEnabled: false,
    invertImage: false,
    autoZoom: true,
  );

  String? resultat;
  String? link;
  bool showButton = false;
  bool showData = false;

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("An error occured")));
      }
    }
  }

  Future<void> prepareLink() async {
    setState(() {
      showButton = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "CG-TECH SCANNER",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [ThemeButton()],
      ),
      body: Column(
        children: [
          Card(
            child: SizedBox(
              height: 350,
              child: MobileScanner(
                onDetect: (result) async {
                  final barcode = result.barcodes.first;
                  final res = barcode.rawValue;
                  //debugPrint("Contenu url : $res");
                  if (res != null) {
                    Uri? uri;
                    try {
                      uri = Uri.parse(res);
                    } catch (_) {
                      uri = null;
                    }

                    //print(result.barcodes.first.rawValue);
                    if (uri != null &&
                        (uri.hasScheme &&
                            (uri.scheme == "http" || uri.scheme == "https"))) {
                      link = res;
                      setState(() {
                        showButton = true;
                        showData = false;
                      });
                    } else {
                      setState(() {
                        showData = true;
                        resultat = res;
                        showButton = false;
                      });
                    }
                  }
                },
              ),
            ),
          ),
          showButton
              ? Card(
                  child: SizedBox(
                    height: 50,

                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Click"),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            if (link != null) {
                              _launchUrl(link!);
                            }
                          },
                          label: Text(link ?? "No data"),
                          icon: Icon(Icons.open_in_browser),
                        ),
                      ],
                    ),
                  ),
                )
              : SizedBox(),
          showData
              ? Card(
                  child: SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (resultat != null) ...[
                          Text(resultat!, overflow: TextOverflow.clip),
                        ],
                      ],
                    ),
                  ),
                )
              : SizedBox(),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                showButton = false;
                link = null;
                resultat = null;
                showData = false;
              });
            },
            label: Text("Refresh"),
            icon: Icon(Icons.refresh),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, "/");
            },
            label: Text("Home"),
            icon: Icon(Icons.home),
          ),
        ],
      ),
    );
  }
}
