import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                )
              ],
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => buildPostItem(context),
            separatorBuilder: (context, index) => SizedBox(
              height: 8.0,
            ),
            itemCount: 10,
          ),
          SizedBox(
            height: 8.0,
          ),
        ],
      ),
    );
  }
}

Widget buildPostItem(context) => Card(
      elevation: 5.0,
      margin: EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 28.0,
                  backgroundImage: NetworkImage(
                      'https://image.freepik.com/free-photo/praying-male-begging-bearded-guy-with-blond-hairstyle-wearing-green-t-shirt-has-tattoos-holds-palms-together-plead-isolated-yellow-wall_295783-14320.jpg'),
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
                            'Taha Darwish',
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
                        DateTime.now().toString(),
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
              height: 10.0,
            ),
            Container(
              height: 1.0,
              width: double.infinity,
              color: Colors.grey,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Container(
              width: double.infinity,
              height: 20.0,
              child: Wrap(
                children: [
                  Container(
                    height: 25,
                    child: MaterialButton(
                      minWidth: 1,
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      child: Text(
                        '#flutter',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              color: Colors.blue,
                            ),
                      ),
                    ),
                  ),
                  Container(
                    height: 25,
                    child: MaterialButton(
                      onPressed: () {},
                      child: Text(
                        '#flutter',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              color: Colors.blue,
                            ),
                      ),
                      minWidth: 1,
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              height: 160.0,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                image: DecorationImage(
                  image: NetworkImage(
                    'https://image.freepik.com/free-photo/surprised-excited-young-bearded-man-plaid-shirt-with-opened-mouth-shouting-pointing-up-sky-with-both-hands-yellow-wall_295783-14364.jpg',
                  ),
                  fit: BoxFit.cover,
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
                              '1200',
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
                              '120 comment',
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
              color: Colors.grey,
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 18.0,
                          backgroundImage: NetworkImage(
                              'https://image.freepik.com/free-photo/praying-male-begging-bearded-guy-with-blond-hairstyle-wearing-green-t-shirt-has-tattoos-holds-palms-together-plead-isolated-yellow-wall_295783-14320.jpg'),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          'Write a comment ...',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
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
