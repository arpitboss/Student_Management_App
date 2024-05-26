import 'package:flutter_bloc/flutter_bloc.dart';

import 'bottom_nav_event.dart';
import 'bottom_nav_state.dart';

class BottomNavigationBloc extends Bloc<BottomNavigationEvent, int> {
  BottomNavigationBloc() : super(0) {
    on<BottomNavigationChanged>(_onBottomNavigationChanged);
  }

  void _onBottomNavigationChanged(
    BottomNavigationChanged event,
    Emitter<int> emit,
  ) {
    emit(event.newIndex);
  }
}
