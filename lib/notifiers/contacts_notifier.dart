import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_contact_app/models/contact_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactsNotifier extends ChangeNotifier {
  List<ContactModel> contacts = [];

  Future<void> loadContacts() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? encodedContacts = prefs.getStringList('contacts');
    if (encodedContacts == null) {
      return;
    }

    List<ContactModel> loadedContacts = encodedContacts.map((encodedContact) {
      Map<String, dynamic> json = jsonDecode(encodedContact);
      return ContactModel.fromJson(json);
    }).toList();

    contacts = loadedContacts;
    notifyListeners();
  }

  Future<void> addContact(ContactModel contact) async {
    final prefs = await SharedPreferences.getInstance();

    contacts.add(contact);
    notifyListeners();
    prefs.setStringList(
      'contacts',
      contacts.map(
        (e) {
          return jsonEncode(
            e.toJson(),
          );
        },
      ).toList(),
    );
  }

  Future<void> editContact(ContactModel contact) async {
    final prefs = await SharedPreferences.getInstance();

    contacts = contacts.map(
      (e) {
        if (contact.id == e.id) {
          return contact;
        } else {
          return e;
        }
      },
    ).toList();
    notifyListeners();
    prefs.setStringList(
      'contacts',
      contacts.map(
        (e) {
          return jsonEncode(
            e.toJson(),
          );
        },
      ).toList(),
    );
  }

  Future<void> deleteContact(ContactModel contact) async {
    final prefs = await SharedPreferences.getInstance();

    contacts.removeWhere((element) => element.id == contact.id);
    notifyListeners();
    prefs.setStringList(
      'contacts',
      contacts.map(
        (e) {
          return jsonEncode(
            e.toJson(),
          );
        },
      ).toList(),
    );
  }
}
