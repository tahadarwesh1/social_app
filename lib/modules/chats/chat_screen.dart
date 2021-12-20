import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chat_details_screen/chat_details_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/constants.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).users.isNotEmpty,
          builder: (BuildContext context) => ListView.separated(
            itemBuilder: (context, index) =>
                buildChatItem(context, SocialCubit.get(context).users[index]),
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                height: 1.0,
                width: double.infinity,
                color: Colors.grey[300],
              ),
            ),
            itemCount: SocialCubit.get(context).users.length,
          ),
          fallback: (BuildContext context) =>
              Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

Widget buildChatItem(
  context,
  UserModel userModel,
) =>
    InkWell(
      onTap: () {
        navigateTo(context, ChatDetailsScreen(userModel: userModel));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28.0,
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
      ),
    );
