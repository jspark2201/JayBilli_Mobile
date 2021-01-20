import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:email_validator/email_validator.dart';
import 'package:jaybilli_mobile/constant/contants.dart';
import 'package:intl/intl.dart';
import 'package:jaybilli_mobile/firebase/firestore_provider.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

enum Gender {MAN, WOMEN, OTHERS}

class SignUpPageActivity extends StatefulWidget {
  @override
  _SignUpPageActivityState createState() => _SignUpPageActivityState();
}

class _SignUpPageActivityState extends State<SignUpPageActivity> {
  TextEditingController _idController = TextEditingController(text: '');
  TextEditingController _pwController = TextEditingController(text: '');
  TextEditingController _confirmPwController = TextEditingController(text: '');
  TextEditingController _userNameController = TextEditingController(text: '');
  TextEditingController _genderController = TextEditingController(text: '');
  TextEditingController _birthdayController = TextEditingController(text: '');
  TextEditingController _emailController = TextEditingController(text: '');
  TextEditingController _phoneNumberController = TextEditingController(text: '');
  final GlobalKey<FormFieldState> _idFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _pwFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _confirmPwFormKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _userNameFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _emailFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _phoneNumberFormKey = GlobalKey<FormFieldState>();
  bool _clause1IsChecked = false;
  bool _clause2IsChecked = false;
  bool _clause3IsChecked = false;
  bool _clause4IsChecked = false;
  bool _clause1Visible = false;
  bool _clause2Visible = false;
  bool _clause3Visible = false;
  bool _clause4Visible = false;
  bool _isSubmitButtonEnabled = false;
  bool _isSubmitButtonEnabled2 = false;
  Contents _contents = Contents();
  Gender _gender = Gender.OTHERS;
  Size _size;
  DateTime _date = DateTime.now();
  int _nowYear = int.parse(DateFormat('yyyy').format(DateTime.now()));
  int _nowMonth = int.parse(DateFormat('MM').format(DateTime.now()));
  int _nowDay = int.parse(DateFormat('dd').format(DateTime.now()));
  var _phoneFormatter = new MaskTextInputFormatter(mask: '###-####-####', filter: {"#": RegExp(r'[0-9]')},);
  Pattern _phonePattern = r'\d{3}[-]\d{4}[-]\d{4}';
  final _pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    _idController.dispose();
    _pwController.dispose();
    _confirmPwController.dispose();
    _userNameController.dispose();
    _genderController.dispose();
    _birthdayController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return StreamBuilder<FirebaseUser>(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: Center(child: Text('회원가입')),
              actions: [
                SizedBox(
                  width: 56.0,
                )
              ],
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: PageView(
                  controller: _pageController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    signUpForm1(),
                    signUpForm2(),
                    signUpForm3(),
                    signUpForm4(),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget signUpForm1() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: _indicator(1),
        ),
        Container(
          height: 30,
        ),
        Flexible(
          flex: 1,
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        '약관동의',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      color: Colors.grey[300],
                      height: 1,
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: _clause1IsChecked,
                          onChanged: (bool value) {
                            setState(() {
                              _clause1IsChecked = value;
                            });
                          },
                        ),
                        Text('이용약관1(필수)'),
                        IconButton(
                            icon: _clause1Visible
                                ? Icon(Icons.arrow_drop_up)
                                : Icon(Icons.arrow_drop_down),
                            onPressed: () {
                              setState(() {
                                _clause1Visible = !_clause1Visible;
                              });
                            }),
                      ],
                    ),
                    Visibility(
                      visible: _clause1Visible,
                      child: Container(
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey)),
                        child: SingleChildScrollView(
                          child: Text(_contents.content),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: _clause2IsChecked,
                          onChanged: (bool value) {
                            setState(() {
                              _clause2IsChecked = value;
                            });
                          },
                        ),
                        Text('이용약관2(필수)'),
                        IconButton(
                            icon: _clause2Visible
                                ? Icon(Icons.arrow_drop_up)
                                : Icon(Icons.arrow_drop_down),
                            onPressed: () {
                              setState(() {
                                _clause2Visible = !_clause2Visible;
                              });
                            }),
                      ],
                    ),
                    Visibility(
                      visible: _clause2Visible,
                      child: Container(
                        width: 300,
                        height: 100,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey)),
                        child: SingleChildScrollView(
                          child: Text(_contents.content),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: _clause3IsChecked,
                          onChanged: (bool value) {
                            setState(() {
                              _clause3IsChecked = value;
                            });
                          },
                        ),
                        Text('이용약관3(선택)'),
                        IconButton(
                            icon: _clause3Visible
                                ? Icon(Icons.arrow_drop_up)
                                : Icon(Icons.arrow_drop_down),
                            onPressed: () {
                              setState(() {
                                _clause3Visible = !_clause3Visible;
                              });
                            }),
                      ],
                    ),
                    Visibility(
                      visible: _clause3Visible,
                      child: Container(
                        width: 300,
                        height: 100,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey)),
                        child: SingleChildScrollView(
                          child: Text(_contents.content),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: _clause4IsChecked,
                          onChanged: (bool value) {
                            setState(() {
                              _clause4IsChecked = value;
                            });
                          },
                        ),
                        Text('이용약관4(선택)'),
                        IconButton(
                            icon: _clause4Visible
                                ? Icon(Icons.arrow_drop_up)
                                : Icon(Icons.arrow_drop_down),
                            onPressed: () {
                              setState(() {
                                _clause4Visible = !_clause4Visible;
                              });
                            }),
                      ],
                    ),
                    Visibility(
                      visible: _clause4Visible,
                      child: Container(
                        width: 300,
                        height: 100,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey)),
                        child: SingleChildScrollView(
                          child: Text(_contents.content),
                        ),
                      ),
                    ),
                    Flexible(flex: 1, child: Container()),
                    ButtonTheme(
                      minWidth: double.infinity,
                      child: Builder(
                        builder: (context) {
                          return RaisedButton(
                            color: Colors.green,
                            onPressed: () {
                              if (_clause1IsChecked && _clause2IsChecked) {
                                _pageController.jumpToPage(1);
                              } else {
                                Scaffold.of(context).showSnackBar(
                                  new SnackBar(
                                    backgroundColor: Colors.red,
                                    duration: Duration(seconds: 1),
                                    content: new Text('이용약관에 동의해 주십시오.'),
                                  ),
                                );
                              }
                            },
                            child: Text(
                              '다음',
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget signUpForm2() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: _indicator(2),
        ),
        Container(
          height: 30,
        ),
        Flexible(
            flex: 1,
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          '아이디 & 비밀번호 생성',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                          color: Colors.grey[300],
                          height: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          '아이디',
                          style: TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextFormField(
                        controller: _idController,
                        key: _idFormKey,
                        style: TextStyle(fontSize: 14),
                        decoration: getTextFieldDecor('아이디'),
                        onChanged: (String value) {
                          _idFormKey.currentState.validate();
                          _isSubmitButtonEnabled = _isFormValid();
                        },
                        validator: (String value) {
                          if (value.isEmpty) {
                            return '아이디를 입력해주세요.';
                          } else if (value.contains(' ')) {
                            return '올바른 형식으로 입력해주세요.(공백 제외)';
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          '비밀번호',
                          style: TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextFormField(
                        controller: _pwController,
                        key: _pwFormKey,
                        obscureText: true,
                        style: TextStyle(fontSize: 14),
                        decoration: getTextFieldDecor('비밀번호'),
                        onChanged: (String value) {
                          _pwFormKey.currentState.validate();
                          _isSubmitButtonEnabled = _isFormValid();
                        },
                        validator: (String value) {
                          if (value.isEmpty ||
                              value.contains(' ') ||
                              value.length < 6) {
                            return '올바른 형식의 비밀번호를 입력해 주세요.\n(공백 제외, 6글자 이상)';
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          '비밀번호 확인',
                          style: TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextFormField(
                        controller: _confirmPwController,
                        key: _confirmPwFormKey,
                        obscureText: true,
                        style: TextStyle(fontSize: 14),
                        decoration: getTextFieldDecor('비밀번호 확인'),
                        onChanged: (String value) {
                          _confirmPwFormKey.currentState.validate();
                          _isSubmitButtonEnabled = _isFormValid();
                        },
                        validator: (String value) {
                          if (_pwController.text != _confirmPwController.text) {
                            return '동일한 비밀번호를 입력해 주세요.';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Flexible(flex: 1, child: Container()),
                      ButtonTheme(
                        minWidth: double.infinity,
                        child: Builder(
                          builder: (context) {
                            return RaisedButton(
                              color: Colors.green,
                              onPressed: () {
                                FocusScope.of(context).requestFocus(
                                    FocusNode()); //keyboard focus dismiss
                                // if (_isSubmitButtonEnabled) {
                                //   _pageController.jumpToPage(2);
                                // }
                                _pageController.jumpToPage(2);
                              },
                              child: Text(
                                '다음',
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
      ],
    );
  }

  Widget signUpForm3() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: _indicator(3),
        ),
        Container(
          height: 30,
        ),
        Flexible(
            flex: 1,
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          '개인정보 입력',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                          color: Colors.grey[300],
                          height: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          '이름',
                          style: TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextFormField(
                        controller: _userNameController,
                        key: _userNameFormKey,
                        style: TextStyle(fontSize: 14),
                        decoration: getTextFieldDecor('이름'),
                        onChanged: (String value) {
                          _userNameFormKey.currentState.validate();
                          _isSubmitButtonEnabled2 = _isFormValid2();
                        },
                        validator: (String value) {
                          if (value.isEmpty) {
                            return '이름을 입력해 주세요.';
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          '성별',
                          style: TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: [
                          Radio(value: Gender.MAN, groupValue: _gender, onChanged: (value){
                            setState(() {
                              _gender = value;
                            });
                          }),
                          Text('남자'),
                          SizedBox(width: 30,),
                          Radio(value: Gender.WOMEN, groupValue: _gender, onChanged: (value){
                            setState(() {
                              _gender = value;
                            });
                          }),
                          Text('여자'),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          '생년월일',
                          style: TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex:1,
                            child: Container(height: 50, width: double.infinity,
                            alignment: Alignment(-1.0, 0),
                            decoration: BoxDecoration(
                              border: Border.all(color:Colors.grey[300]),
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.grey[100]
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left:12.0),
                              child: Text(DateFormat('yyyy-MM-dd').format(_date)),
                            ),),
                          ),
                          SizedBox(width: 10,),
                          ButtonTheme(
                            buttonColor: Colors.blue,
                            child: RaisedButton(
                                child: Text('설정', style: TextStyle(color: Colors.white),),
                                onPressed: (){
                                  DatePicker.showDatePicker(context,
                                    showTitleActions: true,
                                    minTime: DateTime(1900, 1, 1),
                                    maxTime: DateTime(_nowYear, _nowMonth, _nowDay),
                                    onChanged: (date) {
                                      _date = date;
                                    },
                                    onConfirm: (date) {
                                      setState(() {
                                        _date = date;
                                      });
                                    },
                                    locale: LocaleType.ko
                                  );
                                }),
                          ),
                        ],),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          '이메일',
                          style: TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextFormField(
                        controller: _emailController,
                        key: _emailFormKey,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(fontSize: 14),
                        decoration: getTextFieldDecor('이메일'),
                        onChanged: (String value) {
                          _emailFormKey.currentState.validate();
                          _isSubmitButtonEnabled2 = _isFormValid2();
                        },
                        validator: (String value) {
                          if (!isValidEmail()) {
                            return '올바른 형식의 이메일을 입력해 주세요.';
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          '전화번호',
                          style: TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextFormField(
                        controller: _phoneNumberController,
                        key: _phoneNumberFormKey,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(fontSize: 14),
                        inputFormatters: [_phoneFormatter],
                        decoration: getTextFieldDecor('전화번호'),
                        onChanged: (String value) {

                        },
                        validator: (String value) {
                          if(value.isEmpty) {
                            print('전화번호를 입력해 주세요.');
                            return '전화번호를 입력해 주세요.';
                          } else if(!RegExp(_phonePattern).hasMatch(value)) {
                            print('올바른 형식이 아닙니다.');
                            return '올바른 형식이 아닙니다.';
                          }
                          print('올바른 형식입니다.');
                          return null;
                        },
                      ),
                      Flexible(flex: 1, child: Container()),
                      SizedBox(height: 50,),
                      Text('- 등록한 개인정보는 아이디 찾기 및 비밀번호 찾기 등에 이용됩니다.', style: TextStyle(color:Colors.grey[500], fontSize: 12.0),),
                      ButtonTheme(
                        minWidth: double.infinity,
                        child: Builder(
                          builder: (context) {
                            return RaisedButton(
                              color: Colors.green,
                              onPressed: () {
                                FocusScope.of(context).requestFocus(
                                    FocusNode()); //keyboard focus dismiss
                                // if (_isSubmitButtonEnabled2) {
                                //   _pageController.jumpToPage(3);
                                // }
                                _register;
                              },
                              child: Text(
                                '다음',
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
      ],
    );
  }

  Widget signUpForm4() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: _indicator(4),
        ),
        Flexible(flex: 2, child: Container()),
        Text(
          '환영합니다.',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        Flexible(flex: 1, child: Container()),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'jspark2201',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              '님',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Flexible(flex: 1, child: Container()),
        Text(
          '제이빌리 회원가입이 완료되었습니다.',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        Flexible(flex: 6, child: Container()),
        ButtonTheme(
          minWidth: double.infinity,
          child: Builder(
            builder: (context) {
              return RaisedButton(
                color: Colors.green,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  '확인',
                  style: TextStyle(color: Colors.white),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  bool _isFormValid() {
    return _idFormKey.currentState.isValid &&
        _pwFormKey.currentState.isValid &&
        _confirmPwFormKey.currentState.isValid;
  }

  bool _isFormValid2() {
    return _userNameFormKey.currentState.isValid &&
        _emailFormKey.currentState.isValid &&
        _phoneNumberFormKey.currentState.isValid;
  }

  Widget _indicator(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: index == 1 ? 15.0 : 10.0,
          backgroundColor: index == 1 ? Colors.blue : Colors.grey[300],
          child: Text(
            '1',
            style: TextStyle(color: index == 1 ? Colors.white : Colors.black),
          ),
        ),
        SizedBox(
          width: 4,
        ),
        CircleAvatar(
          radius: 2,
          backgroundColor: Colors.grey[300],
        ),
        SizedBox(
          width: 4,
        ),
        CircleAvatar(
          radius: 2,
          backgroundColor: Colors.grey[300],
        ),
        SizedBox(
          width: 4,
        ),
        CircleAvatar(
          radius: index == 2 ? 15.0 : 10.0,
          backgroundColor: index == 2 ? Colors.blue : Colors.grey[300],
          child: Text(
            '2',
            style: TextStyle(color: index == 2 ? Colors.white : Colors.black),
          ),
        ),
        SizedBox(
          width: 4,
        ),
        CircleAvatar(
          radius: 2,
          backgroundColor: Colors.grey[300],
        ),
        SizedBox(
          width: 4,
        ),
        CircleAvatar(
          radius: 2,
          backgroundColor: Colors.grey[300],
        ),
        SizedBox(
          width: 4,
        ),
        CircleAvatar(
          radius: index == 3 ? 15.0 : 10.0,
          backgroundColor: index == 3 ? Colors.blue : Colors.grey[300],
          child: Text(
            '3',
            style: TextStyle(color: index == 3 ? Colors.white : Colors.black),
          ),
        ),
        SizedBox(
          width: 4,
        ),
        CircleAvatar(
          radius: 2,
          backgroundColor: Colors.grey[300],
        ),
        SizedBox(
          width: 4,
        ),
        CircleAvatar(
          radius: 2,
          backgroundColor: Colors.grey[300],
        ),
        SizedBox(
          width: 4,
        ),
        CircleAvatar(
          radius: index == 4 ? 15.0 : 10.0,
          backgroundColor: index == 4 ? Colors.blue : Colors.grey[300],
          child: Text(
            '4',
            style: TextStyle(color: index == 4 ? Colors.white : Colors.black),
          ),
        )
      ],
    );
  }

  // Widget signUpForm() {
  //   return Form(
  //     key: _formKey,
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           '아이디',
  //           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  //         ),
  //         SizedBox(
  //           height: 10,
  //         ),
  //         TextFormField(
  //           controller: _idController,
  //           style: TextStyle(fontSize: 14),
  //           decoration: getTextFieldDecor('아이디'),
  //           validator: (String value) {
  //             if (value.isEmpty || value.contains(' ')) {
  //               return '올바른 형식으로 입력해주세요.(공백 제외)';
  //             }
  //             return null;
  //           },
  //         ),
  //         SizedBox(
  //           height: 20,
  //         ),
  //         Text(
  //           '비밀번호',
  //           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  //         ),
  //         SizedBox(
  //           height: 10,
  //         ),
  //         TextFormField(
  //           controller: _pwController,
  //           obscureText: true,
  //           style: TextStyle(fontSize: 14),
  //           decoration: getTextFieldDecor('비밀번호'),
  //           validator: (String value) {
  //             if (value.isEmpty || value.contains(' ') || value.length < 6) {
  //               return '올바른 형식의 비밀번호를 입력해 주세요.\n(공백 제외, 6글자 이상)';
  //             }
  //             return null;
  //           },
  //         ),
  //         SizedBox(
  //           height: 20,
  //         ),
  //         Text(
  //           '비밀번호 확인',
  //           style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
  //         ),
  //         SizedBox(
  //           height: 10,
  //         ),
  //         TextFormField(
  //           controller: _confirmPwController,
  //           obscureText: true,
  //           style: TextStyle(fontSize: 14),
  //           decoration: getTextFieldDecor('비밀번호 확인'),
  //           validator: (String value) {
  //             if (_pwController.text != _confirmPwController.text) {
  //               return '동일한 비밀번호를 입력해 주세요.';
  //             }
  //             return null;
  //           },
  //         ),
  //         SizedBox(
  //           height: 20,
  //         ),
  //         Text(
  //           '이메일',
  //           style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
  //         ),
  //         SizedBox(
  //           height: 10,
  //         ),
  //         TextFormField(
  //           controller: _emailController,
  //           style: TextStyle(fontSize: 14),
  //           decoration: getTextFieldDecor('이메일'),
  //           validator: (String value) {
  //             if (!isValidEmail()) {
  //               return '올바른 형식의 이메일을 입력해 주세요.';
  //             }
  //             return null;
  //           },
  //         ),
  //         SizedBox(
  //           height: 20,
  //         ),
  //         Text(
  //           '휴대폰 번호',
  //           style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
  //         ),
  //         SizedBox(
  //           height: 10,
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             SizedBox(
  //               width: _size.width / 1.5,
  //               child: TextFormField(
  //                 controller: _phoneNumberController,
  //                 style: TextStyle(fontSize: 14),
  //                 decoration: getTextFieldDecor('휴대폰 번호( - 제외 )'),
  //                 validator: (String value) {
  //                   if (value.isEmpty ||
  //                       value.contains(' ') ||
  //                       value.contains('-')) {
  //                     return '올바른 형식의 번호를 입력해 주세요.';
  //                   }
  //                   return null;
  //                 },
  //               ),
  //             ),
  //             RaisedButton(
  //               color: Colors.green,
  //               onPressed: () {
  //                 print('인증버튼 눌림');
  //               },
  //               child: Text(
  //                 '인증',
  //                 style: TextStyle(color: Colors.white),
  //               ),
  //             ),
  //             SizedBox(),
  //           ],
  //         ),
  //         SizedBox(
  //           height: 20,
  //         ),
  //         Text('인증 코드',
  //             style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
  //         SizedBox(
  //           height: 10,
  //         ),
  //         TextFormField(
  //           controller: _SmsCodeController,
  //           style: TextStyle(fontSize: 14),
  //           decoration: getTextFieldDecor('인증 코드'),
  //           validator: (String value) {
  //             if (value.isEmpty) {
  //               return '인증코드를 입력해 주세요.';
  //             }
  //             return null;
  //           },
  //         ),
  //         SizedBox(
  //           height: 30,
  //         ),
  //         Center(
  //           child: RaisedButton(
  //             color: Colors.blue,
  //             onPressed: () {
  //               if (_formKey.currentState.validate()) {
  //                 // _register;
  //               }
  //             },
  //             child: Text(
  //               '가입하기',
  //               style: TextStyle(color: Colors.white),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  get _register async {
    String errorMessage;
    try {
      final AuthResult _result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text, password: _pwController.text);
      _pageController.jumpToPage(3);

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
          showToast('이미 사용하고 있는 아이디입니다.');
          errorMessage = "An undefined Error happened.";
      }
    }
    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.black,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
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
          borderRadius: BorderRadius.circular(10.0),
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

  bool isValidEmail() {
    bool valid = EmailValidator.validate(_emailController.text);
    return valid;
  }
}
