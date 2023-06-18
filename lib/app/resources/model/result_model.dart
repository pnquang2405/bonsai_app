
class ResultModel<T> {
  ResultModel({
    this.status,
    this.message,
    this.error,
    this.data,
  });

  ResultModel.fromJson(dynamic json) {
    status = json['status'] as int;
    message = json['message'] as String;
    error = json['error'] as String;
    data = json['data'] != null ? json['data'] as T : null;
  }
  int? status;
  String? message;
  String? error;
  T? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['error'] = error;
    if (data != null) {
      map['data'] = data;
    }
    return map;
  }
}
