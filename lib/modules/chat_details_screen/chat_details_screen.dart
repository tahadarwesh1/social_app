import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/constants.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {
  ChatDetailsScreen({
    required this.userModel,
  });
  UserModel userModel;

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        SocialCubit.get(context).getMessages(recieverId: userModel.uId!);
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (BuildContext context, state) {},
          builder: (BuildContext context, Object? state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(
                        '${userModel.image}',
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      userModel.name!.toTitleCase(),
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          var message =
                              SocialCubit.get(context).messages[index];
                          if (SocialCubit.get(context).userModel!.uId ==
                              message.senderId)
                            return buildMyMessagesItem(message);
                          return buildMessagesItem(message);
                        },
                        separatorBuilder: (context, index) => SizedBox(
                          height: 10.0,
                        ),
                        itemCount: SocialCubit.get(context).messages.length,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15.0,
                              ),
                              child: TextFormField(
                                controller: messageController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Write your messege here ...',
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 50.0,
                            color: defaultColor,
                            child: MaterialButton(
                              onPressed: () {
                                SocialCubit.get(context).sendMessage(
                                  recieverId: (userModel.uId)!,
                                  dateTime: DateTime.now().toString(),
                                  text: messageController.text,
                                );
                                messageController.clear();
                              },
                              minWidth: 1.0,
                              child: Icon(
                                IconBroken.Send,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

//other user messages
Widget buildMessagesItem(MessageModel messageModel) => Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(.4),
          borderRadius: BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
            topStart: Radius.circular(10.0),
          ),
        ),
        child: Text(
          messageModel.text!,
        ),
      ),
    );

Widget buildMyMessagesItem(MessageModel messageModel) => Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: defaultColor.withOpacity(.4),
          borderRadius: BorderRadiusDirectional.only(
            bottomStart: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
            topStart: Radius.circular(10.0),
          ),
        ),
        child: Text(
          messageModel.text!,
        ),
      ),
    );
