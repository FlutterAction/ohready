import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secure_hops/API/API_Manager.dart';
import 'package:secure_hops/Modals/Cuisine/Cuisine.dart';
import 'package:secure_hops/Modals/Cuisine/Food%20Type/food_type_model.dart';
import 'package:secure_hops/Modals/Resturants/Search%20Resturant.dart';
import 'package:secure_hops/Provider/MyProvider.dart';
import 'package:secure_hops/Screens/Home%20Page/Empty%20Home/EmptyHome.dart';
import 'package:secure_hops/Screens/Home%20Page/home.dart';
import 'package:secure_hops/Screens/Home/components/Categories.dart';
import 'package:secure_hops/Screens/Home/components/food_type.dart';
import 'package:secure_hops/Screens/Onboarding/OnBoarding.dart';
import 'package:secure_hops/Screens/Search/Tabs/ApplyFilter/cusineGrid.dart';
import 'package:secure_hops/Screens/Search/Tabs/ApplyFilter/foodTypeFilter.dart';
import 'package:secure_hops/Screens/Search/search.dart';
import 'package:secure_hops/Widgets/AppBar.dart';
import 'package:secure_hops/Widgets/button.dart';
import 'package:secure_hops/Widgets/navigator.dart';
import 'package:secure_hops/Components/constants.dart';

import 'Tabs/ApplyFilter/ApplyFilter.dart';

class Filter extends StatefulWidget {
  const Filter({Key? key}) : super(key: key);

  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  bool isChecked = false;

  @override
  void initState() {
    getCuisineList();
    getFoodTypeList();
    super.initState();
  }

  searchBar(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: (value) {
        if (value.isNotEmpty) {

          getResturants();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Type Something!"),
            duration: Duration(milliseconds: 600),
          ));
        }
      },
      decoration: InputDecoration(
        hintText: 'Search for dish...',
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: kPrimaryColor),
        ),
        prefixIcon: Icon(Icons.search),
      ),
    );
  }

  List<Cuisine>? cusineList = [];
  List<FoodTypeModel>? foodTypeList = [];
  Future<ResturantList>? futureResturantList;

  getCuisineList() {
    APIManager().getCuisine(context).then((value) {
      setState(() {
        cusineList = value;
      });
    });
  }

  getFoodTypeList() {
    APIManager().getFoodType(context).then((value) {
      setState(() {
        foodTypeList = value;
      });
    });
  }

  getResturants() {
    setState(() {
      futureResturantList = APIManager().searchResturant(
        context,
      );
    });
  }



Cuisine? selectedCusine;
FoodTypeModel? selectedFoodType;


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(


      bottomNavigationBar:  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Consumer<MyProvider>(
                  builder: (context, provider, child){
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: MyButton(
                      onPressed: () {                      
                        if(selectedCusine != null)
                        APIManager.cusineCode = selectedCusine!.cuisineCode;                      
                        else if(selectedFoodType != null)
                        APIManager.foodTypeCode = selectedFoodType!.foodTypeCode;
                        screenIndex = 1;                        
                        pushAndRemoveUntil(context, provider.loginResponse != null ? MyHomePage(): AppHomePage());
                      },
                      text: "APPLY",
                    ),
                  );
                  },),
              ),   
      appBar: appBar(context, title: "Filter"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              searchBar(context),
              SizedBox(
                height: 40,
              ),
              Text(
                "Cuisines",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              cusineList!.isEmpty
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 1.0,
                        childAspectRatio: 0.9,
                        mainAxisSpacing: 1.0,
                      ),
                      itemCount: cusineList!.isEmpty ? 0 : cusineList!.length,
                      itemBuilder: (context, i) {
                        // return Container();
                        return InkWell(
                          onTap: (){
                            var tempSelect = cusineList![i];
                             setState(() {
                               if(selectedCusine == tempSelect)
                               selectedCusine = null ;
                               else
                               selectedCusine = cusineList![i];
                             });                             
                          },
                          child: CusineCard(
                            cuisine: cusineList![i],
                             selectedCusine: selectedCusine
                          ),
                        );
                      },
                    ),
                       SizedBox(
                height: 40,
              ),
              Text(
                "Food Type",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              foodTypeList!.isEmpty
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                        crossAxisSpacing: 1.0,
                        childAspectRatio: 0.9,
                        mainAxisSpacing: 1.0,
                      ),
                      itemCount:
                          foodTypeList!.isEmpty ? 0 : foodTypeList!.length,
                      itemBuilder: (context, i) {
                        // return Container();
                        return InkWell(
                          onTap: (){
                           var tempSelect = foodTypeList![i];
                             setState(() {
                               if(selectedFoodType == tempSelect)
                               selectedFoodType = null ;
                               else
                               selectedFoodType = foodTypeList![i];
                             });                 
                          },
                          child: FoodTypeCardGrid(
                            foodType: foodTypeList![i],
                            selectedFoodType:selectedFoodType,
                          ),
                        );
                      },
                    ),
            
            ],
          ),
        ),
      ),
    );
  }

//     Widget getHomePage(MyProvider provider,{int? index}) {
//     print(provider.isFirstTime);
//     if (provider.loginResponse != null) {
//       print(1);
//       return MyHomePage(index);
//     }
//     else{
//       print(2);
//       return AppHomePage(index);
//     } 
// }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return primaryColor;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
      },
    );
  }
}
