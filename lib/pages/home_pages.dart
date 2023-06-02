import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contact_app/notifiers/contacts_notifier.dart';
import 'package:flutter_contact_app/pages/add_contact.dart';
import 'package:provider/provider.dart';

import '../widgets/contact_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<ContactsNotifier>();
    notifier.loadContacts();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const AddContact(),
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: notifier.contacts.isEmpty
          ? const SizedBox()
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: notifier.contacts.length,
              itemBuilder: (context, index) {
                return ContactItem(contact: notifier.contacts[index]);
              },
            ),
    );
  }
}
