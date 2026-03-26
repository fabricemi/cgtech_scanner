import 'package:flutter/material.dart';
import 'package:qrc/widget/app_bar.dart';
import 'package:qrc/widget/theme_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: AppBarTitle(showHomeButton: false),
      ),

      body: Container(
        width: double.infinity,
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/logo.png", fit: BoxFit.contain),
            SizedBox(height: 20),
            FilledButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, "/scan");
              },
              label: Text("Scanner"),
              icon: Icon(Icons.qr_code),
            ),
            SizedBox(height: 10),
            FilledButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, "/manage-qrc");
              },
              label: Text("Generate"),
              icon: Icon(Icons.create),
            ),
          ],
        ),
      ),
    );
  }
}
