abstract class UserEvent {}

class FetchUsers extends UserEvent {
  final bool isRefresh;

  FetchUsers({this.isRefresh = false});
}
