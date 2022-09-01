
class UserModel {
  String? uid;
  String? email;
  String? name;

  UserModel(
      {this.uid, this.email, this.name, });

  // receving data from server

  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      name: map['Name'],
    );
  }
// sending data to server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'Name': name,
 
    };
  }
}
