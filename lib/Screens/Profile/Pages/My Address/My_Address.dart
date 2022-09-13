import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:secure_hops/API/API_Manager.dart';
import 'package:secure_hops/Components/constants.dart';
import 'package:secure_hops/Modals/Address/Address.dart';
import 'package:secure_hops/Provider/MyProvider.dart';
import 'package:secure_hops/Screens/Profile/Pages/My%20Address/Pages/Add_new_address.dart';
import 'package:secure_hops/Screens/Profile/components/divider.dart';
import 'package:secure_hops/Shared%20Preferences/share_preferences.dart';
import 'package:secure_hops/Widgets/AppBar.dart';
import 'package:secure_hops/Widgets/button.dart';
import 'package:secure_hops/Widgets/navigator.dart';

class MyAddress extends StatefulWidget {
  @override
  State<MyAddress> createState() => _MyAddressState();
}

class _MyAddressState extends State<MyAddress> {
  MyProvider? provider;
  @override
  void initState() {
    provider = Provider.of<MyProvider>(context, listen: false);
    fetchAddress();
    super.initState();
  }
  var address;
  fetchAddress()async{
    address = await SavedSharePreference().getAddressLocation();
    setState(() {      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(      
        backgroundColor: kBackgroundColor,
        appBar: appBar(context, title: 'My Address'),
        body: showAddress(context));
  }

  showAddress(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Column(
        children: [
          getAddressList(),
          Spacer(),
          CustomDivider(),
          addAddressButton(),
        ],
      ),
    );
  }

  getAddressList() {
    return Consumer<MyProvider>(builder: (context, provider, child) {
      List<Address> addressList = provider.addressList!;
      // ignore: unnecessary_null_comparison
      return address == null
          ? Center(
              child: Text('No Address Found.'),
            )
          : 
                 Container(
                   height: 50,
                   child: InkWell(
                     onTap: () {},
                     child: Dismissible(
                         background: slideRightBackground(),
                   secondaryBackground: slideLeftBackground(),
                   confirmDismiss: (direction) async {
                     if (direction == DismissDirection.endToStart) {
                       // deleteAddress(addressList[index].addressCode.toString());
                     } else {}
                   },
                   key: Key(address),
                       child: ListTile(
                         
                         leading: FaIcon(
                                  Icons.location_pin),
                         title: Text(address),
                         // subtitle: Text(addressList[index].addressText.toString()),
                       ),
                     ),
                   ),
                 );
              });
    
  }

  addAddressButton() {
    return MyButton(
        text: 'ADD NEW ADDRESS',
        onPressed: () async {
          push(context, AddNewAddress());
        });
  }

  Widget slideRightBackground() {
    return Container(
      color: Colors.green,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.edit,
              color: Colors.white,
            ),
            Text(
              " Edit",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  Widget slideLeftBackground() {
    return Container(
      color: Colors.red,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              " Delete",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }

  deleteAddress(String addressCode) {
    APIManager().deleteAddress(context,
        username: provider!.loginResponse!.user!.userName,
        userpass: provider!.loginResponse!.password,
        addresscode: addressCode);
  }
}
