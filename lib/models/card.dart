import 'package:flutter/material.dart';
import 'package:qrc/main.dart';

class vCard {
  final String nom;
  final String? prenom;
  final String? telephone;
  final String? email;
  final String? entreprise;
  final String? siteWeb;
  final String? adresse;

  vCard({
    required this.nom,
    this.prenom,
    this.telephone,
    this.email,
    this.entreprise,
    this.siteWeb,
    this.adresse,
  });

  String toVCard() {
    final buffer = StringBuffer();

    buffer.writeln('BEGIN:VCARD');
    buffer.writeln('VERSION:3.0');

    buffer.writeln('N:$nom;${prenom ?? ''}');
    buffer.writeln('FN:${prenom ?? ''} $nom');

    if (entreprise != null) {
      buffer.writeln('ORG:$entreprise');
    }

    if (telephone != null) {
      buffer.writeln('TEL:$telephone');
    }

    if (email != null) {
      buffer.writeln('EMAIL:$email');
    }

    if (siteWeb != null) {
      buffer.writeln('URL:$siteWeb');
    }

    if (adresse != null) {
      buffer.writeln('ADR:$adresse');
    }

    buffer.writeln('END:VCARD');

    return buffer.toString();
  }
}

class VCardForm extends StatefulWidget {
  final void Function(vCard card) onSubmit;

  const VCardForm({super.key, required this.onSubmit});

  @override
  State<VCardForm> createState() => _VCardFormState();
}

class _VCardFormState extends State<VCardForm> {
  final _nomCtrl = TextEditingController();
  final _prenomCtrl = TextEditingController();
  final _telCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _entrepriseCtrl = TextEditingController();
  final _siteCtrl = TextEditingController();
  final _adresseCtrl = TextEditingController();

  void _submit() {
    if (_nomCtrl.text.trim().isEmpty) return;

    final card = vCard(
      nom: _nomCtrl.text.trim(),
      prenom: _prenomCtrl.text.trim().isEmpty ? null : _prenomCtrl.text.trim(),
      telephone: _telCtrl.text.trim().isEmpty ? null : _telCtrl.text.trim(),
      email: _emailCtrl.text.trim().isEmpty ? null : _emailCtrl.text.trim(),
      entreprise: _entrepriseCtrl.text.trim().isEmpty
          ? null
          : _entrepriseCtrl.text.trim(),
      siteWeb: _siteCtrl.text.trim().isEmpty ? null : _siteCtrl.text.trim(),
      adresse: _adresseCtrl.text.trim().isEmpty
          ? null
          : _adresseCtrl.text.trim(),
    );

    widget.onSubmit(card);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            "INFOS",
            textAlign: TextAlign.center,
            style: adapteText(context, fontWeight: FontWeight.bold),
          ),
          TextField(
            controller: _nomCtrl,
            decoration: const InputDecoration(labelText: "Nom *"),
          ),
          TextField(
            controller: _prenomCtrl,
            decoration: const InputDecoration(labelText: "Prénom"),
          ),
          TextField(
            controller: _telCtrl,
            decoration: const InputDecoration(labelText: "Téléphone"),
          ),
          TextField(
            controller: _emailCtrl,
            decoration: const InputDecoration(labelText: "Email"),
          ),
          TextField(
            controller: _entrepriseCtrl,
            decoration: const InputDecoration(labelText: "Entreprise"),
          ),
          TextField(
            controller: _siteCtrl,
            decoration: const InputDecoration(labelText: "Site web"),
          ),
          TextField(
            controller: _adresseCtrl,
            decoration: const InputDecoration(labelText: "Adresse"),
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: _submit,
            child: Text("Suivant", style: adapteText(context)),
          ),
        ],
      ),
    );
  }
}
