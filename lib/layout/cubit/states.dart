abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

class SocialBottomNavState extends SocialStates {}

class AddNewPostState extends SocialStates {}

class GetProfileImageSuccessState extends SocialStates {}

class GetProfileImageErrorState extends SocialStates {}

class GetCoverImageSuccessState extends SocialStates {}

class GetCoverImageErrorState extends SocialStates {}

class UploadProfileImageSuccessState extends SocialStates {}

class UploadProfileImageErrorState extends SocialStates {}

class UploadCoverImageSuccessState extends SocialStates {}

class UploadCoverImageErrorState extends SocialStates {}

class GetUserDataLoadingState extends SocialStates {}

class GetUserDataSuccessState extends SocialStates {}

class GetUserDataErrorState extends SocialStates {
  final error;
  GetUserDataErrorState(this.error);
}

class GetAllUsersDataLoadingState extends SocialStates {}

class GetAllUsersDataSuccessState extends SocialStates {}

class GetAllUsersDataErrorState extends SocialStates {
  final error;
  GetAllUsersDataErrorState(this.error);
}

class GetPostsLoadingState extends SocialStates {}

class GetPostsSuccessState extends SocialStates {}

class GetPostsErrorState extends SocialStates {
  final error;
  GetPostsErrorState(this.error);
}

class GetLikePostSuccessState extends SocialStates {}

class GetCommentPostSuccessState extends SocialStates {}

class LikePostSuccessState extends SocialStates {}

class LikePostErrorState extends SocialStates {
  final error;
  LikePostErrorState(this.error);
}

class CommentPostSuccessState extends SocialStates {}

class CommentPostErrorState extends SocialStates {
  final error;
  CommentPostErrorState(this.error);
}

class UserUpdateDataLoadingState extends SocialStates {}

class UserUpdateDataSuccessState extends SocialStates {}

class UserUpdateDataErrorState extends SocialStates {}

class CreatePostLoadingState extends SocialStates {}

class CreatePostSuccessState extends SocialStates {}

class CreatePostErrorState extends SocialStates {}

class GetPostImageSuccessState extends SocialStates {}

class GetPostImageErrorState extends SocialStates {}

class RemovePostImageState extends SocialStates {}

class GetMessageSuccessState extends SocialStates {}

class GetMessageErrorState extends SocialStates {}

class SendMessageSuccessState extends SocialStates {}

class SendMessageErrorState extends SocialStates {}
