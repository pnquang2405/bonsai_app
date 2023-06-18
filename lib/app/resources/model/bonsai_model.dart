class BonsaiModel {
  BonsaiModel(
      {this.idBonsai,
      this.listImage,
      this.title,
      this.describeLite,
      this.name,
      this.fee,
      this.numberFee,
      this.describe1,
      this.describe2,
      this.isLike,
      this.dateTime});

  BonsaiModel.fromJson(dynamic json) {
    idBonsai = json['idBonsai'] as int?;
    listImage = json['listImage'] != null ? json['listImage'].cast<String>() as List<String> : [];
    title = json['title'] as String?;
    describeLite = json['describeLite'] as String?;
    name = json['name'] as String?;
    fee = json['fee'] as String?;
    numberFee = json['numberFee'] as int?;
    describe1 = json['describe1'] as String?;
    describe2 = json['describe2'] as String?;
    dateTime = json['dateTime'] as int?;
    isLike = json['isLike'] as bool?;
  }
  int? idBonsai;
  List<String>? listImage;
  String? title;
  String? describeLite;
  String? name;
  String? fee;
  int? numberFee;
  String? describe1;
  String? describe2;
  int? dateTime;
  bool? isLike;
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['idBonsai'] = idBonsai;
    map['listImage'] = listImage;
    map['title'] = title;
    map['describeLite'] = describeLite;
    map['name'] = name;
    map['fee'] = fee;
    map['numberFee'] = numberFee;
    map['describe1'] = describe1;
    map['describe2'] = describe2;
    map['isLike'] = isLike;
    map['dateTime'] = dateTime;
    return map;
  }
}
