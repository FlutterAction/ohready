import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:secure_hops/Provider/MyProvider.dart';
import 'package:secure_hops/Screens/Authenticate/Login/Login.dart';
import 'package:secure_hops/Screens/Home/Resturant/Resturant%20Profile/Resturant%20Menu%20List/Items%20List/ItemDetailScreens/itemTest.dart';
import 'package:secure_hops/Screens/Profile/Pages/App%20Langauage/AppLanguage.dart';
import 'package:secure_hops/Screens/Profile/components/profile_crad.dart';
import 'package:secure_hops/Shared%20Preferences/share_preferences.dart';
import 'package:secure_hops/Widgets/navigator.dart';
import 'package:secure_hops/Components/constants.dart';
import 'Pages/My Address/My_Address.dart';
import 'Pages/My Favorite/My_Favorite.dart';
import 'Pages/Order History/OrderHistory.dart';
import 'components/button_tile.dart';
import 'components/divider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<MyProvider>(builder: (context, provider, child) {
      return Scaffold(
          backgroundColor: kBackgroundColor,
          body: Stack(
            children: [
              Container(
                width: size.width,
                height: size.height * .18,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/img.png'), fit: BoxFit.cover),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(left: 10,right: 10,top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          'My Profile',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(height: 10),
                      ProfileCard(
                        profile: provider.customerProfile ?? null,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                          child: ListView(
                        children: [
                          TileButton(
                            icon: FaIcon(FontAwesomeIcons.calendar),
                            onPressed: () {

                              // rootPush(context, OrderHistory());
                               if(provider.loginResponse != null){                              
                              rootPush(context, OrderHistory());
                              }else{
                                snackBarAlert(context, "Please, Login First");
                              }
                            },
                            text: 'Order History',
                          ),
                          CustomDivider(),
                          // TileButton(
                          //   icon: FaIcon(Icons.payment),
                          //   onPressed: () {
                          //     rootPush(context, PaymentMethod());
                          //   },
                          //   text: 'Payment Method',
                          // ),
                          // CustomDivider(),
                          TileButton(
                            icon: Icon(Icons.location_pin),
                            onPressed: () {
                              rootPush(context, MyAddress());
                              //  MyProvider provider = Provider.of<MyProvider>(context, listen: false);
                              // if(provider.loginResponse != null){                            
                              // }else{
                              //   snackBarAlert(context, "Please, Login First");
                              // }
                            
                              
                            },
                            text: 'My Address',
                          ),
                          CustomDivider(),
                          // TileButton(
                          //   icon: FaIcon(FontAwesomeIcons.gift),
                          //   onPressed: () async {},
                          //   text: 'My Promocodes',
                          // ),
                          // CustomDivider(),
                          TileButton(
                            icon: FaIcon(Icons.favorite_outline),
                            onPressed: () {
                              MyProvider provider = Provider.of<MyProvider>(context, listen: false);
                              if(provider.loginResponse != null){
                              rootPush(context, MyFavorite());
                              }else{
                                snackBarAlert(context, "Please, Login First");
                              }
                            },
                            text: 'My Favorite',
                          ),
                          CustomDivider(),
                          TileButton(
                            icon: FaIcon(Icons.language_outlined),
                            onPressed: () {
                              rootPush(context, AppLanguage());
                            },
                            text: 'App Language',
                          ),
                          CustomDivider(),
                          InkWell(
                            onTap: () {
                              SavedSharePreference().clearShareprefrence();
                              provider.clearValues();
                              SavedSharePreference().clearShareprefrence();
                              pushAndRemoveUntil(context, Login());
                            },
                            child: ListTile(
                              leading: FaIcon(Icons.logout),
                              title:  Text('${provider.loginResponse != null ? 'Signout' : 'Login' } '),
                            ),
                          ),
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            ],
          ));
    });
  }
}
