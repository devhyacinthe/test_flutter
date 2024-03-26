import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:random_user/src/configurations/assets/assets.dart';
import 'package:random_user/src/features/users/widgets/edit_user.dart';
import 'package:random_user/src/models/user.dart';

class UserCard extends ConsumerStatefulWidget {
  final User? user;
  const UserCard({super.key, required this.user});

  @override
  ConsumerState<UserCard> createState() => _MyWidgetState();
}

class _MyWidgetState extends ConsumerState<UserCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
            height: 100,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width / 3.5,
                  margin: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(12)),
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
                Container(
                    width: MediaQuery.of(context).size.width / 2.5,
                    margin: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width / 15),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 7, top: 15),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                '${widget.user!.firstName} ${widget.user!.lastName}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.titleLarge),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                                "📍 ${widget.user!.street}, ${widget.user!.city}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.labelLarge),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(widget.user!.email!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.labelLarge)
                          ]),
                    )),
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25))),
                          builder: (context) => EditUserBottomSheet(
                                user: widget.user!,
                              ));
                    },
                    icon: SvgPicture.asset(
                      IconAssets.edit,
                      color: Theme.of(context).colorScheme.secondary,
                      width: 25,
                      height: 25,
                    ),
                  ),
                ),
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
