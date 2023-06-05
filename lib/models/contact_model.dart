class ContactModel {
  final String id;
  final String name;
  final String phone;

  ContactModel({
    String? uid,
    required this.name,
    required this.phone,
  }) : id = uid ?? DateTime.now().millisecondsSinceEpoch.toString();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
    };
  }

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      uid: json['id'],
      name: json['name'],
      phone: json['phone'],
    );
  }
}
