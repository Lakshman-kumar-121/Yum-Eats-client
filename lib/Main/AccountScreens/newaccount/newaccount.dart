import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screens/Main/NavigationScreen/editac/editaccont.dart';
import 'package:screens/Main/AccountScreens/newaccount/newaccountcont.dart';

class NewAccount extends StatelessWidget {
   String number;
   String uid;
   NewAccount({Key? key  , required this.number  , required this.uid }) : super(key: key);

  var _editaccont = Get.put(NewAccountController());

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
          appBar: AppBar(title: Text("Create Account")),
          body: Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text("   Basic Details"),
                        Divider(color: Colors.grey.withOpacity(0.5),thickness: 1.5,indent: 10 ,endIndent: 10,),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          padding: EdgeInsets.symmetric(horizontal: 10 ,vertical: 20),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15) , color: Color.fromARGB(255, 240, 240, 240)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                       
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
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Gender" ,style: TextStyle(fontSize: 18),),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(width: 1.5)),
                                child: DropdownButtonHideUnderline(
                                  child:Obx(() =>DropdownButton(
                                      value: _editaccont.Gender.value,
                                      items: Dropmenufunc(),
                                      onChanged: (value) {
                                          _editaccont.Gender.value = value.toString();
                                          print(_editaccont.Gender.value);
                                       
                                      }) ) 
                                  ,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        TextField(
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
                        ),]
                            ,
                          ),
                        ),
                        
                       Text("   Address Details"),
                       Divider(color: Colors.grey.withOpacity(0.5),thickness: 1.5,indent: 10 ,endIndent: 10,),
                        
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                           padding: EdgeInsets.only(left: 10 ,right: 10,top: 20),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15) , color: Color.fromARGB(255, 240, 240, 240)),
                          child: Column(children: [

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
                        ), SizedBox(
                          height: 10,
                        ),
                        TextField(
                          enabled: false,
                          maxLength: 10,
                          
                          controller: _editaccont.numberTController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "+91",
                            hintStyle: TextStyle(fontSize: 14),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    20)), 
                            labelText: number,
                          ),
                        ),],),
                        ),
  
  
                        Text("   Security Details"),
                        Divider(color: Colors.grey.withOpacity(0.5),thickness: 1.5,indent: 10 ,endIndent: 10,),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                            padding: EdgeInsets.symmetric(horizontal: 10 ,vertical: 20),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15) , color: Color.fromARGB(255, 240, 240, 240)),
                        
                        child: Column(children: [
 Obx(() => TextField(
                        
                          obscureText: _editaccont.showpassword.value,
                          controller: _editaccont.passwordController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                          
                          suffixIcon: IconButton(
                        onPressed: () {
                           _editaccont.showpassword.value = !_editaccont.showpassword.value;

                          
                        },
                        color: Colors.black.withOpacity(0.8),
                        icon: Icon(
                           _editaccont.showpassword.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    20)), // <-- This is the key
                            labelText: "Password",
                          ),
                        ),),
                        SizedBox(height: 20,),
                        Obx(() => TextField(
                          obscureText: _editaccont.showconfirmpassword.value,
                         controller: _editaccont.ConfirmpasswordController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                          
                          suffixIcon: IconButton(
                        onPressed: () {
                           _editaccont.showconfirmpassword.value = !_editaccont.showconfirmpassword.value;

                          
                        },
                        color: Colors.black.withOpacity(0.8),
                        icon: Icon(
                           _editaccont.showconfirmpassword.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    20)), // <-- This is the key
                            labelText: "Confirm Password",
                          ),
                        ),),
                        
                        
                        ],),),
                       ElevatedButton(
                            onPressed: () async {
                              
                              _editaccont.checkdetails(number , uid);
                            
                            },
                            child: Text("Save changes"),
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(double.maxFinite, 50)))
                                
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
}
