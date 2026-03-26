import 'package:flutter/material.dart';
import 'package:qrc/main.dart';
import 'package:qrc/models/card.dart';
import 'package:qrc/widget/app_bar.dart';
import 'package:qrc/widget/theme_button.dart';

class PrepareQrCodeData extends StatefulWidget {
  const PrepareQrCodeData({super.key});

  @override
  State<PrepareQrCodeData> createState() => _PrepareQrCodeDataState();
}

class _PrepareQrCodeDataState extends State<PrepareQrCodeData> {
  final TextEditingController _dataController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  bool isText = true;
  bool isVcard = false;

  void _loadVcardView() {
    setState(() {
      isText = false;
      isVcard = true;
    });
  }

  void _loadTextView() {
    setState(() {
      isText = true;
      isVcard = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: AppBarTitle(showHomeButton: false),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.title),
                          label: Text("Titre", style: adapteText(context)),
                        ),
                        controller: _titleController,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Contenu code bar", style: adapteText(context)),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton.icon(
                              onPressed: () {
                                _loadTextView();
                              },
                              label: Text(
                                "text/url",
                                style: adapteText(context),
                              ),
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              _loadVcardView();
                            },
                            label: Text("vCard", style: adapteText(context)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (isText) ...[
                  Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: _dataController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.dataset),
                            label: Text("Données", style: adapteText(context)),
                          ),
                        ),

                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context, _dataController.text);
                          },
                          child: Text("Suivant", style: adapteText(context)),
                        ),
                      ],
                    ),
                  ),
                ],
                if (isVcard) ...[
                  Card(
                    child: VCardForm(
                      onSubmit: (card) {
                        Navigator.pop(context, card.toVCard());
                      },
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
