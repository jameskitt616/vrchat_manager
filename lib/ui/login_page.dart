import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../service/auth/auth.dart';
import 'home_temp.dart';

//TODO: add 2FA handling
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _hidePassword = true;
  bool _nowLoading = false;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Log in'),
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                  child: ConstrainedBox(
                      constraints:
                      BoxConstraints(minHeight: constraints.maxHeight),
                      child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  TextField(
                                    controller: usernameController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(8.0),
                                      ),
                                      labelText: 'Username/Email',
                                    ),
                                  ),
                                  const SizedBox(height: 24.0),
                                  TextField(
                                      obscureText: _hidePassword,
                                      controller: passwordController,
                                      decoration: InputDecoration(
                                          labelText: 'Password',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(8.0),
                                          ),
                                          suffixIcon: IconButton(
                                            icon: Icon(_hidePassword
                                                ? FontAwesomeIcons.solidEye
                                                : FontAwesomeIcons
                                                .solidEyeSlash),
                                            onPressed: () {
                                              setState(() {
                                                _hidePassword = !_hidePassword;
                                              });
                                            },
                                          ))),
                                ],
                              ),
                              Container(
                                  width: double.infinity,
                                  height: 54.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        if (Text(usernameController.text)
                                            .data ==
                                            '' ||
                                            Text(passwordController.text)
                                                .data ==
                                                '') {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return const AlertDialog(
                                                content:
                                                Text('Cannot be empty'),
                                              );
                                            },
                                          );
                                          return;
                                        }
                                        setState(() {
                                          _nowLoading = true;
                                        });
                                        login(
                                            Text(usernameController.text)
                                                .data!,
                                            Text(passwordController.text)
                                                .data!)
                                            .then((result) {
                                          if (result) {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) {
                                                      return const HomePage();
                                                    }));
                                          } else {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return const AlertDialog(
                                                  content: Text('Login failed'),
                                                );
                                              },
                                            );
                                            setState(() {
                                              _nowLoading = false;
                                            });
                                          }
                                        });
                                      },
                                      style: ButtonStyle(
                                          backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.blue)),
                                      child: _nowLoading
                                          ? Padding(
                                        padding:
                                        const EdgeInsets.all(5.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Text('Login'),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            SizedBox(
                                              height: 20,
                                              width: 20,
                                              child:
                                              CircularProgressIndicator(
                                                valueColor:
                                                AlwaysStoppedAnimation(
                                                    Colors.white),
                                                backgroundColor:
                                                Colors.blue,
                                                strokeWidth: 3,
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                          : const Text('Login'))),
                            ],
                          ))));
            },
          ),
        ));
  }
}
