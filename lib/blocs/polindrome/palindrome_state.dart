abstract class PalindromeState {}

class PalindromeInitials extends PalindromeState {}

class PalindromeResults extends PalindromeState {
  final bool isPalindrome;

  PalindromeResults(this.isPalindrome);
}
