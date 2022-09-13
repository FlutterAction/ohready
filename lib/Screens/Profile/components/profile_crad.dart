import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:secure_hops/Modals/Customer%20Profile/CustomerProfile.dart';
import 'package:secure_hops/Screens/Home/Resturant/Resturant%20Profile/Resturant%20Menu%20List/Items%20List/ItemDetailScreens/itemTest.dart';
import 'package:secure_hops/Screens/Profile/Pages/Edit%20Profile/Profile_Edit_Page.dart';
import 'package:secure_hops/Widgets/navigator.dart';
import 'package:secure_hops/Components/constants.dart';

class ProfileCard extends StatefulWidget {
  final CustomerProfile? profile;
  ProfileCard({@required this.profile});
  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  String? sample = "Add Name";
  @override
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
      clipBehavior: Clip.antiAlias,
      color: Colors.white,
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            profile(name: getName(), email: getEmail()),
            IconButton(
                onPressed: () {
                  if(widget.profile != null)
                  rootPush(
                      context,
                      ProfileEditPage(
                        profile: widget.profile,
                      ));
                  else
                    snackBarAlert(context, "Please, Login First");
                },
                icon: FaIcon(
                  FontAwesomeIcons.edit,
                  color: Colors.grey,
                ))
          ],
        ),
      ),
    );
  }

  profile({@required String? name, String? email}) {
    return Expanded(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: widget.profile != null
              ? NetworkImage(
                  widget.profile!.profilePicturePath ?? demoAvatar,
                )
              : NetworkImage(demoAvatar),
          radius: 30,
        ),
        title: Text(
          name.toString(),
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          email.toString(),
        ),
      ),
    );
  }

  String getName() {
    if (widget.profile != null) {
      return widget.profile!.firstName != null &&
              widget.profile!.firstName != ""
          ? widget.profile!.firstName! + widget.profile!.lastName!
          : "Your Name";
    }
    return "Your Name";
  }

  String getEmail() {
    if (widget.profile != null) {
      return widget.profile!.email!;
    }
    return "user@example.com";
  }
}
