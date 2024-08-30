
import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({required this.id, required this.email,required this.name,required this.photo, required this.emailVerified});

  final String id;
  final String email;
  final String name;
  final String photo;
  final bool emailVerified;

  @override
  List<Object> get props => [id, email, name, photo,emailVerified];
}