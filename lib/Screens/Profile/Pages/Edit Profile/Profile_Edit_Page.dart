import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secure_hops/API/API_Manager.dart';
import 'package:secure_hops/Modals/Customer%20Profile/CustomerProfile.dart';
import 'package:secure_hops/Provider/MyProvider.dart';
import 'package:secure_hops/Screens/Profile/components/changepass.dart';
import 'package:secure_hops/Shared%20Preferences/CacheManageer.dart';
import 'package:secure_hops/Widgets/AppBar.dart';
import 'package:secure_hops/Widgets/SnackBar.dart';
import 'package:secure_hops/Widgets/button.dart';
import 'package:secure_hops/Widgets/navigator.dart';
import 'package:secure_hops/Components/constants.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:secure_hops/Components/size_config.dart';

class ProfileEditPage extends StatefulWidget {
  final CustomerProfile? profile;
  ProfileEditPage({@required this.profile});
  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool? isLoading = false;
  File? file;

  String? setDate;

  String? dateofbirth;

  DateTime selectedDate = DateTime.now();

  TextEditingController _dateController = TextEditingController();
  TextEditingController? firstName, lastName, phoneNo;

  String? gender;

  InputBorder? focusedBorder = UnderlineInputBorder(
    borderSide: BorderSide(color: kPrimaryColor),
  );

  @override
  void initState() {
    defaultValues();
    super.initState();
  }

  defaultValues() {
    firstName = TextEditingController()..text = widget.profile!.firstName ?? "";
    lastName = TextEditingController()..text = widget.profile!.lastName ?? "";
    phoneNo = TextEditingController()..text = widget.profile!.mobileNo ?? "";
    gender = widget.profile!.gender ?? "";
    if (widget.profile!.dateOfBirth != null) {
      convertDate();
    }
  }

  convertDate() {
    dateofbirth = DateTime.fromMillisecondsSinceEpoch(int.parse(
            widget.profile!.dateOfBirth!.split('(').last.split(')').first))
        .toString()
        .substring(0, 10);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: appBar(context, title: 'Edit Profile'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                imageBox(),
                box(),
                Text(
                  widget.profile!.email.toString(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                firstNameFormField(),
                box(),
                lastNameFormField(),
                box(),
                phoneNoFormField(),
                box(),
                dateField(),
                box(),
                genderFormField(),
                SizedBox(height: 20),
                isLoading!
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(),
                box(),
                MyButton(
                    text: 'SAVE CHANGES',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        saveProfile();
                      }
                    }),
                box(),
                TextButton(
                  onPressed: () {
                    push(context, ChangePassword(profile: widget.profile));
                  },
                  child: Text('CHANGE PASSWORD'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  imageBox() {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey[200],
              child: ClipRRect(
                borderRadius: BorderRadius.circular(70),
                child: getImageWidget(),
              )),
          Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 4, color: Colors.white),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF7D849A),
                    ),
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                ),
                onTap: () async {
                  showImageDialog();
                },
              )),
        ],
      ),
    );
  }

  firstNameFormField() {
    return TextFormField(
        controller: firstName,
        decoration: InputDecoration(
          focusedBorder: focusedBorder,
          hintText: "Enter First Name",
          hintStyle: TextStyle(color: Colors.grey),
          labelText: "FIRST NAME",
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter first name';
          }
        });
  }

  lastNameFormField() {
    return TextFormField(
        controller: lastName,
        decoration: InputDecoration(
          focusedBorder: focusedBorder,
          hintText: "Enter Last Name",
          hintStyle: TextStyle(color: Colors.grey),
          labelText: "LAST NAME",
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter last name';
          }
        });
  }

  phoneNoFormField() {
    return TextFormField(
      controller: phoneNo,
      decoration: InputDecoration(
        focusedBorder: focusedBorder,
        hintText: "Enter phone #",
        hintStyle: TextStyle(color: Colors.grey),
        labelText: "PHONE NUMBER",
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter mobile number';
        }
      },
    );
  }

  Widget genderFormField() {
    return Container(
        width: SizeConfig.screenWidth! / 1.1,
        child: DropdownButtonFormField(
          onSaved: (value) {
            gender = value.toString();
          },
          onChanged: (String? value) {
            gender = value.toString();
          },
          decoration: InputDecoration(
            labelText: "GENDER",
            hintText: widget.profile!.gender ?? "Select gender",
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
          items: <String>['Male', 'Female', 'Other']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ));
  }

  showImageDialog() {
    return showDialog(
        context: context,
        builder: (con) {
          return AlertDialog(
              actions: [
                SimpleDialogOption(
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
              title: Text(
                "Select image from",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: Wrap(
                children: [
                  TextButton(
                    style: TextButton.styleFrom(primary: Colors.black),
                    child: Text(
                      "CAMERA",
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      capturephotowithcamera();
                    },
                  ),
                  Divider(
                    height: 2,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(primary: Colors.black),
                    child: Text(
                      "GALLERY",
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      selectfromgallery();
                    },
                  ),
                ],
              ));
        });
  }

  Widget box() {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height / 35,
    );
  }

  Widget dateField() {
    return InkWell(
      onTap: () {
        _selectDate(context);
      },
      child: Container(
        alignment: Alignment.center,
        child: TextFormField(
          textAlign: TextAlign.start,
          enabled: false,
          keyboardType: TextInputType.text,
          controller: _dateController,
          onSaved: (val) {
            setDate = val;
          },
          decoration: InputDecoration(
              suffixIcon: Icon(Icons.calendar_today_sharp),
              labelText: dateofbirth ?? 'DATE OF BIRTH',
              contentPadding: EdgeInsets.only(top: 0.0)),
        ),
      ),
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(1900),
        lastDate: DateTime(2022));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat("yyyy-dd-MM").format(selectedDate);
        dateofbirth = _dateController.text;
        print(dateofbirth);
      });
  }

  capturephotowithcamera() async {
    Navigator.pop(context);
    PickedFile? imagefile =
        // ignore: invalid_use_of_visible_for_testing_member
        await ImagePicker.platform.pickImage(source: ImageSource.camera);
    setState(() {
      file = File(imagefile!.path);
    });
  }

  selectfromgallery() async {
    Navigator.pop(context);
    PickedFile? imagefile =
        // ignore: invalid_use_of_visible_for_testing_member
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    setState(() {
      file = File(imagefile!.path);
    });
  }

  Widget getImageWidget() {
    if (file == null) {
      return Image.network(
        getImage(),
        width: 120,
        height: 120,
        fit: BoxFit.cover,
      );
    } else {
      return Image.file(
        file!,
        width: 120,
        height: 120,
        fit: BoxFit.cover,
      );
    }
  }

  String getImage() {
    if (widget.profile!.profilePicturePath == null) {
      return demoAvatar;
    } else {
      return widget.profile!.profilePicturePath!;
    }
  }

  saveProfile() {
    MyProvider provider = Provider.of<MyProvider>(context, listen: false);
    setState(() {
      isLoading = true;
    });
    return APIManager()
        .saveprofile(context,
            email: provider.loginResponse!.user!.email,
            pass: provider.loginResponse!.password,
            firstName: firstName!.text,
            lastname: lastName!.text,
            mobileno: phoneNo!.text,
            img: file,
            dob: dateofbirth,
            gender: gender)
        .then((response) {
      setState(() {
        isLoading = false;
      });
      if (response.data['result'] == "true") {
        getUser();
        CustomSnackBar.show(context, "Profile Updated Successfully.");
      } else {
        CustomSnackBar.show(context, "Server Error. Please try again");
      }
    }).catchError((error) {
      setState(() {
        isLoading = false;
      });
      CustomSnackBar.show(context, "Server Error. Please try again");
    });
  }

  getUser() {
    MyCacheManager.deleteCacheDir();
    MyCacheManager.deleteAppDir();
    MyProvider provider = Provider.of<MyProvider>(context, listen: false);
    APIManager().getUserprofile(context,
        email: provider.loginResponse!.user!.email,
        pass: provider.loginResponse!.password);
  }
}
