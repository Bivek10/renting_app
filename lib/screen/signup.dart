import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vehicle_renting_app/model/user_model.dart';
import 'package:vehicle_renting_app/screen/signin.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _auth = FirebaseAuth.instance;
  // form key
  final _formKey = GlobalKey<FormState>();

// editing controller
  final nameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final nameField = TextFormField(
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z0-9]*")),
        FilteringTextInputFormatter.deny(RegExp(r"^[0-9]"))
      ],
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.person_rounded),
          prefixIconColor: Colors.orangeAccent,
          contentPadding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
          labelText: "Username",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
      autofocus: false,
      controller: nameEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("Username cannot be empty");
        }
        if (!regex.hasMatch(value)) {
          return ("Please Enter Valid Username(Minimum 3 characters)");
        }
        return null;
      },
      onSaved: (value) => nameEditingController.text = value!,
      textInputAction: TextInputAction.next,
    );

    // email field
    final emailField = TextFormField(
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.email),
          prefixIconColor: Colors.orangeAccent,
          contentPadding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
          // hintText: "Enter your email address",
          labelText: "Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
      autofocus: false,
      controller: emailEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter your Email");
        }
        // reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please Enter a valid Email");
        }
        return null;
      },
      onSaved: (value) => emailEditingController.text = value!,
      textInputAction: TextInputAction.next,
    );

    // password field
    final passwordField = TextFormField(
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key),
          prefixIconColor: Colors.orangeAccent,
          contentPadding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
          // hintText: "Enter your email address",
          labelText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
      autofocus: false,
      obscureText: true,
      controller: passwordEditingController,
      validator: (value) {
        RegExp regex = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Password is required for login");
        }
        if (!regex.hasMatch(value)) {
          return ("Please Enter Valid Password(Minimum 6 characters)");
        }
        return null;
      },
      onSaved: (value) => passwordEditingController.text = value!,
      textInputAction: TextInputAction.next,
    );

    // confirm password field
    final confirmPasswordField = TextFormField(
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key),
          prefixIconColor: Colors.orangeAccent,
          contentPadding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
          // hintText: "Enter your email address",
          labelText: "Confirm Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
      autofocus: false,
      controller: confirmPasswordEditingController,
      obscureText: true,
      validator: (value) {
        if (confirmPasswordEditingController.text !=
            passwordEditingController.text) {
          return "Password do not match";
        } else {
          return null;
        }
      },
      onSaved: (value) => confirmPasswordEditingController.text = value!,
      textInputAction: TextInputAction.done,
    );

    // sign up button

    final signupButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.orangeAccent,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
        minWidth: MediaQuery.of(context).size.width,
        child: const Text(
          "Sign Up",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          signUp(emailEditingController.text, passwordEditingController.text);
        },
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20.0),
                      nameField,
                      const SizedBox(height: 20.0),
                      emailField,
                      const SizedBox(height: 20.0),
                      passwordField,
                      const SizedBox(height: 20.0),
                      confirmPasswordField,
                      const SizedBox(height: 20.0),
                      signupButton,
                      const SizedBox(height: 20.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account?"),
                          const SizedBox(width: 5.0),
                          GestureDetector(
                            child: const Text(
                              "Sign In",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  decoration: TextDecoration.underline,
                                  color: Colors.blue),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SigninScreen()));
                            },
                          )
                        ],
                      )
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore()});
      Navigator.of(context)
          .pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => SigninScreen()),
              ((route) => false))
          .catchError((e) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Error Message"),
                content: Text(e!.message),
                backgroundColor: Colors.orange,
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.close))
                ],
              );
            });
        // Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailsToFirestore() async {
    // calling our firestore
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    // calling our user model
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();
    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.name = nameEditingController.text;
    // sending rthese values
    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    /*
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Success Message"),
            content: const Text("Account created successfully"),
            backgroundColor: Colors.green,
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.exit_to_app))
            ],
          );
        });
    */
  }
}
