import 'package:flutter/material.dart';
import 'package:secure_hops/API/API_Manager.dart';
import 'package:secure_hops/Components/constants.dart';
import 'package:secure_hops/Modals/Cuisine/Cuisine.dart';
import 'package:secure_hops/Widgets/ErrorWidget.dart';

class CusineGrid extends StatefulWidget {
  @override
  State<CusineGrid> createState() => _CusineGridState();
}

class _CusineGridState extends State<CusineGrid> {
  Future<List<Cuisine>>? cuisineListFuture;
  @override
  void initState() {
    getCuisineList();
    super.initState();
  }

  getCuisineList() {
    setState(() {
      cuisineListFuture = APIManager().getCuisine(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10,left: 5,right: 5),
      height: 90,
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
              return CusineCard(
                cuisine: snapshot.data![index],
              );
            },
          );
        },
      ),
    );
  }
}

class CusineCard extends StatefulWidget {
  final Cuisine? cuisine;
  final Cuisine? selectedCusine;
  const CusineCard({@required this.cuisine,@required this.selectedCusine});

  @override
  State<CusineCard> createState() => _CusineCardState();
}

class _CusineCardState extends State<CusineCard> {
  // var selectedCusine;

  // List selectedFoodType = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border:  widget.selectedCusine == widget.cuisine ? Border.all(color: kPrimaryColor,width: 3): Border.all(color: Colors.white)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            height: 60,
            width: 60,
            child: widget.cuisine!.imagePath != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network("${widget.cuisine!.imagePath}",
                        fit: BoxFit.cover),
                  )
                : Icon(Icons.image_outlined),
          ),
          SizedBox(height: 5),
          Text(
            '${widget.cuisine!.cuisineName}',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 10),
          )
        ],
      ),
    );
  }
}
