import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jaybilli_mobile/signUpPage.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _idController = TextEditingController(text: '');
  TextEditingController _pwController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('로그인')),
      ),
      body: SafeArea(
        child: signInForm(),
      ),
    );
  }

  Widget signInForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(flex: 1, child: Container()),
            Text(
              '아이디',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _idController,
              style: TextStyle(fontSize: 14),
              decoration: getTextFieldDecor('아이디'),
              validator: (String value) {
                if (value.isEmpty || value.contains(' ')) {
                  return '올바른 형식으로 입력해주세요.(공백 제외)';
                }
                return null;
              },
            ),
            Flexible(flex: 1, child: Container()),
            Text(
              '비밀번호',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _pwController,
              obscureText: true,
              style: TextStyle(fontSize: 14),
              decoration: getTextFieldDecor('비밀번호'),
              validator: (String value) {
                if (value.isEmpty || value.contains(' ') || value.length < 6) {
                  return '올바른 형식의 비밀번호를 입력해 주세요.\n(공백 제외, 6글자 이상)';
                }
                return null;
              },
            ),
            Flexible(flex: 2, child: Container()),
            Center(
              child: RaisedButton(
                color: Colors.blue,
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _login;
                  }
                },
                child: Text(
                  '확인',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Flexible(flex: 2, child: Container()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '아이디 찾기',
                  style: TextStyle(color: Colors.grey[500]),
                ),
                Text(
                  '|',
                  style: TextStyle(color: Colors.grey[500]),
                ),
                Text(
                  '비밀번호 찾기',
                  style: TextStyle(color: Colors.grey[500]),
                )
              ],
            ),
            Flexible(flex: 6, child: Container()),
            Center(
              child: RichText(
                text: TextSpan(
                    text: null,
                    style: DefaultTextStyle.of(context).style,
                    children: [
                      TextSpan(
                          text: '계정이 없으십니까? ',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                      TextSpan(
                          text: '가입하기', style: TextStyle(color: Colors.blue, fontSize: 16.0),
                          recognizer: TapGestureRecognizer()..onTap = () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                          }),
                    ]),
              ),
            ),
            Flexible(flex: 2, child: Container()),
          ],
        ),
      ),
    );
  }

  InputDecoration getTextFieldDecor(String hint) {
    return InputDecoration(
        hintText: hint,
        errorStyle: TextStyle(fontSize: 14, color: Colors.red),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey[300],
            width: 1,
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey[300],
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        fillColor: Colors.grey[100],
        filled: true);
  }

  get _login async {
    String errorMessage;
    try {
      final AuthResult result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _idController.text + '@gmail.com',
              password: _pwController.text);
    } catch (error) {
      switch (error.code) {
        case "ERROR_INVALID_EMAIL":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "ERROR_WRONG_PASSWORD":
          errorMessage = "Your password is wrong.";
          break;
        case "ERROR_USER_NOT_FOUND":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "ERROR_USER_DISABLED":
          errorMessage = "User with this email has been disabled.";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          errorMessage = "Too many requests. Try again later.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
    }

    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
  }
}
