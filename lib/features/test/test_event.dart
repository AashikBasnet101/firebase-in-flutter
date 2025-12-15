abstract class CounterEvent {}

class IncrementEvent extends CounterEvent {}

class DecrementEvent extends CounterEvent {}
class LoginEvent extends CounterEvent {}


// for passwordVisibility
abstract class PasswordEvent{}
class TogglePasswordVisibility extends PasswordEvent{}



//api event
abstract class ApiEvent {}

class FetchDataEvent extends ApiEvent {}
