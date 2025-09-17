class Users {
  final String uid; 
  final String name;
  final String? profession;
  final String email;
  final String? phone;
  final String? address;
  final String? bio;
  final String? photo; 
  final String? linkedin;
  final String? github;

  Users({
    required this.uid,
    required this.name,
    required this.email,
    this.profession,
    this.photo,
    this.phone,
    this.address,
    this.linkedin,
    this.github,
    this.bio,
  });

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      profession: map['profession'],
      photo: map['photo'],
      phone: map['phone'],
      address: map['address'],
      linkedin: map['linkedin'],
      github: map['github'],
      bio: map['bio'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'profession': profession,
      'email': email,
      'phone': phone,
      'address': address,
      'bio': bio,
      'photo': photo,
      'linkedin': linkedin,
      'github': github,
    };
  }
}