import 'package:flutter/material.dart';
import 'package:secure_hops/API/API_Manager.dart';
import 'package:secure_hops/Components/constants.dart';
import 'package:secure_hops/Modals/Cuisine/Cuisine.dart';
import 'package:secure_hops/Modals/Cuisine/Food%20Type/food_type_model.dart';
import 'package:secure_hops/Widgets/ErrorWidget.dart';

class GetFoodTypeGrid extends StatefulWidget {
  @override
  State<GetFoodTypeGrid> createState() => _GetFoodTypGrideState();
}

class _GetFoodTypGrideState extends State<GetFoodTypeGrid> {
  Future<List<FoodTypeModel>>? foodTypeListFuture;
  @override
  void initState() {
    getFoodTypeList();
    super.initState();
  }

  getFoodTypeList() {
    setState(() {
      foodTypeListFuture = APIManager().getFoodType(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10,left: 5,right: 5),
      height: 90,
      child: FutureBuilder<List<FoodTypeModel>>(
        future: foodTypeListFuture,
        builder: (BuildContext context, AsyncSnapshot<List<FoodTypeModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: Container(
                  width: 25, height: 25, child: CircularProgressIndicator()),
            );
          if (snapshot.data == null || snapshot.hasError)
            return ServerError(
              onPressed: () {
                getFoodTypeList();
              },
              text: 'Network Error. Try Again',
            );
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return FoodTypeCardGrid(
                foodType: snapshot.data![index],
              );
            },
          );
        },
      ),
    );
  }
}

class FoodTypeCardGrid extends StatelessWidget {
  final FoodTypeModel? foodType;
  final FoodTypeModel? selectedFoodType;
  const FoodTypeCardGrid({@required this.foodType,@required this.selectedFoodType});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border:  selectedFoodType == foodType ? Border.all(color: kPrimaryColor,width: 3): Border.all(color: Colors.white)
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
            child: foodType!.imagePath != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network("${foodType!.imagePath}",
                        fit: BoxFit.cover),
                  )
                : Icon(Icons.image_outlined),
          ),
          SizedBox(height: 5),
          Text(
            '${foodType!.foodTypeName}',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 10),
          )
        ],
      ),
    );
  }
}
