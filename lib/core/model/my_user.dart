class MyUser{
  static const String collectionName = 'users';
  String? fullName;
  String? email;
  String? id;

  MyUser({required this.id, required this.fullName, required this.email});

  MyUser.fromFireStore(Map<String,dynamic> data):this(
    id: data['id'] as String,
    email: data['email'] as String,
    fullName: data['fullName'] as String,
  );

  Map<String,dynamic> toFireStore(){
    return {
      'id' : id,
      'fullName' : fullName,
      'email' : email
    };
  }
}