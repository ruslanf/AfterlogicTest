import 'package:afterlogic_test/data/http/api_client.dart';
import 'package:afterlogic_test/data/models/login_token.dart';
import 'package:afterlogic_test/ui/contacts.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:afterlogic_test/common/globals.dart' as global;
import 'package:afterlogic_test/data/repository/local_storage.dart';

class ContactManager extends StatefulWidget {
  ContactManager({Key key, this.title}) : super(key: key);

  final String title;

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
  final hostController = TextEditingController(text: "test.afterlogic.com");
  final emailController = TextEditingController(text: "job_applicant@afterlogic.com");
  final passwordController = TextEditingController();

  Future<bool> saveResult;

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
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          color: Colors.grey[350],
          alignment: Alignment.center,
          child: Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              children: <Widget>[
                Text("Contacts Manager",
                    style:
                        TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: "Without https://", labelText: "Host"),
                    controller: hostController,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: "xxx@afterlogic.com", labelText: "Email"),
                    controller: emailController,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: "Your pass", labelText: "Password"),
                    controller: passwordController,
                  ),
                ),
                ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: EdgeInsets.only(top: 64, left: 16, right: 16),
                    child: FlatButton(
                      color: Colors.grey[400],
                      textColor: Colors.white,
                      disabledColor: Colors.grey[600],
                      disabledTextColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                          side: BorderSide(color: Colors.grey[400])),
                      padding: EdgeInsets.all(16),
                      onPressed: () async {
                        LoginToken loginResult = await postLogin(
                            hostController.text,
                            emailController.text,
                            passwordController.text);
                        String token = loginResult.token.authToken;
                        saveResult = LocalStorage().saveHost(hostController.text);
                        
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Contacts(token: token)));
                      },
                      child: Text("Login", style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getHostFromLocal() async {
    var _host = await LocalStorage().getHost();
    return _host;
  }
}
