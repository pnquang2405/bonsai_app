import '../resources.dart';
import 'Data.dart';

class PostDetailModel {
  PostDetailModel({
    this.status,
    this.message,
    this.error,
    this.data,
  });

  PostDetailModel.fromJson(dynamic json) {
    status = json['status'] as int?;
    message = json['message'] as String?;
    error = json['error'] as String?;
    data = json['data'] != null ? DataPostDetail.fromJson(json['data']) : null;
  }
  int? status;
  String? message;
  String? error;
  DataPostDetail? data;

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


class DataPostDetail {
  DataPostDetail({
    this.timeRequset,
    this.postInfo,
    this.comment,});

  DataPostDetail.fromJson(dynamic json) {
    timeRequset = json['timeRequset'] as int;
    postInfo = json['postInfo'] != null ? PostModel.fromJson(json['postInfo'] ) : null;
    if (json['comment'] != null) {
      comment = [];
      json['comment'].forEach((v) {
        comment?.add(Comment.fromJson(v));
      });
    }
  }
  int? timeRequset;
  PostModel? postInfo;
  List<Comment>? comment;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['timeRequset'] = timeRequset;
    if (postInfo != null) {
      map['postInfo'] = postInfo?.toJson();
    }
    if (comment != null) {
      map['comment'] = comment?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Comment {
  Comment({
    this.userId,
    this.avatar,
    this.name,
    this.timeComment,
    this.message,});

  Comment.fromJson(dynamic json) {
    userId = json['userId'] as int;
    avatar = json['avatar'] as String;
    name = json['name']as String;
    timeComment = json['timeComment'] as int;
    message = json['message']as String;
  }
  int? userId;
  String? avatar;
  String? name;
  int? timeComment;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = userId;
    map['avatar'] = avatar;
    map['name'] = name;
    map['timeComment'] = timeComment;
    map['message'] = message;
    return map;
  }

}