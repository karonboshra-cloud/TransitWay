class SignUpRequestBody {
  final String fullName;
  final String email;
  final String password;
  final String phone;

  SignUpRequestBody({
    required this.fullName,
    required this.email,
    required this.password,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'password': password,
      'phone': phone,
    };
  }
}
