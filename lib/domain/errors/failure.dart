import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String? message;

  const Failure({ this.message });

  @override
  List<dynamic> get props => [message];
}