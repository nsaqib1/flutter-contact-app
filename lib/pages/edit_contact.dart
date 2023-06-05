import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/contact_model.dart';
import '../notifiers/contacts_notifier.dart';

class EditContact extends StatefulWidget {
  const EditContact({
    super.key,
    required this.contact,
  });

  final ContactModel contact;

  @override
  State<EditContact> createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _onSave(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final newContact = ContactModel(
      uid: widget.contact.id,
      name: _nameController.text,
      phone: _phoneController.text,
    );
    context.read<ContactsNotifier>().editContact(newContact);
    FocusScope.of(context).unfocus();

    Navigator.pop(context);
  }

  String? _fieldValidator(String? value) {
    if (value!.isEmpty) {
      return 'Field cannot be empty!';
    }
    return null;
  }

  @override
  void initState() {
    _nameController.value = TextEditingValue(text: widget.contact.name);
    _phoneController.value = TextEditingValue(text: widget.contact.phone);
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit This Contact'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  validator: _fieldValidator,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    label: Text('Name'),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _phoneController,
                  validator: _fieldValidator,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    label: Text('Phone'),
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () => _onSave(context),
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
