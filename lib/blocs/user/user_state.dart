import 'package:suitmedia_project1/models/user.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<User> users;
  final int currentPage;
  final bool hasReachedMax;

  UserLoaded({
    required this.users,
    required this.currentPage,
    required this.hasReachedMax,
  });
}

class UserError extends UserState {
  final String message;

  UserError(this.message);
}
