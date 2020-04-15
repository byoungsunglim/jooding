class Account {
  final String name;
  final String email;
  final String profile_image;
  final String kakao_id;
  final String phone;

  Account({this.name, this.email, this.profile_image, this.kakao_id, this.phone});

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      name: json['user']['name'],
      email: json['user']['email'],
      profile_image: json['user']['profile_image'],
      kakao_id: json['user']['kakao_id'],
      phone: json['user']['phone']
    );
  }
}