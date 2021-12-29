import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import './Register.dart';
import '../auth_bloc.dart';
import './dialog/msg_dialog.dart';
import './dialog/loading_dialog.dart';
class _LoginPage extends State<LoginPage> {
  AuthBloc authBloc = new AuthBloc();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
      constraints: BoxConstraints.expand(),
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 140,
            ),
            new Image.asset('images/logo_login.png'),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 10, 10),
                child: Text(
                  "Wellcome back!",
                  style: TextStyle(
                      fontSize: 22,
                      color: Color(0xff333333),
                      fontWeight: FontWeight.bold),
                )),
            Text(
              "Login to continue using iCab",
              style: TextStyle(
                fontSize: 15,
                color: Color(0xff333333),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 100, 0, 20),
              child: TextField(
                controller: _emailController,
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  labelText: " Email",
                  prefixIcon: Container(
                    width: 50,
                    child: Image.asset('images/ic_user.png'),
                  ),
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xff333333), width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(6))),
                ),
              ),
            ),
            TextField(
              controller: _passController,
              obscureText: true,
              style: TextStyle(fontSize: 20),
              decoration: InputDecoration(
                labelText: " Password",
                prefixIcon: Container(
                  width: 50,
                  child: Image.asset('images/ic_lock.png'),
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff333333), width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(6))),
              ),
            ),
            Container(
              constraints: BoxConstraints.loose(Size(double.infinity, 30)),
              alignment: AlignmentDirectional.centerEnd,
              child: Text(
                "Forgot password?",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff8d8989),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 40),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: RaisedButton(
                  onPressed: _onLoginClick,
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  color: Color(0xff54a3ec),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
              child: RichText(
                text: TextSpan(
                  text: "New User? ",
                  style: TextStyle(color: Color(0xff8d8989), fontSize: 16),
                  children: <TextSpan>[
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()));
                        },
                      text: "Sign up for a new account",
                      style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
  void _onLoginClick() {
    String email = _emailController.text;
    String pass = _passController.text;
    LoadingDialog.showLoadingDialog(context, "Loading...");
    authBloc.signIn(email, pass, () {
      LoadingDialog.hideLoadingDialog(context);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => RegisterPage()));
    }, (msg) {
      LoadingDialog.hideLoadingDialog(context);
      MsgDialog.showMsgDialog(context, "Sign-In", msg);
    });
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPage();
}
