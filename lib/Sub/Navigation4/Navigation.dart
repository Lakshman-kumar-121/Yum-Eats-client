import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:screens/Main/AdditionalScreen/review/reviewload.dart';
import 'package:screens/Main/SideScreen/OnboardingScreen/IntroScreen.dart';
import 'package:screens/Main/AdditionalScreen/review/review.dart';
import 'package:screens/Main/AdditionalScreen/review/urreview.dart';
import 'package:screens/Main/NavigationScreen/Home/HomeLoad.dart';
import 'package:screens/Main/NavigationScreen/Home/Home.dart';
import 'package:screens/Main/AdditionalScreen/Orders/Order.dart';
import 'package:screens/Main/AdditionalScreen/Orders/red.dart';
import 'package:screens/Main/NavigationScreen/Allcategory/allcategory.dart';
import 'package:screens/Main/NavigationScreen/cart/Mycart.dart';
import 'package:screens/Main/NavigationScreen/editac/Editac.dart';
import 'package:screens/Main/NavigationScreen/fav/Fav.dart';
import 'package:screens/Main/NavigationScreen/profile/profile.dart';
import 'package:screens/Main/NavigationScreen/cart/cartload.dart';
import 'package:screens/Main/NavigationScreen/fav/favload.dart';
import 'package:screens/Main/AccountScreens/newaccount/newaccount.dart';
import 'package:screens/Main/NavigationScreen/profile/profileload.dart';
import 'package:screens/Main/LoginScreen/SignIn/signin.dart';
import 'package:screens/main.dart';


  var navicont = PersistentTabController( initialIndex: 3);
class Navigation extends StatelessWidget {
   Navigation({super.key});
   
   

  var screen = [


  // Refrence(),
// NewAccount(number: "as"),
//  ReviewLoad(),
  // Review(category: "w" ,name: "ds"),
  //  MyOder(),
  // Cart(),
  //  HomeLoading(),
   //NewAccount( number: "as"),
   Home(),
   //SignIn(),
  searchscreen(style: "all"),
// favu(),
// Home(),
// CartLoading(),
 favu(),
 Cart(),
 //ProfileLoading(),
   Profile()
  ];
   var nabar = [
    PersistentBottomNavBarItem(
      inactiveIcon: Icon(Icons.home_outlined, size: 28),
      icon: Icon(Icons.home_outlined, size: 35),
      activeColorPrimary: Color.fromARGB(255, 238, 238, 238),
      inactiveColorPrimary: Color.fromARGB(255, 153, 153, 153),
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.category_outlined, size: 35),
      inactiveIcon: Icon(Icons.category_outlined, size: 28),
      activeColorPrimary: Color.fromARGB(255, 238, 238, 238),
      inactiveColorPrimary: Color.fromARGB(255, 153, 153, 153),
    ),
   
    PersistentBottomNavBarItem(
      inactiveIcon: Icon(Icons.favorite_outline, size: 28),
      icon: Icon(Icons.favorite_outline, size: 35),
      activeColorPrimary: Color.fromARGB(255, 238, 238, 238),
      inactiveColorPrimary: Color.fromARGB(255, 153, 153, 153),
    ),
    
     PersistentBottomNavBarItem(
      icon: Icon(Icons.shopping_cart_outlined, size: 35),
      inactiveIcon: Icon(Icons.shopping_cart_outlined, size: 28),
      activeColorPrimary: Color.fromARGB(255, 238, 238, 238),
      inactiveColorPrimary: Color.fromARGB(255, 153, 153, 153),
    ),
    
    PersistentBottomNavBarItem(
      inactiveIcon: Icon(Icons.person_outline, size: 28),
      icon: Icon(Icons.person_outline, size: 35),
      activeColorPrimary: Color.fromARGB(255, 238, 238, 238),
      inactiveColorPrimary: Color.fromARGB(255, 153, 153, 153),
    ),
  ];
  
  

  Future setuid()async{
    Cur_user_id = await FirebaseAuth.instance.currentUser?.displayName;
  }
  @override
  Widget build(BuildContext context) {
   
    return FutureBuilder(
      future: setuid(),
      builder: (context, snapshot) {
         if (snapshot.connectionState== ConnectionState.waiting){
          return Container();
         }
        return Container(
        child: PersistentTabView(
           controller: navicont,
        margin: EdgeInsets.symmetric(horizontal: 05, vertical: 08),
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        screens: screen,
        navBarStyle: NavBarStyle.style12,
        context,
        bottomScreenMargin: 0,
        backgroundColor: Color.fromARGB(255, 41, 41, 41),
        items: nabar,
      )
      );
      }
      
    );
  }
}