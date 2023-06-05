import 'package:flutter/material.dart';
import 'package:flutter_contact_app/notifiers/contacts_notifier.dart';
import 'package:flutter_contact_app/pages/edit_contact.dart';
import 'package:provider/provider.dart';

import '../models/contact_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
    String avatarText = contact.name.substring(0, 1).toUpperCase();
    if (contact.name.split(' ').length > 1) {
      avatarText = contact.name.split(' ')[0].substring(0, 1).toUpperCase();
      avatarText += contact.name.split(' ')[1].substring(0, 1).toUpperCase();
    }
    return Slidable(
      endActionPane: ActionPane(
        motion: BehindMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EditContact(contact: contact),
                ),
              );
            },
            foregroundColor: Colors.blue,
            backgroundColor: Colors.blueGrey.shade100,
            icon: Icons.edit,
            label: 'Edit',
          ),
          SlidableAction(
            onPressed: (context) {
              context.read<ContactsNotifier>().deleteContact(contact);
            },
            foregroundColor: Colors.red,
            backgroundColor: Colors.blueGrey.shade100,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: ListTile(
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
      ),
    );
  }
}
