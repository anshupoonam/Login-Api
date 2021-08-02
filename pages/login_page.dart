// ignore_for_file: unnecessary_new, override_on_non_overriding_member

import 'package:flutter/material.dart';
import 'package:milkmanagement/ProgressHUD.dart';
import 'package:milkmanagement/api/api_service.dart';
import 'package:milkmanagement/model/login_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final scaffoldkey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool hidePassword = true;
  LoginRequestModel? loginRequestModel;
  bool isApiCallProcess = false;

  @override
  void initState() {
    super.initState();
    loginRequestModel = new LoginRequestModel();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _uiSetup(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.2,
    );
  }

  @override
  Widget _uiSetup(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      backgroundColor: Theme
          .of(context)
          .colorScheme
          .secondary,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding:
                  const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  margin:
                  const EdgeInsets.symmetric(vertical: 85, horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme
                          .of(context)
                          .primaryColor,
                      boxShadow: [
                        BoxShadow(
                            color: Theme
                                .of(context)
                                .hintColor
                                .withOpacity(0.2),
                            offset: const Offset(0, 10),
                            blurRadius: 20)
                      ]),
                  child: Form(
                    key: globalFormKey,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          "LogIn",
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline2,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (input) => loginRequestModel?.login_name = input,
                          validator: (input) =>
                          !input!.contains('m')
                              ? "Email Id Should be Valid"
                              : null,
                          decoration: InputDecoration(
                              hintText: "Email Address",
                              enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.pinkAccent,
                                  )),
                              prefixIcon: Icon(
                                Icons.email,
                                color: Theme
                                    .of(context)
                                    .colorScheme
                                    .secondary,
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          onSaved: (input) =>
                          loginRequestModel?.login_password = input,
                          validator: (input) =>
                          input!.length < 5
                              ? "Password should be more than 5 characters"
                              : null,
                          obscureText: hidePassword,
                          decoration: InputDecoration(
                              hintText: "Password",
                              enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.pinkAccent,
                                  )),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Theme
                                    .of(context)
                                    .colorScheme
                                    .secondary,
                              ),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      hidePassword = !hidePassword;
                                    });
                                  },
                                  color: Theme
                                      .of(context)
                                      .colorScheme
                                      .secondary
                                      .withOpacity(1),
                                  icon: Icon(hidePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility))),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextButton(
                          onPressed: () {
                            if (validateAndSave()) {
                              print(loginRequestModel!.toJson());
                              setState(() {
                                isApiCallProcess = true;
                              });
                              APIService apiService = new APIService();
                              apiService.login(loginRequestModel!).then((
                                  value) => {
                              setState(() {
                              print(loginRequestModel!.toJson());
                              isApiCallProcess=false;
                              }),
                              if(value.token!.isNotEmpty){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                 const SnackBar(
                                  content: Text('LogIn Successfully..'),
                                ),
                              )
                             }else{
                                ScaffoldMessenger.of(context).showSnackBar(
                                   SnackBar(
                                    content: Text("error"),
                                  ),
                                )
                              }
                          }
                            );

                          }
                          },
                          child: const Text(
                            "LogIn",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.deepPurpleAccent),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
