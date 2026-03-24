import 'package:flutter/material.dart';
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
        actions: [ThemeButton()],
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/images/logo.png", fit: BoxFit.contain),
            FilledButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, "/scan");
              },
              label: Text("Scanner"),
              icon: Icon(Icons.qr_code),
            ),
          ],
        ),
      ),
    );
  }
}
