import 'package:flutter/material.dart';
import 'package:flutter_contact_app/models/contact_model.dart';
import 'package:flutter_contact_app/notifiers/contacts_notifier.dart';
import 'package:provider/provider.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _onSave(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final newContact = ContactModel(
      name: _nameController.text,
      phone: _phoneController.text,
    );
    context.read<ContactsNotifier>().addContact(newContact);
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
          title: const Text('Add New Contact'),
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
