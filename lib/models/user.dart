class User {
  String? userId;
  String username;
  String walletAddress;
  String? firstName;
  String? lastName;
  String? otherName;
  String? image;

  User({
    required this.username,
    required this.walletAddress,
    this.firstName,
    this.lastName,
    this.otherName,
    this.image,
  });
}
