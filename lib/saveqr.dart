import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qrc/widget/theme_button.dart';
import 'package:share_plus/share_plus.dart';

class SaveqrView extends StatefulWidget {
  File file;
  SaveqrView({super.key, required this.file});

  @override
  State<SaveqrView> createState() => _SaveqrViewState();
}

class _SaveqrViewState extends State<SaveqrView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("CG-TECH SCANNER"),
        actions: [ThemeButton()],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.file(widget.file),
            SizedBox(height: 10),
            Text("Partagez cette image afin de la conserver"),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () async {
                final box = context.findRenderObject() as RenderBox?;

                await SharePlus.instance.share(
                  ShareParams(
                    files: [XFile(widget.file.path)],
                    text: "Share File",
                    sharePositionOrigin:
                        box!.localToGlobal(Offset.zero) & box.size,
                  ),
                );
              },
              label: Text("Partager"),
              icon: Icon(Icons.share),
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () async {
                Navigator.pop(context);
              },
              label: Text("Retour"),
              icon: Icon(Icons.home),
            ),
          ],
        ),
      ),
    );
  }
}
