// import 'PostInfo.dart';
// import 'Comment.dart';
// import 'model.dart';
//
// class DataPostDetail {
//   DataPostDetail({
//       this.timeRequset,
//       this.postInfo,
//       this.comment,});
//
//   DataPostDetail.fromJson(dynamic json) {
//     timeRequset = json['timeRequset'];
//     postInfo = json['postInfo'] != null ? PostInfo.fromJson(json['postInfo']) : null;
//     if (json['comment'] != null) {
//       comment = [];
//       json['comment'].forEach((v) {
//         comment.add(Comment.fromJson(v));
//       });
//     }
//   }
//   int timeRequset;
//   PostModel postInfo;
//   List<Comment> comment;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['timeRequset'] = timeRequset;
//     if (postInfo != null) {
//       map['postInfo'] = postInfo.toJson();
//     }
//     if (comment != null) {
//       map['comment'] = comment.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
//
// }