import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:random_user/src/configurations/assets/assets.dart';

import 'package:random_user/src/models/user.dart';

class UserSearchCard extends ConsumerStatefulWidget {
  final User? user;
  const UserSearchCard({super.key, required this.user});

  @override
  ConsumerState<UserSearchCard> createState() => _MyWidgetState();
}

class _MyWidgetState extends ConsumerState<UserSearchCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
            height: 70,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width / 5,
                  margin: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
                  child: CircleAvatar(
                    child: CachedNetworkImage(
                      imageUrl: widget.user!.picture!,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.fitWidth)),
                      ),
                      placeholder: (context, url) => Container(
                        alignment: Alignment.center,
                        child: SpinKitChasingDots(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      errorWidget: (context, url, error) =>
                          Image.asset(ImageAssets.placeholder),
                    ),
                  ),
                ),
                Container(
                    width: MediaQuery.of(context).size.width / 2.5,
                    margin: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width / 15),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 7, top: 4),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                '${widget.user!.firstName} ${widget.user!.lastName}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodyLarge),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                                "📍 ${widget.user!.street}, ${widget.user!.city}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.labelMedium),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(widget.user!.email!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.labelMedium)
                          ]),
                    )),
              ],
            )),
        _buildDivider()
      ],
    );
  }

  _buildDivider() {
    return Divider(
      color: Theme.of(context).colorScheme.primary,
      thickness: .05,
      indent: 15,
      endIndent: 15,
    );
  }
}
