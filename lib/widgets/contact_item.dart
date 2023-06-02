import 'package:flutter/material.dart';

import '../models/contact_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactItem extends StatelessWidget {
  const ContactItem({
    super.key,
    required this.contact,
  });

  final ContactModel contact;

  _call(String number) {
    Uri uri = Uri(
      scheme: 'tel',
      path: number,
    );
    launchUrl(
      uri,
    );
  }

  _sms(String number) {
    Uri uri = Uri(
      scheme: 'sms',
      path: number,
    );
    launchUrl(
      uri,
    );
  }

  @override
  Widget build(BuildContext context) {
    String avatarText = contact.name.substring(0, 1);
    if (contact.name.split(' ').length > 1) {
      avatarText = contact.name.split(' ')[0].substring(0, 1);
      avatarText += contact.name.split(' ')[1].substring(0, 1);
    }
    return ListTile(
      leading: CircleAvatar(
        radius: 40,
        child: Text(avatarText),
      ),
      title: Text(contact.name),
      subtitle: Text(contact.phone),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              _call(contact.phone);
            },
            child: const Icon(Icons.phone),
          ),
          const SizedBox(width: 20),
          GestureDetector(
            onTap: () {
              _sms(contact.phone);
            },
            child: const Icon(Icons.sms),
          ),
        ],
      ),
    );
  }
}
