import 'package:equatable/equatable.dart';

class ErrorMessageModel extends Equatable {
  final String title;
  final int status;

  const ErrorMessageModel({required this.title, required this.status});

  @override
  List<Object?> get props => [title, status];

  factory ErrorMessageModel.fromJson(Map<String, dynamic> json) {
    return ErrorMessageModel(title: json['title'], status: json['status']);
  }
}
