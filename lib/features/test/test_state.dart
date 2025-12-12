abstract class CounterState {
  final int count;
  const CounterState(this.count);
}

class InitialState extends CounterState {
  const InitialState() : super(0);
}

class UpdatedState extends CounterState {
  const UpdatedState(int count) : super(count);
}

//password visibility
abstract class PasswordState {
  final bool isVisible;
  const PasswordState(this.isVisible);
}

class PasswordInitialState extends PasswordState {
  const PasswordInitialState() : super(false); 
}

class PasswordUpdatedState extends PasswordState {
  const PasswordUpdatedState(bool isVisible) : super(isVisible);
}
