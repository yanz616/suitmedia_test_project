import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suitmedia_project1/models/user.dart';
import 'user_event.dart';
import 'user_state.dart';
import '../../repositories/user_repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  static const int _firstPage = 1;

  int _currentPage = _firstPage;
  bool _hasReachedMax = false;
  final List<User> _users = [];

  UserBloc(this.userRepository) : super(UserInitial()) {
    on<FetchUsers>(_onFetchUsers);
  }

  Future<void> _onFetchUsers(FetchUsers event, Emitter<UserState> emit) async {
    if (state is UserLoading) return;

    if (event.isRefresh) {
      _currentPage = _firstPage;
      _users.clear();
      _hasReachedMax = false;
    }

    emit(UserLoading());

    try {
      final newUsers = await userRepository.fetchUsers(
        page: _currentPage,
        perPage: 6,
      );

      if (newUsers.isEmpty) {
        _hasReachedMax = true;
      } else {
        _currentPage++;
        _users.addAll(newUsers);
      }

      emit(
        UserLoaded(
          users: _users,
          currentPage: _currentPage,
          hasReachedMax: _hasReachedMax,
        ),
      );
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}
