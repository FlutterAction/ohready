import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secure_hops/API/API_Manager.dart';
import 'package:secure_hops/Components/constants.dart';
import 'package:secure_hops/Modals/Cuisine/Cuisine.dart';
import 'package:secure_hops/Provider/MyProvider.dart';
import 'package:secure_hops/Screens/Home%20Page/Empty%20Home/EmptyHome.dart';
import 'package:secure_hops/Screens/Home%20Page/home.dart';
import 'package:secure_hops/Widgets/ErrorWidget.dart';

class Categories extends StatefulWidget {
  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  Future<List<Cuisine>>? cuisineListFuture;
  @override
  void initState() {
    if (APIManager.cuisineList == null) {
      getCuisineList();
    }else{
      cuisineListFuture = APIManager.cuisineList;
    }

    super.initState();
  }

  getCuisineList() {
    setState(() {
      cuisineListFuture = APIManager().getCuisine(context);
      APIManager.cuisineList = cuisineListFuture;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      height: 110,
      child: FutureBuilder<List<Cuisine>>(
        future: cuisineListFuture,
        builder: (BuildContext context, AsyncSnapshot<List<Cuisine>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: Container(
                  width: 25, height: 25, child: CircularProgressIndicator()),
            );
          if (snapshot.data == null || snapshot.hasError)
            return ServerError(
              onPressed: () {
                getCuisineList();
              },
              text: 'Network Error. Try Again',
            );
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Categorycard(
                cuisine: snapshot.data![index],
              );
            },
          );
        },
      ),
    );
  }
}

class Categorycard extends StatelessWidget {
  final Cuisine? cuisine;
  const Categorycard({@required this.cuisine});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        MyProvider provider = Provider.of<MyProvider>(context, listen: false);
        APIManager.cusineCode = cuisine!.cuisineCode;
        screenIndex = 1;
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (_) => provider.loginResponse != null
                    ? MyHomePage()
                    : AppHomePage()),
            (route) => false);
      },
      child: Padding(
        padding: EdgeInsets.only(right: 10),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              height: 80,
              width: 80,
              child: cuisine!.imagePath != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network("${cuisine!.imagePath}",
                          fit: BoxFit.cover),
                    )
                  : Icon(Icons.image_outlined),
            ),
            SizedBox(height: 5),
            Text(
              '${cuisine!.cuisineName}',
              style: TextStyle(fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}
