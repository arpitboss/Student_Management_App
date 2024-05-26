import 'bottom_nav_event.dart';

class BottomNavigationChanged extends BottomNavigationEvent {
  final int newIndex;

  BottomNavigationChanged(this.newIndex);

  @override
  String toString() => 'BottomNavigationChanged { newIndex: $newIndex }';
}
