class MyCollectionModel {
  MyCollectionModel({
    this.status,
    this.message,
    this.error,
    this.data,
  });

  MyCollectionModel.fromJson(dynamic json) {
    status = json['status'] as int;
    message = json['message'] as String;
    error = json['error'] as String;
    data = json['data'] != null ? DataCollection.fromJson(json['data']) : null;
  }
  int? status;
  String? message;
  String? error;
  DataCollection? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['error'] = error;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

class ListFavorites {
  ListFavorites({
    this.idBonsai,
    this.listImage,
    this.title,
    this.describeLite,
    this.name,
    this.fee,
    this.numberFee,
    this.describe1,
    this.describe2,
  });

  ListFavorites.fromJson(dynamic json) {
    idBonsai = json['idBonsai'] as int;
    listImage = json['listImage'] != null ? json['listImage'].cast<String>() as List<String> : [];
    title = json['title'] as String;
    describeLite = json['describeLite'] as String;
    name = json['name'] as String;
    fee = json['fee'] as String;
    numberFee = json['numberFee'] as int;
    describe1 = json['describe1'] as String;
    describe2 = json['describe2'] as String;
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
    return map;
  }
}

class DataCollection {
  DataCollection({
    this.listFavorites,
  });

  DataCollection.fromJson(dynamic json) {
    if (json['listFavorites'] != null) {
      listFavorites = [];
      json['listFavorites'].forEach((v) {
        listFavorites?.add(ListFavorites.fromJson(v));
      });
    }
  }
  List<ListFavorites>? listFavorites;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (listFavorites != null) {
      map['listFavorites'] = listFavorites?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
