/// status : 0
/// message : "Thành công"
/// error : ""
/// data : {"userId":124,"tokenID":"jagsdvanmwbrhfjagcioajsdladfbgxfb2hn4","email":"abc@gmail.com","avatar":"https://images.pexels.com/photos/2825578/pexels-photo-2825578.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940","name":"Phạm Ngọc Quang"}

class UserModel {
  UserModel({
    this.status,
    this.message,
    this.error,
    this.data,
  });

  UserModel.fromJson(dynamic json) {
    status = json['status'] as int;
    message = json['message'] as String;
    error = json['error'] as String;
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  int? status;
  String? message;
  String? error;
  Data? data;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['error'] = error;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

/// userId : 124
/// tokenID : "jagsdvanmwbrhfjagcioajsdladfbgxfb2hn4"
/// email : "abc@gmail.com"
/// avatar : "https://images.pexels.com/photos/2825578/pexels-photo-2825578.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"
/// name : "Phạm Ngọc Quang"

class Data {
  Data({
    this.userId,
    this.tokenID,
    this.email,
    this.avatar,
    this.name,
  });

  Data.fromJson(dynamic json) {
    userId = json['userId'] as int?;
    tokenID = json['tokenID'] as String?;
    email = json['email'] as String?;
    avatar = json['avatar'] as String?;
    name = json['name'] as String?;
  }
  int? userId;
  String? tokenID;
  String? email;
  String? avatar;
  String? name;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['userId'] = userId;
    map['tokenID'] = tokenID;
    map['email'] = email;
    map['avatar'] = avatar;
    map['name'] = name;
    return map;
  }
}
