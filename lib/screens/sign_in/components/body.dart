import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shop_app/components/no_account_text.dart';
import 'package:shop_app/components/socal_card.dart';

import '../../../size_config.dart';
import 'sign_form.dart';

final _firestore = FirebaseFirestore.instance;
auth.User user;

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  bool showSpiner = false;

  bool isSignedIn;

  Future<auth.User> _handleSignIn(GoogleSignInAccount googleuser) async {
    auth.User _user;
    setState(() {
      showSpiner = true;
      print('sdfsdf');
    });
    final GoogleSignInAuthentication googleAuth =
        await googleuser.authentication;

    final auth.AuthCredential credential = auth.GoogleAuthProvider.credential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
    _user = (await _auth.signInWithCredential(credential)).user;

    return _user;
  }

  void onGoogleSignIn(BuildContext context) async {
    final GoogleSignInAccount googleuser = await _googleSignIn.signIn();
    if (googleuser != null) {
      user = await _handleSignIn(googleuser);
      print(user.displayName);
      print(user.photoURL);
      // DocumentSnapshot documentSnapshot =
      await _firestore.collection('users').doc(user.uid).set({
        'username': user.displayName,
      });

      // if (!documentSnapshot.exists) {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => CreateAccountPage(
      //         firebaseuser: user,
      //       ),
      //     ),
      //   );
      // }
      setState(() {
        showSpiner = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                Text(
                  "Sign In",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(28),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Sign in with your email and password  \nor continue with social media",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                SignForm(),
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Or Continue With'),
                    ],
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocalCard(
                      icon: "assets/icons/google-icon.svg",
                      press: () {
                        onGoogleSignIn(context);
                      },
                    ),
                    // SocalCard(
                    //   icon: "assets/icons/facebook-2.svg",
                    //   press: () {},
                    // ),
                    // SocalCard(
                    //   icon: "assets/icons/twitter.svg",
                    //   press: () {},
                    // ),
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                NoAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
