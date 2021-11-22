class UserModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  bool? isVirified;

  UserModel({
    this.name,
    this.email,
    this.phone,
    this.uId,
    this.isVirified,
  });
  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    isVirified = json['isVirified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'isVirified': isVirified,
    };
  }
}
