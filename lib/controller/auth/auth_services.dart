import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final FirebaseAuth _auth=FirebaseAuth.instance;

  Future signInWithEmailAndPassword(String email, String password)async{
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      final user = _auth.currentUser;
      print("login success");
      print("this is $user");
      return user;
    }catch(e){
      print(e);
      return null;

    }
  }

  Future registerWithEmailAndPassword(String email, String password)async{
    try{
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
    }catch(e){
      print(e.toString());
      return null;

    }
  }

  // Future signout() async{
  //   try{
  //     return await _auth.signOut();
  //   }catch(e){
  //     print(e.toString());
  //     return null;
  //   }
  // }

// void changePassword(String password) {
//   User user = _auth.currentUser;
//   //Pass in the password to updatePassword.
//   user.updatePassword(password).then((_) {
//     print("Successfully changed password");
//   }).catchError((error) {
//     print("Password can't be changed" + error.toString());
//     //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
//   });
// }
}