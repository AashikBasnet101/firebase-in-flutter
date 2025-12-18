import 'package:newprojectfirebase/features/auth/model/user.dart';

abstract class AuthEvent {}
class SignupEvent extends AuthEvent {
  User? user;


  SignupEvent(this.user);
}