/// status : 0
/// message : "Thành công"
/// error : ""
/// data : {"idPost":6183072220184576,"isLike":true}

class LikeModel {
  LikeModel({
    this.status,
    this.message,
    this.error,
    this.data,
  });

  LikeModel.fromJson(dynamic json) {
    status = json['status'] as int?;
    message = json['message'] as String?;
    error = json['error'] as String ?;
    data = json['data'] != null ? LikeData.fromJson(json['data']) : null;
  }
  int? status;
  String? message;
  String? error;
  LikeData? data;

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

/// idPost : 6183072220184576
/// isLike : true

class LikeData {
  LikeData({
    this.idPost,
    this.isLike,
  });

  LikeData.fromJson(dynamic json) {
    idPost = json['idPost'] as int?;
    isLike = json['isLike'] as bool?;
  }
  int? idPost;
  bool? isLike;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['idPost'] = idPost;
    map['isLike'] = isLike;
    return map;
  }
}
