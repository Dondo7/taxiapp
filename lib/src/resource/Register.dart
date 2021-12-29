import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import './Login.dart';
import '../auth_bloc.dart';
import './dialog/msg_dialog.dart';
import './dialog/loading_dialog.dart';
class _RegisterPage extends State<RegisterPage> {
  AuthBloc authBloc = new AuthBloc();

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();

  @override
  void dispose() {
    authBloc.dispose();
    super.dispose();
  }

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
              height: 60,
            ),
            new Image.asset('images/logo_login.png'),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text(
                  "Create account",
                  style: TextStyle(
                      fontSize: 22,
                      color: Color(0xff333333),
                      fontWeight: FontWeight.bold),
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
              child: StreamBuilder(
                stream: authBloc.nameStream,
                builder: (context, snapshot) => TextField(
                  controller: _nameController,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    labelText: " Name",
                    errorText: snapshot.hasError ? snapshot.error.toString() : null,
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
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: StreamBuilder(
                stream: authBloc.phoneStream,
                builder: (context, snapshot) => TextField(
                  controller: _phoneController,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    labelText: " Number Phone",
                    errorText: snapshot.hasError ? snapshot.error.toString() : null,
                    prefixIcon: Container(
                      width: 50,
                      child: Image.asset('images/ic_phone.png'),
                    ),
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xff333333), width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: StreamBuilder(
                stream: authBloc.emailStream,
                builder: (context, snapshot) => TextField(
                  controller: _emailController,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    labelText: " Email",
                    errorText: snapshot.hasError ? snapshot.error.toString() : null,
                    prefixIcon: Container(
                      width: 50,
                      child: Image.asset('images/ic_mail.png'),
                    ),
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xff333333), width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                  ),
                ),
              ),
            ),
            StreamBuilder(
              stream: authBloc.passStream,
              builder: (context, snapshot) => TextField(
                controller: _passController,
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  labelText: " Password",
                  errorText: snapshot.hasError ? snapshot.error.toString() : null,
                  prefixIcon: Container(
                    width: 50,
                    child: Image.asset('images/ic_lock.png'),
                  ),
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xff333333), width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(6))),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 60, 0, 50),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: RaisedButton(
                  onPressed:  _onSignUpClicked,
                  child: Text(
                    "Register",
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
                  text: "Already a account  |  ",
                  style: TextStyle(color: Color(0xff8d8989), fontSize: 16),
                  children: <TextSpan>[
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                      text: "Login now",
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
  _onSignUpClicked() {
    var isValid = authBloc.isValid(_nameController.text, _emailController.text,
        _passController.text, _phoneController.text);
    if (isValid) {
      // create user
      // loading dialog
      LoadingDialog.showLoadingDialog(context, 'Loading...');
      authBloc.signUp(_emailController.text, _passController.text,
          _phoneController.text, _nameController.text, () {
            LoadingDialog.hideLoadingDialog(context);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
          }, (msg) {
            LoadingDialog.hideLoadingDialog(context);
            MsgDialog.showMsgDialog(context, "Sign-In", msg);
            // show msg dialog
          });
    }
  }
}

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPage();
}
