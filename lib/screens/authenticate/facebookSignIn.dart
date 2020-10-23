import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

Future<User> signInWithFacebook() async {
  FacebookLogin facebookLogin  = FacebookLogin();
  OAuthCredential credential;
  UserCredential authResult;
  User user;
  final result = await facebookLogin.logIn(['email']);
  final token = result.accessToken.token;
  final graphResponse = await http.get(
              'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${token}');
  print(graphResponse.body);
  if(result.status == FacebookLoginStatus.loggedIn){
    credential = FacebookAuthProvider.credential(token);
    authResult = await _auth.signInWithCredential(credential);
    user = authResult.user;
  }
  return user;
}
