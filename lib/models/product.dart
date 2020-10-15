class Product{
  final String productId;
  final String name;
  final double experience ;
  final String url;
  final int startHour;
  final int startMin;
  final int endHour;
  final int endMin;
  final double fees;
  final String field;
  final String intro;
  final String languages;
  final int type;
  final double rating;

  Product({this.productId,this.experience, this.name,this.url,this.startHour,this.startMin,this.endHour,this.endMin,this.fees,this.field,this.intro,this.languages,this.type,this.rating});

  Map<String,dynamic> time(){
    return {
      'startHour':startHour,
      'startMin':startMin,
      'endHour':endHour,
      'endMin':endMin,
    };
  }

  Map<String,dynamic> toMap(){
    return {
      'productId' : productId,
      'name' : name,
      'experience' : experience,
      'url' : url,
      'time':time(),
      'fees' : fees,
      'field' : field,
      'intro' : intro,
      'languages' : languages,
      'type' : type,
      'rating' : rating,
    };
  }
  Product.fromFirestore(Map<String, dynamic> firestore)
      : productId = firestore['productId'],
        name = firestore['name'],
        experience = firestore['experience'],
        url = firestore['url'],
        startHour = firestore['startHour'],
        startMin = firestore['startMin'],
        endHour = firestore['endHour'],
        endMin = firestore['endMin'],
        fees = firestore['fees'],
        field = firestore['field'],
        intro = firestore['intro'],
        languages = firestore['languages'],
        type = firestore['type'],
        rating = firestore['rating'];
}
