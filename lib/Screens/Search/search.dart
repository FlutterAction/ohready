import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secure_hops/API/API_Manager.dart';
import 'package:secure_hops/Components/constants.dart';
import 'package:secure_hops/Components/size_config.dart';
import 'package:secure_hops/Modals/Resturants/Search%20Resturant.dart';
import 'package:secure_hops/Provider/MyProvider.dart';
import 'package:secure_hops/Screens/Home/Resturant/Resturant%20Card/Resturant%20Card.dart';
import 'package:secure_hops/Shared%20Preferences/share_preferences.dart';
import 'package:secure_hops/Widgets/ErrorWidget.dart';
import 'package:secure_hops/Widgets/Google%20Maps/Google%20Maps.dart';
import 'package:secure_hops/Widgets/navigator.dart';
import 'Filter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Search extends StatefulWidget {
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Future<ResturantList>? futureResturantList;
  List<Resturant>? resturantList;
  LatLng? currentPosition;
  var currentLocation;
  bool isLoad = true;

  @override
  void initState() {
    _getCurrentLocation();
    getResturants();
    super.initState();
  }

  getResturants() {
    
    setState(() {
      futureResturantList = APIManager().searchResturant(
        context,
        cusineCode: APIManager.cusineCode!,
        foodtypeCode: APIManager.foodTypeCode!
      );
      APIManager.cusineCode = -1;
      APIManager.foodTypeCode = -1;
    });
  }

  _getCurrentLocation() async {
    var lat = await SavedSharePreference().getPositionLat();
    var lon = await SavedSharePreference().getPositionLon();
  if(lat != null && lon != null)
    currentPosition = LatLng(lat, lon);
    currentLocation = await SavedSharePreference().getAddressLocation();
    setState(() {
      isLoad = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(builder: (context, provider, child) {
      return Scaffold(
       
        backgroundColor: kBackgroundColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                locationBox(provider),
                SizedBox(height: 10),
                searchBar(context),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    "Restaurants Nearby",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: resturantsList(),
                ),
              ],
            ),
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

          if (snapshot.data == null)
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
              mainAxisSpacing: 15,
              crossAxisSpacing: 10,
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

  locationBox(MyProvider provider) {
    return InkWell(
      onTap: isLoad
          ? null
          : () {
              push(
                  context,
                  MyGoogleMaps(
                    onPressed: () async {
                      pop(context);
                      await getResturants();
                    },
                    currentPosition: currentPosition,
                    buttonText: 'Get Resturants',
                  ));
            },
      child: Container(
        height: getProportionateScreenHeight(50),
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: kWhiteColor, borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Icon(
              Icons.place_outlined,
              color: isLoad ? Colors.black54 : kPrimaryColor,
            ),
            SizedBox(
              width: 8,
            ),
            Container(
              width: getProportionateScreenWidth(255),
              child: Text(
                provider.selectedPlace != null
                    ? provider.selectedPlace!.formattedAddress
                        .toString() ///////////////////////////////////////////
                    : currentLocation != null
                        ? "$currentLocation"
                        : "Choose Address",
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Spacer(),
            Icon(Icons.map)
          ],
        ),
      ),
    );
  }

  searchBar(BuildContext context) {
    return TextFormField(      
      onFieldSubmitted: (value) {
        if (value.isNotEmpty) {
          getResturants();
        }else{
           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Type Something!"),
                duration: Duration(milliseconds: 300),
              ));
        }
      },
      decoration: InputDecoration(
          hintText: 'Search for dish...',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Icon(Icons.search),
          suffixIcon: IconButton(
            icon: Icon(Icons.filter_alt_outlined),
            onPressed: () {
              rootPush(context, Filter());
            },
          )),
    );
  }
}




// searchRestaurant(string email, string pass, string lat, string lng, string srchTxt = "", int foodTypeCode = -1, int cuisineCode = -1)