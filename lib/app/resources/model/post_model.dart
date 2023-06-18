/// data : {"idPost":6183072220184576,"isLike":true}

class PostStatus {
  PostStatus({
    this.status,
    this.message,
    this.error,
    this.model,
  });

  PostStatus.fromJson(dynamic json) {
    status = json['status'] as int?;
    message = json['message'] as String?;
    error = json['error'] as String?;
    model = json['data'] != null ? PostModel.fromJson(json['data']) : null;
  }
  int? status;
  String? message;
  String? error;
  PostModel? model;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['error'] = error;
    if (model != null) {
      map['data'] = model?.toJson();
    }
    return map;
  }
}

class PostModel {
  PostModel({
    this.userId,
    this.postId,
    this.nameUser,
    this.avatarUser,
    this.namePost,
    this.describe,
    this.listImage,
    this.automaticRecognition,
    this.isLike,
    this.numLike,
    this.numComment,
    this.timePost,
  });

  PostModel.fromJson(dynamic json) {
    userId = json['userId'] as int?;
    postId = json['postId'] as int?;
    nameUser = json['nameUser'] as String?;
    avatarUser = json['avatarUser'] as String?;
    namePost = json['namePost'] as String?;
    describe = json['describe'] as String?;
    listImage = json['listImage'] != null ? json['listImage'].cast<String>() as List<String> : [];
    automaticRecognition = json['automaticRecognition'] as bool?;
    isLike = json['isLike'] as bool?;
    numLike = json['numLike'] as int?;
    numComment = json['numComment'] as int?;
    timePost = json['timePost'] as int?;
  }
  int? userId;
  int? postId;
  String? nameUser;
  String? avatarUser;
  String? namePost;
  String? describe;
  List<String>? listImage;
  bool? automaticRecognition;
  bool? isLike;
  int? numLike;
  int? numComment;
  int? timePost;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['postId'] = postId;
    map['userId'] = userId;
    map['nameUser'] = nameUser;
    map['avatarUser'] = avatarUser;
    map['namePost'] = namePost;
    map['describe'] = describe;
    map['listImage'] = listImage;
    map['automaticRecognition'] = automaticRecognition;
    map['isLike'] = isLike;
    map['numLike'] = numLike;
    map['numComment'] = numComment;
    map['timePost'] = timePost;
    return map;
  }
}
