import 'package:suitmedia_project1/blocs/polindrome/palindrome_event.dart';
import 'package:suitmedia_project1/blocs/polindrome/palindrome_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PalindromeBloc extends Bloc<CheckPalindromeEvent, PalindromeState> {
  PalindromeBloc() : super(PalindromeInitials()) {
    on<CheckPalindromeEvent>((event, emit) {
      final cleaned = event.text.replaceAll(RegExp(r'\s+'), '').toLowerCase();
      final reversed = cleaned.split('').reversed.join();
      final isPalindrome = cleaned == reversed;
      emit(PalindromeResults(isPalindrome));
    });
  }
}
