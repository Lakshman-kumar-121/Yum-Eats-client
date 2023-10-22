import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:screens/Main/NavigationScreen/editac/editaccont.dart';
import 'package:screens/Main/NavigationScreen/profile/profilecont.dart';

class EditAc extends StatelessWidget {
   
   EditAc({Key? key }) : super(key: key);
   

  String gender = "Male";

  var _editaccont = Get.put(EditAccountController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _editaccont.Getdata(),
      builder: (context, snapshot)  {
        if (snapshot.connectionState == ConnectionState.waiting) return CircularProgressIndicator();
        return Scaffold(
          appBar: AppBar(title: Text("edit a/c")),
          body: Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Center(
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(200),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(2200),
                            onTap: () {
                              _editaccont.gotoImageview();
                            },
                            child: Obx(() => Image.network(
                              _editaccont.photoUrl.value,
                              height: 200,
                              width: 200,
                              fit: BoxFit.cover,
                            ),),
                          ) 
                        ),
                        Positioned(
                            bottom: 10,
                            right: 15,
                            child: Padding(
                              padding: EdgeInsets.zero,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(200)),
                                child: IconButton(
                                  onPressed: () {
                                    cameraclick(context);
                                  },
                                  icon: Icon(
                                    Icons.camera_alt_outlined,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Your Details"),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: _editaccont.nameTController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            hintText: "Firstname",
                            hintStyle: TextStyle(fontSize: 14),
                            border: OutlineInputBorder(), // <-- This is the key
                            labelText: "Firstname",
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Gender"),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(width: 1.5)),
                                child: DropdownButtonHideUnderline(
                                  child: Obx(() =>DropdownButton(
                                      value: _editaccont.Gender.value,
                                      items: Dropmenufunc(),
                                      onChanged: (value) {
                                          _editaccont.Gender.value = value.toString();
                                          print(_editaccont.Gender.value);
                                       
                                      }))
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          enabled: false,
                          controller: _editaccont.mailTController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: "xyz",
                            hintStyle: TextStyle(fontSize: 14),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    20)), // <-- This is the key
                            labelText: "Mail",
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: _editaccont.addresTController,
                          keyboardType: TextInputType.streetAddress,
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText: "xyz",
                            hintStyle: TextStyle(fontSize: 14),
                            border: OutlineInputBorder(), // <-- This is the key
                            labelText: "Address",
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: _editaccont.numberTController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "+91",
                            hintStyle: TextStyle(fontSize: 14),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    20)), // <-- This is the key
                            labelText: "Number",
                          ),
                        ),
                      
                        SizedBox(height: 10),
                        ElevatedButton(
                            onPressed: () async {
                              await _editaccont.updateprofile();
                              _editaccont.Getdata();
                              //Get.snackbar("asd", "created user");
                            },
                            child: Text("Save changes"),
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(double.maxFinite, 50))),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 200,
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  Dropmenufunc() {
    return [
      DropdownMenuItem(
        child: Text("Male"),
        value: "Male",
      ),
      DropdownMenuItem(
        child: Text("Female"),
        value: "female",
      )
    ];
  }

  cameraclick(context) {
    return Get.defaultDialog(
        title: "Select Method",
        content: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                 _editaccont.opencamera();
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.maxFinite, 50)),
                child: Text(
                  "Camera",
                  style: TextStyle(fontSize: 18),
                )),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  _editaccont.SelectFile();
                },
                child: Text(
                  "Gallery",
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.maxFinite, 50))),
                    SizedBox(
              height: 10,
            ),
                    
                     ElevatedButton(
                onPressed: () {
                  _editaccont.removepic();
                },
                child: Text(
                  "Remove photo",
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.maxFinite, 50)))
          ],
        ));
  }
}
