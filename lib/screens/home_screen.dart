import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contact_app/providers/contacts_provider.dart';
import 'package:flutter_contact_app/screens/add_contact.dart';
import 'package:provider/provider.dart';

import '../widgets/contact_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final contactProvider = context.watch<ContactsProvider>();
    contactProvider.loadContacts();
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
      body: contactProvider.contacts.isEmpty
          ? const SizedBox()
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: contactProvider.contacts.length,
              itemBuilder: (context, index) {
                return ContactItem(contact: contactProvider.contacts[index]);
              },
            ),
    );
  }
}
