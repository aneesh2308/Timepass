class Time{
  final String fromHour;
  final String fromMinute;
  final String toHour ;
  final String toMinute;
  final String productId;

  Time({this.fromHour,this.fromMinute, this.toHour,this.toMinute,this.productId});

  Map<String,dynamic> toMap1(){
    return {
      'FromHour' : fromHour,
      'FromMinute' : fromMinute,
      'ToHour' : toHour,
      'ToMinute' : toMinute,
      'productId':productId,
    };
  }

  Time.fromFirestore1(Map<String, dynamic> firestore1)
      : productId = firestore1['productId'],
        fromHour = firestore1['FromHour'],
        fromMinute = firestore1['FromMinute'],
        toHour = firestore1['ToHour'],
        toMinute = firestore1['ToMinute'];
}
