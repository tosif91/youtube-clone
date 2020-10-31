import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService{
//  final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GoogleSignIn _googleSignIn = GoogleSignIn();
//    bool isUserSignedIn = false;
 

//    String  getUid(){
//     return _auth.currentUser.uid;
//   }

//   bool checkUser() {
//     if (_auth.currentUser != null) {
//   //    uid = _auth.currentUser.uid;
//       return true;
//     }
//     return false;
//   }

//   Future<bool> signOut() async {
//     try {
//       //locator.reset();
//       print('user logout successfully');
//       return await _auth.signOut().then((value) {
      
//         return true;
//       });
//     } catch (e) {
//       print(e);
//       return false;
//     }
//   }


// //  gogle sign IN

//  Future<User> handleGoogleSignIn() async {
//    // check if user is null then signin failed.
//    print('signingIn');
//    User user;
//    bool userSignedIn = await _googleSignIn.isSignedIn();

//    if (userSignedIn) {
//      user = _auth.currentUser;
//    } else {
//      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
//      final GoogleSignInAuthentication googleAuth =
//          await googleUser.authentication;

//      final AuthCredential credential = GoogleAuthProvider.credential(
//        accessToken: googleAuth.accessToken,
//        idToken: googleAuth.idToken,
//      );
//      user = (await _auth.signInWithCredential(credential)).user;
//      userSignedIn = await _googleSignIn.isSignedIn();

//      ///  signed in handle it google..
//    }
//    return user;
//  }



}