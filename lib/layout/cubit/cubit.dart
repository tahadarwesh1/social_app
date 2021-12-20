import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chats/chat_screen.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/modules/new_post/new_post_screen.dart';
import 'package:social_app/modules/settings/settings_screen.dart';
import 'package:social_app/modules/users/users_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/constants.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    FeedsScreen(),
    ChatScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];
  List<String> titles = [
    'News Feeds',
    'Chats',
    'Post',
    'Users',
    'Settings',
  ];

  void changeBottomNavBar(index) {
    if (index == 1) {
      getAllUsers();
    }
    if (index == 2) {
      emit(AddNewPostState());
    } else {
      currentIndex = index;
      emit(SocialBottomNavState());
    }
  }

  UserModel? userModel;

  Future getUserData() async {
    emit(GetUserDataLoadingState());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
      userModel = UserModel.fromJson(value.data());
      print(value.data());
      emit(GetUserDataSuccessState());
    }).catchError((error) {
      print(error.toString());

      emit(GetUserDataErrorState(error.toString()));
    });
  }

  void updateUserData({
    required String name,
    required String phone,
    required String bio,
    String? image,
    String? cover,
  }) {
    // if (profileImage != null) {
    //   uploadProfileImage(
    //     name: name,
    //     phone: phone,
    //     bio: bio,
    //   );
    // } else if (coverImage != null) {
    //   uploadCoverImage(
    //     name: name,
    //     phone: phone,
    //     bio: bio,
    //   );
    // } else {
    UserModel model = UserModel(
      name: name,
      phone: phone,
      bio: bio,
      image: image ?? userModel!.image,
      cover: cover ?? userModel!.cover,
      email: userModel!.email,
      uId: userModel!.uId,
      isVirified: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
      // emit(UserUpdateDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(UserUpdateDataErrorState());
    });
  }

  File? profileImage;
  var picker = ImagePicker();

  Future getProfileImage() async {
    XFile? PickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (PickedImage != null) {
      profileImage = File(PickedImage.path);

      emit(GetProfileImageSuccessState());
    } else {
      print('No Image Selected!');

      emit(GetProfileImageErrorState());
    }
  }

  File? coverImage;

  Future getCoverImage() async {
    XFile? PickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (PickedImage != null) {
      coverImage = File(PickedImage.path);

      emit(GetCoverImageSuccessState());
    } else {
      print('No Image Selected!');

      emit(GetCoverImageErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(UserUpdateDataLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
            'users/profile images/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUserData(
          name: name,
          phone: phone,
          bio: bio,
          image: value,
        );
      }).catchError((error) {
        emit(UploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(UploadProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(UserUpdateDataLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
            'users/cover images/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUserData(
          name: name,
          phone: phone,
          bio: bio,
          cover: value,
        );
      }).catchError((error) {
        emit(UploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(UploadCoverImageErrorState());
    });
  }

  File? postImage;

  Future getPostImage() async {
    XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      postImage = File(pickedImage.path);

      emit(GetPostImageSuccessState());
    } else {
      print('No Image Selected!');

      emit(GetPostImageSuccessState());
    }
  }

  removePostImage() {
    postImage = null;
    emit(RemovePostImageState());
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(CreatePostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(
          dateTime: dateTime,
          text: text,
          postImage: value,
        );
      }).catchError((error) {
        emit(CreatePostErrorState());
      });
    }).catchError((error) {
      emit(CreatePostErrorState());
    });
  }

  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  }) {
    emit(CreatePostLoadingState());

    PostModel model = PostModel(
      name: userModel!.name,
      image: userModel!.image,
      uId: userModel!.uId,
      dateTime: dateTime,
      postImage: postImage,
      text: text,
    );

    FirebaseFirestore.instance.collection('posts').add(model.toMap()).then(
      (value) {
        emit(CreatePostSuccessState());
      },
    ).catchError((error) {
      print(error.toString());
      emit(CreatePostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  List<int> comments = [];

  PostModel? postModel;
  void getPosts() {
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      event.docs.forEach((element) {
        posts = [];
        likes = [];
        comments = [];
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          posts.add(PostModel.fromJson(element.data()));

          postsId.add(element.id);
          emit(GetLikePostSuccessState());
        }).catchError((error) {});
      });

      emit(GetPostsSuccessState());
    });
  }

  void getcomments() {
    FirebaseFirestore.instance.collection('posts').get().then(
      (value) {
        value.docs.forEach((element) {
          element.reference.collection('comments').get().then((value) {
            emit(GetCommentPostSuccessState());
          }).catchError((error) {});
        });

        emit(GetPostsSuccessState());
      },
    ).catchError((error) {
      emit(GetPostsErrorState(error.toString()));
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({
      'like': true,
    }).then((value) {
      emit(LikePostSuccessState());
    }).catchError((error) {
      emit(LikePostErrorState(error.toString()));
    });
  }

  void getLikePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .get()
        .then((value) {})
        .catchError((error) {});
  }

  void commentPost(String postId, String commentText) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(userModel!.uId)
        .set({
      'comment': commentText,
    }).then((value) {
      emit(CommentPostSuccessState());
    }).catchError((error) {
      emit(CommentPostErrorState(error.toString()));
    });
  }

  List<UserModel> users = [];

  getAllUsers() {
    if (users.isEmpty) {
      FirebaseFirestore.instance.collection('users').get().then(
        (value) {
          value.docs.forEach((element) {
            if (element.data()['uId'] != userModel!.uId) {
              users.add(UserModel.fromJson(element.data()));
            }
          });

          emit(GetAllUsersDataSuccessState());
        },
      ).catchError((error) {
        emit(GetAllUsersDataErrorState(error.toString()));
      });
    }
  }

  sendMessage({
    required String recieverId,
    required String dateTime,
    required String text,
  }) {
    MessageModel messageModel = MessageModel(
      text: text,
      dateTime: dateTime,
      recieverId: recieverId,
      senderId: userModel!.uId,
    );


    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(recieverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(recieverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];
  getMessages({
    required String recieverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(recieverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(
          MessageModel.fromJson(element.data()),
        );
      });
      emit(GetMessageSuccessState());
    });
  }
}

