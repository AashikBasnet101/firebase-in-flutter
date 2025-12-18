import 'package:newprojectfirebase/features/auth/model/user.dart';
import 'package:newprojectfirebase/features/test/test_event.dart';

abstract class AuthEvent {}
class SignupEvent extends AuthEvent {
  User? user;


  SignupEvent(this.user);
  
    
}
class LoginEvent extends AuthEvent{
  UserLogin? userLogin;
  LoginEvent( this.userLogin);


}