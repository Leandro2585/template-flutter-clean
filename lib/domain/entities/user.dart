import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String name;
  final String email;
  final String avatarURL;
  final DateTime bornDate;

  const User({ required this.name, required this.email, required this.bornDate, required this.avatarURL });
  
  @override
  List<Object> get props => [
    name,
    email,
    avatarURL,
    bornDate
  ];
}