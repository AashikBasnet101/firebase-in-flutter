import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newprojectfirebase/features/test/test_event.dart';
import 'package:newprojectfirebase/features/test/test_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(InitialState()) {
    on<IncrementEvent>((event, emit) {
      if (state is UpdatedState) {
        emit(UpdatedState((state as UpdatedState).count + 1));
      } else {
        emit(UpdatedState(1));
      }
    });

    on<DecrementEvent>((event, emit) {
      if (state is UpdatedState) {
        emit(UpdatedState((state as UpdatedState).count - 1));
      } else {
        emit(UpdatedState(-1));
      }
    }
    );

    on <LoginEvent>((event, emit) {
      
    });
  }
}



///password visibility bloc
class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  PasswordBloc() : super(const PasswordInitialState()) {
    on<TogglePasswordVisibility>((event, emit) {
      if (state is PasswordUpdatedState) {
        emit(PasswordUpdatedState(!(state as PasswordUpdatedState).isVisible));
      } else {
        emit(const PasswordUpdatedState(true));
      }
    });
  }
}