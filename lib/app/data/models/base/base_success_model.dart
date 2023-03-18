class BaseSuccessModel {
  Map<String, dynamic>? data;
  String? message;

  BaseSuccessModel({this.data, this.message});

  @override
  String toString() => 'BaseSuccessModel(data: $data, message: $message)';

  factory BaseSuccessModel.fromJson(Map<String, dynamic> json) {
    return BaseSuccessModel(
      data: json['data'] == null ? null : json['data'],
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'data': data,
        'message': message,
      };
}
