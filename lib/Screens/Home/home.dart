import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secure_hops/API/API_Manager.dart';
import 'package:secure_hops/Components/size_config.dart';
import 'package:secure_hops/Modals/Resturants/Search%20Resturant.dart';
import 'package:secure_hops/Provider/MyProvider.dart';
import 'package:secure_hops/Screens/Home/components/Categories.dart';
import 'package:secure_hops/Shared%20Preferences/share_preferences.dart';
import 'package:secure_hops/Widgets/ErrorWidget.dart';
import 'package:secure_hops/Widgets/Google%20Maps/Google%20Maps.dart';
import 'package:secure_hops/Widgets/navigator.dart';
import '../../Components/constants.dart';
import 'Resturant/Resturant Card/Resturant Card.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as locations;
import 'components/food_type.dart';
// import 'package:permission_handler/permission_handler.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<ResturantList>? futureResturantList;
  List<Resturant>? resturantList;
  // LatLng? currentPosition;
  // var currentLocation;
  // bool isLoad = true;

  @override
  void initState() {
    // initFun();
    // getLocationInDB();
    getLocationInfo();
    getResturants();
    super.initState();
  }

  getResturants() {
    setState(() {
      futureResturantList = APIManager().searchResturant(
        context,
      );
    });
  }

var lat,lon,address;

bool gettingAddress = false;

  getLocationInfo()async{

    setState(() {
      gettingAddress = true;
    });

   lat =  await SavedSharePreference().getPositionLat();
   lon = await SavedSharePreference().getPositionLon();
    address = await SavedSharePreference().getAddressLocation();
    setState(() {
      gettingAddress = false;
    });

  }

    @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    
    return Scaffold(    
      // floatingActionButton: (){
        
      // },
        backgroundColor: kBackgroundColor,
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Consumer<MyProvider>(builder: (context, provider, child) {
            print(provider.savedCurrentPosition);
            return SingleChildScrollView(
              child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    head(),
                    heading("Browse by Cusines"),
                    Categories(),
                    heading("Browse by Food Types"),
                    GetFoodType(),
                    address == null
                        ? Center(
                            child: Container(
                              // margin: EdgeInsets.symmetric(vertical: 20),
                              height: 200,
                              width: MediaQuery.of(context).size.width - 50.0,
                              decoration: BoxDecoration(
                                  color: Colors.red[100],
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.location_off_sharp,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    "NO LOCATION!",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                  MaterialButton(
                                    onPressed: () {
                                      push(
                                          context,
                                          MyGoogleMaps(
                                            onPressed: () async {
                                              pop(context);
                                              await getResturants();
                                            },
                                            currentPosition: provider
                                                        .savedCurrentPosition ==
                                                    null
                                                ? LatLng(40.4637, 3.7492)
                                                : provider.savedCurrentPosition,
                                            buttonText: 'Get Resturants',
                                          ));

                                      // setState(() {
                                      //   isLoad = false;
                                      // });
                                    },
                                    child: Text("OPEN LOCATION"),
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container(),
                  ]),
            );
          }),
        ));
  }

  heading(text) {
    return Container(
        padding: EdgeInsets.all(10),
        child: Text(
          text,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ));
  }

  head() {
    return Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight! * .160,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/img.png'), fit: BoxFit.cover),
      ),
      child: deliveryCard(),
    );
  }

  // body(BuildContext context) {
  //   return Padding(
  //         padding: EdgeInsets.all(10),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Categories(),
  //       ],
  //     ),
  //   );
  // }

  deliveryCard() {
    return Consumer<MyProvider>(builder: (context, provider, child) {
      return InkWell(
        onTap: address == null
            ? null
            : () {
                push(
                    context,
                    MyGoogleMaps(
                      onPressed: () async {
                        pop(context);
                        await getResturants();
                      },
                      currentPosition: provider.savedCurrentPosition == null
                          ? LatLng(40.4637, 3.7492)
                          : provider.savedCurrentPosition,
                      buttonText: 'Get Resturants',
                    ));
              },
        child: Padding(
          padding: EdgeInsets.only(top: getProportionateScreenHeight(50)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(provider.customerProfile != null
                      ? provider.customerProfile!.profilePicturePath!
                      : demoAvatar),
                  radius: 30,
                ),
              ),
              Container(
                height: SizeConfig.screenHeight! / 9.5,
                width: SizeConfig.screenWidth! / 1.3,
                child: Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Deliver To',
                          style: TextStyle(
                              fontSize: 17,
                              color: kWhiteColor,
                              fontWeight: FontWeight.bold)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: (){
                                   push(
                                        context,
                                        MyGoogleMaps(
                                          onPressed: () async {
                                            pop(context);
                                            await getResturants();
                                          },
                                          currentPosition:
                                              provider.savedCurrentPosition,
                                          buttonText: 'Get Resturants',
                                        ));
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 5),
                              width: SizeConfig.screenWidth! / 1.7,
                              child: Text(
                                address != null ? address 
                                // provider.selectedPlace != null
                                //     ? provider.selectedPlace!.formattedAddress.toString() ///////////////////////////////////////////
                                //     : provider.savedCurrentAddress != null
                                //         ? "${provider.savedCurrentAddress}"
                                        : "Choose Address",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: kWhiteColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          gettingAddress
                              ? InkWell(
                                  // onTap: provider.savedCurrentAddress,
                                  child: Container(
                                    width: 25,
                                    height: 25,
                                    child: CircularProgressIndicator(
                                      color: kWhiteColor,
                                    ),
                                  ),
                                )
                              : Container(),
                              
                              if(address != null)
                               IconButton(
                                  onPressed: () {
                                    push(
                                        context,
                                        MyGoogleMaps(
                                          onPressed: () async {
                                            pop(context);
                                            await getResturants();
                                          },
                                          currentPosition:
                                              provider.savedCurrentPosition,
                                          buttonText: 'Get Resturants',
                                        ));
                                  },
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    color: kWhiteColor,
                                    size: 20,
                                  )),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  resturantsList() {
    return RefreshIndicator(
      onRefresh: () async {
        await getResturants();
      },
      child: FutureBuilder<ResturantList>(
        future: futureResturantList,
        builder: (BuildContext context, AsyncSnapshot<ResturantList> snapshot) {
          //show loading until data is fetching
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );

          if (snapshot.data == null || snapshot.hasError)
            return ServerError(
              onPressed: () {
                getResturants();
              },
              text: 'Network Error. Try Again',
            );

          // initialize resturant list
          resturantList = snapshot.data!.resturantList;

          //if there resturant length is 0 then there is no resturant near customer
          if (resturantList!.length < 1)
            return ServerError(
              onPressed: () {
                getResturants();
              },
              text: 'No Resturants Nearby.\nTry Again',
            );
          // else show resturant list
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.7,
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 10,
            ),
            itemCount: resturantList!.length,
            itemBuilder: (BuildContext context, int index) {
              return ResturantCard(
                resturant: resturantList![index],
              );
            },
          );
        },
      ),
    );
  }
}
