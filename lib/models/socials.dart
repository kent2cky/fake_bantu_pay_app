class Socials {
  String? bantuTalk;
  String? facebook;
  String? instagram;
  String? linkedIn;
  String? twitter;
  Socials({
    this.bantuTalk,
    this.facebook,
    this.instagram,
    this.linkedIn,
    this.twitter,
  });

  toJSONEncodable() {
    Map<String, dynamic> m = Map();

    m['bantuTalk'] = bantuTalk;
    m['facebook'] = facebook;
    m['instagram'] = instagram;
    m['linkedIn'] = linkedIn;
    m['twitter'] = twitter;

    return m;
  }

  deserializeJson(Map<String, dynamic> m) {
    return Socials(
      bantuTalk: m['bantuTalk'],
      facebook: m['facebook'],
      instagram: m['instagram'],
      linkedIn: m['linkedIn'],
      twitter: m['twitter'],
    );
  }
}
