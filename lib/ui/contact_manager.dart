import 'package:afterlogic_test/common/constants.dart';
import 'package:afterlogic_test/data/http/api_login.dart';
import 'package:afterlogic_test/data/repository/storage_token.dart';
import 'package:afterlogic_test/ui/contacts.dart';
import 'package:flutter/material.dart';
import 'package:afterlogic_test/data/repository/local_storage.dart';

class ContactManager extends StatefulWidget {
  ContactManager({Key key}) : super(key: key);

  @override
  _ContactManagerState createState() => _ContactManagerState();
}

class _ContactManagerState extends State<ContactManager> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _Host(),
    );
  }
}

class _Host extends StatefulWidget {
  _Host({Key key}) : super(key: key);

  @override
  __HostState createState() => __HostState();
}

class __HostState extends State<_Host> {
  final hostController = TextEditingController(text: DEFAULT_HOST);
  final emailController =
      TextEditingController(text: "job_applicant@afterlogic.com");
  final passwordController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  bool _isProgressBarActive = false;
  ApiLogin apiLogin = ApiLogin();
  final _storageToken = StorageToken();
  bool _pressedColor = false;

  @override
  void dispose() {
    hostController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: (_isProgressBarActive == true)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                color: Colors.grey[350],
                alignment: Alignment.center,
                child: Form(
                  key: _formKey,
                  child: Center(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      children: <Widget>[
                        Text(LOGIN_PAGE_TITLE,
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.bold)),
                        Padding(
                            padding: EdgeInsets.all(16.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  hintText: HINT_HOST,
                                  labelText: LABEL_HOST),
                              validator: (value) =>
                                  value.isEmpty ? HOST_VALIDATOR : null,
                              controller: hostController,
                            )),
                        Padding(
                            padding: EdgeInsets.all(16.0),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  hintText: HINT_EMAIL,
                                  labelText: LABEL_EMAIL),
                              validator: (value) =>
                                  value.isEmpty ? EMAIL_VALIDATOR : null,
                              controller: emailController,
                            )),
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                                hintText: HINT_PASSWORD, labelText: LABEL_PASSWORD),
                            validator: (value) =>
                                value.isEmpty ? PASSWORD_VALIDATOR : null,
                            controller: passwordController,
                          ),
                        ),
                        ButtonTheme(
                          minWidth: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: 64, left: 16, right: 16),
                            child: RaisedButton(
                              color: _pressedColor
                                  ? Colors.blue
                                  : Colors.grey[400],
                              textColor: Colors.white,
                              disabledColor: Colors.grey[600],
                              disabledTextColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  side: BorderSide(color: Colors.grey[400])),
                              padding: EdgeInsets.all(16),
                              onPressed: () async {
                                setState(() {
                                  _pressedColor = !_pressedColor;
                                });

                                if (_validateForm()) {
                                  setState(() {
                                    _isProgressBarActive = true;
                                  });

                                  var loginResult = await apiLogin.postLogin(
                                      hostController.text,
                                      emailController.text,
                                      passwordController.text);
                                  if (loginResult.authenticatedUserId == 0) {
                                    print("Error code -> ${loginResult.errorCode}");
                                    _scaffoldKey.currentState
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                          "$SNACKBAR_ERROR_MESSAGE ${loginResult.errorCode}"),
                                      duration: Duration(seconds: 10),
                                      action: SnackBarAction(
                                          label: TITLE_SNACKBAR_CLOSE,
                                          onPressed: () {
                                            _scaffoldKey.currentState
                                                .hideCurrentSnackBar();
                                          }),
                                    ));
                                    setState(() {
                                      _isProgressBarActive = false;
                                    });
                                  } else {
                                    _storageToken.saveToken(loginResult.token.authToken);

                                    _localStorage.saveHost(hostController.text);
                                    _localStorage.saveEMail(emailController.text);

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Contacts()));
                                  }
                                }
                              },
                              child: Text(TITLE_LOGIN_BUTTON,
                                  style: TextStyle(fontSize: 18)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  final _localStorage = LocalStorage();

  _validateForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      return true;
    } else {
      return false;
    }
  }

  _getHostFromLocal() async {
    var _host = await _localStorage.getHost();
    return _host;
  }

  String _eMail = "";
  _getEMailFromLocal() async {
    _eMail = await _localStorage.getEMail();
    // return _email;
  }

  Widget _hostLoad(BuildContext context) {
    return FutureBuilder(
      future: _getHostFromLocal(),
      builder: (context, snapshot) {
        // hostController.text =
        //     (snapshot.data != null) ? snapshot.data : DEFAULT_HOST;
        if (snapshot.data != null) {
          hostController.text = snapshot.data;
        }
        return (snapshot.connectionState == ConnectionState.done)
            ? TextFormField(
                decoration: InputDecoration(
                    hintText: HINT_HOST, labelText: LABEL_HOST),
                controller: hostController,
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  Widget _emailLoad(BuildContext context) {
    return FutureBuilder(
      future: _getEMailFromLocal(),
      builder: (context, snapshot) {
        emailController.text = (_eMail != "") ? _eMail : "";
        return (snapshot.connectionState == ConnectionState.done)
            ? TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: HINT_EMAIL, labelText: LABEL_EMAIL),
                controller: emailController,
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
