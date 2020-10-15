class Approved{
  String approved;
  String email;
  String licenseNumber;
  String productId;

  Approved({this.approved, this.email,this.licenseNumber,this.productId});

  Map<String,dynamic> time(){
    return {
      'approved' : approved,
      'email' : email,
      'licenseNumber' : licenseNumber,
      'productId' : productId,
    };
  }


  Map<String,dynamic> toMap(){
    return {
      'productId' : productId,
      'approved' : approved,
      'email' : email,
      'licenseNumber' : licenseNumber,
    };
  }


  Approved.fromFirestore3(Map<String, dynamic> firestore)
      : productId = firestore['productId'],
        licenseNumber = firestore['licenseNumber'],
        email = firestore['email'],
        approved = firestore['approved'];
}