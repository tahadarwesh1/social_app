abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

class SocialBottomNavState extends SocialStates {}
class AddNewPostState extends SocialStates {}

class SocialLoadingState extends SocialStates {}

class SocialSuccessState extends SocialStates {}

class SocialErrorState extends SocialStates {}


class GetUserDataSuccessState extends SocialStates {}

class GetUserDataErrorState extends SocialStates {
  final error;
  GetUserDataErrorState(this.error);
}

class GetUserDataLoadingState extends SocialStates {}

class UserUpdateDataSuccessState extends SocialStates {
//   LoginModel loginModel;
//   UserUpdateDataSuccessState(this.loginModel);
}

class UserUpdateDataErrorState extends SocialStates {}

class UserUpdateDataLoadingState extends SocialStates {}
