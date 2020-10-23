class Day{
  final String monday;
  final String tuesday;
  final String wednesday ;
  final String thursday;
  final String friday;
  final String saturday;
  final String sunday;
  final String forall;
  final String productId;

  Day({this.monday,this.tuesday, this.wednesday,this.thursday,this.friday,this.saturday,this.sunday, this.forall,this.productId});

  Map<String,dynamic> toMap2(){
    return {
      'monday' : monday,
      'tuesday' : tuesday,
      'wednesday' : wednesday,
      'thursday' : thursday,
      'friday' : friday,
      'saturday' : saturday,
      'sunday' : sunday,
      'forall' : forall,
      'productId':productId,
    };
  }

  Day.fromFirestore2(Map<String, dynamic> firestore2)
      : productId = firestore2['productId'],
        monday = firestore2['monday'],
        tuesday = firestore2['tuesday'],
        wednesday = firestore2['wednesday'],
        thursday = firestore2['thursday'],
        friday = firestore2['friday'],
        saturday = firestore2['saturday'],
        sunday = firestore2['sunday'],
        forall = firestore2['forall'];
}
