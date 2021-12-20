import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class NewPostScreen extends StatelessWidget {
  NewPostScreen({Key? key}) : super(key: key);
  var postController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, state) {
        if (state is CreatePostSuccessState) {
          navigateTo(context, FeedsScreen());
        }
      },
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Create Post',
            actions: [
              defaultTextButton(
                title: 'POST',
                onPressed: () {
                  var dateTime = DateTime.now();
                  if (SocialCubit.get(context).postImage == null) {
                    SocialCubit.get(context).createPost(
                      dateTime: dateTime.toString(),
                      text: postController.text,
                    );
                  } else {
                    SocialCubit.get(context).uploadPostImage(
                      dateTime: dateTime.toString(),
                      text: postController.text,
                    );
                  }
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is CreatePostLoadingState) LinearProgressIndicator(),
                if (state is CreatePostLoadingState)
                  SizedBox(
                    height: 10.0,
                  ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 28.0,
                      backgroundImage: NetworkImage(
                          '${SocialCubit.get(context).userModel!.image}'),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Text(
                        '${SocialCubit.get(context).userModel!.name}',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: postController,
                    decoration: InputDecoration(
                      hintText: 'What is on your mind '
                          '${SocialCubit.get(context).userModel!.name}'
                          ' ?',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if (SocialCubit.get(context).postImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 150.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          image: DecorationImage(
                            image:
                                FileImage(SocialCubit.get(context).postImage!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          SocialCubit.get(context).removePostImage();
                        },
                        icon: CircleAvatar(
                          child: Icon(
                            Icons.close,
                            size: 18.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                if (SocialCubit.get(context).postImage != null)
                  SizedBox(
                    height: 20,
                  ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          SocialCubit.get(context).getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              IconBroken.Image,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              'Add Photos',
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          '# tags',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
