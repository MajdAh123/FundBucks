class BaseErrorModel {
  final String? message;
  final String? error;

  const BaseErrorModel({this.message, this.error});

  factory BaseErrorModel.fromJson(Map<String, dynamic> json) {
    return BaseErrorModel(
      message: json['message'] as String?,
      error: json['error'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'error': error,
      };

  BaseErrorModel copyWith({
    String? message,
    String? error,
  }) {
    return BaseErrorModel(
      message: message ?? this.message,
      error: error ?? this.error,
    );
  }
}
