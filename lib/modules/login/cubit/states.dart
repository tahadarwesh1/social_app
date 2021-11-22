import 'package:social_app/models/user_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLodingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final String uId;
  LoginSuccessState(this.uId);
}

class LoginErrorState extends LoginStates {
  final String error;

  LoginErrorState(this.error);
}

class LoginPasswordVisibilityState extends LoginStates {}
