class User
{
    String? nom;
    String? email;

    User({this.nom,this.email});

    User.fromJson(Map<String, dynamic>json)
    : nom = json['nom'],
      email = json['email'];
}