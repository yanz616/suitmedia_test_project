abstract class PalindromeEvent {}

class CheckPalindromeEvent extends PalindromeEvent {
  final String text;

  CheckPalindromeEvent(this.text);
}
