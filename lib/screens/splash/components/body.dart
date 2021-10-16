import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shop_app/Config/config.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/socal_card.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/user.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/size_config.dart';

// This is the best practice
import '../components/authentication_content.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  double _scale;

  int currentPage = 0;
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  bool showSpiner = false;
  auth.User user;
  final _firestore = FirebaseFirestore.instance;
  USER currentUser;
  bool isSignedIn;

  List<Map<String, String>> splashData = [
    {"text": "THE REAl EXPERIENCE", "image": "assets/images/home2.jpg"},
    {
      "text":
          "BEST SOUND EXPERIENCE\n\n\n Buy Premium and Best Speakers, Amplifier and more at reasonable rates. We show the easy way to shop so take a moment to drop us a line",
      "image": "assets/images/home1.jpg"
    },
    {
      "text":
          "Want a Home Theatre  \nWe build best Home Theatres , which makes the cinema alive.Just give us the opportunity and we will build the best Home Theatre Experience for you ",
      "image": "assets/images/home3.jpg"
    },
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {
          //
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _animationController.value;
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]['text'],
                  index: index,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    Spacer(flex: 3),
                    GestureDetector(
                      onTapDown: _onTapDown,
                      onTapUp: _onTapUp,
                      onTap: () {
                        onGoogleSignIn(context);
                      },
                      child: Transform.scale(
                        scale: _scale,
                        child: _animatedButtonUi,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _animatedButtonUi => DefaultButton(
        text: "Continue with\t",
        icon: showSpiner
            ? SizedBox(
                height: 20.0,
                width: 20.0,
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: Colors.white,
                  strokeWidth: 1.5,
                ),
              )
            : SocalCard(
                icon: "assets/icons/google-icon.svg",
                press: null,
              ),
      );
  // Container(
  //   height: getProportionateScreenHeight(56),
  //   width: double.infinity,
  //   decoration: BoxDecoration(
  //     borderRadius: BorderRadius.circular(100.0),
  //     boxShadow: [
  //       BoxShadow(
  //         color: Colors.grey,
  //         offset: Offset(0.0, 5.0),
  //         blurRadius: 30.0,
  //       ),
  //     ],
  //     color: kPrimaryColor,
  //   ),
  //   child: Center(
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Text(
  //           "Continue with\t",
  //           style: TextStyle(
  //             fontSize: getProportionateScreenWidth(18),
  //             color: Colors.white,
  //           ),
  //         ),
  //         SizedBox(
  //           width: 5.0,
  //         ),
  //         SocalCard(
  //           icon: "assets/icons/google-icon.svg",
  //           press: null,
  //         ),
  //       ],
  //     ),
  //   ),
  // );

  void _onTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _animationController.reverse();
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }

  void onGoogleSignIn(BuildContext context) async {
    final GoogleSignInAccount googleuser = await _googleSignIn.signIn();
    if (googleuser != null) {
      user = await _handleSignIn(googleuser);
      DocumentSnapshot documentSnapshot =
          await _firestore.collection('users').doc(user.uid).get();
      if (!documentSnapshot.exists) {
        saveUserInfoToFirestore(user).then((value) {
          print('i amin ifif condition');

          Route route = MaterialPageRoute(builder: (c) => HomeScreen());
          Navigator.pushReplacement(context, route);
        });
      } else {
        // await Provider.of<CurrentUser>(context, listen: false)
        //     .refreshUserData();
        print('i amin else condition');

        setState(() {
          currentUser = USER.fromDocument(documentSnapshot);
        });
        await saveInfoToPhone(currentUser);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
            (Route<dynamic> route) => false);
      }
      setState(() {
        showSpiner = false;
      });
    }
  }

  Future saveUserInfoToFirestore(User fUser) async {
    try {
      if (user != null) {
        _firestore
            .collection('users')
            .doc(user
                .uid) //user data will be save in a document having id as userid
            .set({
          'name': user.displayName,
          'email': user.email,
          'uid': user.uid,
          'profilePhoto': user.photoURL,
          'accountCreatedOndate': DateTime.now(),
          'gender': "",
          'key': user.displayName[0].toUpperCase(),
          EcommerceApp.userCartList: [],
        });
        await EcommerceApp.sharedPreferences.setString('uid', user.uid);
        await EcommerceApp.sharedPreferences
            .setString(EcommerceApp.userEmail, user.email);
        await EcommerceApp.sharedPreferences
            .setString(EcommerceApp.userName, user.displayName);
        await EcommerceApp.sharedPreferences
            .setString(EcommerceApp.userAvatarUrl, user.photoURL);
        await EcommerceApp.sharedPreferences
            .setStringList(EcommerceApp.userCartList, []);

        DocumentSnapshot documentSnapshot =
            await _firestore.collection('users').doc(user.uid).get();
        print(documentSnapshot);
        currentUser = USER.fromDocument(documentSnapshot);
        // await Provider.of<CurrentUser>(context, listen: false)
        //     .refreshUserData();
        setState(() {
          showSpiner = false;
        });
      }
    } catch (e) {
      throw e;
    }
  }

  saveInfoToPhone(USER fuser) async {
    print(' ia m in the save Info to phoen');
    print(fuser.displayName);
    await EcommerceApp.sharedPreferences.setString('uid', user.uid);
    await EcommerceApp.sharedPreferences
        .setString(EcommerceApp.userEmail, user.email);
    await EcommerceApp.sharedPreferences
        .setString(EcommerceApp.userName, user.displayName);
    await EcommerceApp.sharedPreferences
        .setString(EcommerceApp.userAvatarUrl, user.photoURL);
    await EcommerceApp.sharedPreferences.setStringList(
        EcommerceApp.userCartList, fuser.userCart.cast<String>());
  }

  Future<auth.User> _handleSignIn(GoogleSignInAccount googleuser) async {
    auth.User _user;
    setState(() {
      showSpiner = true;
    });
    final GoogleSignInAuthentication googleAuth =
        await googleuser.authentication;

    final auth.AuthCredential credential = auth.GoogleAuthProvider.credential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
    _user = (await _auth.signInWithCredential(credential)).user;

    return _user;
  }
}
