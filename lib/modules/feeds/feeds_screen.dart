import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  FeedsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).posts.isNotEmpty,
          builder: (context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  elevation: 10.0,
                  margin: EdgeInsets.all(8.0),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Image(
                        height: 200.0,
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          'https://image.freepik.com/free-photo/inspired-young-man-denim-shirt-asks-pay-attention-something-very-interesting_295783-1218.jpg',
                        ),
                        width: double.infinity,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Communicate with your friends',
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => buildPostItem(
                      SocialCubit.get(context).posts[index], context, index),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 8.0,
                  ),
                  itemCount: SocialCubit.get(context).posts.length,
                ),
                SizedBox(
                  height: 8.0,
                ),
              ],
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

var commentController = TextEditingController();

Widget buildPostItem(PostModel model, context, index) => Card(
      elevation: 5.0,
      margin: EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 28.0,
                  backgroundImage: NetworkImage('${model.image}'),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${model.name}',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Icon(
                            Icons.check_circle,
                            color: Colors.blue,
                            size: 18.0,
                          ),
                        ],
                      ),
                      Text(
                        model.dateTime.toString(),
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.more_horiz,
                    size: 16.0,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              '${model.text}',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            // Container(
            //   width: double.infinity,
            //   height: 20.0,
            //   child: Wrap(
            //     children: [
            //       Container(
            //         height: 25,
            //         child: MaterialButton(
            //           minWidth: 1,
            //           padding: EdgeInsets.zero,
            //           onPressed: () {},
            //           child: Text(
            //             '#flutter',
            //             style: Theme.of(context).textTheme.caption!.copyWith(
            //                   color: Colors.blue,
            //                 ),
            //           ),
            //         ),
            //       ),
            //       Container(
            //         height: 25,
            //         child: MaterialButton(
            //           onPressed: () {},
            //           child: Text(
            //             '#flutter',
            //             style: Theme.of(context).textTheme.caption!.copyWith(
            //                   color: Colors.blue,
            //                 ),
            //           ),
            //           minWidth: 1,
            //           padding: EdgeInsets.zero,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            if (model.postImage != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  height: 160.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    image: DecorationImage(
                      image: NetworkImage(
                        '${model.postImage}',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 7.0),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5.0,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              IconBroken.Heart,
                              size: 18.0,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              '${SocialCubit.get(context).likes[index]}',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              IconBroken.Chat,
                              size: 18.0,
                              color: defaultColor,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              '0',
                              style: Theme.of(context).textTheme.caption,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              'comment',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 1.0,
              width: double.infinity,
              color: Colors.grey[300],
            ),
            SizedBox(
              height: 5.0,
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18.0,
                        backgroundImage: NetworkImage(
                            '${SocialCubit.get(context).userModel!.image}'),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: commentController,
                          onFieldSubmitted: (value) {
                            SocialCubit.get(context).commentPost(
                                SocialCubit.get(context).postsId[index],
                                commentController.text);
                            commentController.clear();
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Write a comment ...',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    SocialCubit.get(context)
                        .likePost(SocialCubit.get(context).postsId[index]);
                  },
                  child: Row(
                    children: [
                      Icon(
                        IconBroken.Heart,
                        size: 18.0,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        'Like',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
