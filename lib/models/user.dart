import 'socials.dart';

class User {
  String? userId;
  String? username;
  String? walletAddress;
  String? firstName;
  String? lastName;
  String? otherName;
  String? image;
  String? email;
  String? phoneNumber;
  String? referrer;
  String? password;
  String? secretKey;
  String? publicKey;
  Socials? socials;

  User({
    this.username,
    this.walletAddress,
    this.firstName,
    this.lastName,
    this.otherName,
    this.image,
    this.email,
    this.phoneNumber,
    this.referrer,
    this.password,
    this.secretKey,
    this.publicKey,
    this.socials,
  });

  toJSONEncodable() {
    Map<String, dynamic> m = Map();

    m['username'] = username;
    m['walletAddress'] = walletAddress;
    m['firstName'] = firstName;
    m['lastName'] = lastName;
    m['otherName'] = otherName;
    m['image'] = image;
    m['email'] = email;
    m['phoneNumber'] = phoneNumber;
    m['referrer'] = referrer;
    m['password'] = password;
    m['secretKey'] = secretKey;
    m['publicKey'] = publicKey;
    m['socials'] = socials?.toJSONEncodable();

    return m;
  }

  deserializeJson(Map<String, dynamic> m) {
    return User(
      username: m['username'],
      walletAddress: m['walletAddress'],
      firstName: m['firstName'],
      lastName: m['lastName'],
      otherName: m['otherName'],
      image: m['image'],
      email: m['email'],
      phoneNumber: m['phoneNumber'],
      referrer: m['referrer'],
      password: m['password'],
      secretKey: m['secretKey'],
      publicKey: m['publicKey'],
      socials: m['socials'] != null
          ? Socials().deserializeJson(m['socials'])
          : m['socials'],
    );
  }
}
