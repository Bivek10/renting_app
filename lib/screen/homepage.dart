import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_renting_app/screen/bookdetail.dart';
import 'package:vehicle_renting_app/screen/createbook.dart';
import 'package:vehicle_renting_app/screen/notificationscreen.dart';
import 'package:vehicle_renting_app/screen/signin.dart';
import 'package:vehicle_renting_app/screen/updatebook.dart';

import '../model/user_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    // FirebaseFirestore.instance
    //     .collection("users")
    //     .doc(user!.uid)
    //     .get()
    //     .then((value) {
    //   loggedInUser = UserModel.fromMap(value.data());
    //   setState(() {
    //     loggedInUser = loggedInUser;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    print("${user!.uid}");
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Booking(userId: user!.uid),
            ),
          );
        },
        child: const Icon(Icons.book),
      ),
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        elevation: 0.0,
        leading: Icon(
          Icons.menu,
          color: Colors.blue,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications,
              color: Colors.blue,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const notificationscreen()));
            },
          ),
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SigninScreen()));
              },
              icon: const Icon(Icons.logout, color: Colors.blue))
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .collection('books')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            List<DocumentSnapshot> book = snapshot.data!.docs;

            //return Text(documentSnapshot[0].data().toString());

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                  children: List.generate(book.length, (index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: ((context) {
                      return bookdetail(
                        userId: user!.uid,
                        name: book[index]["username"],
                        description: book[index]['description'],
                        createdDate: book[index]['createdDate'],
                        createdTime: book[index]['createdTime'],
                      );
                    })));
                  },
                  child: Card(
                    elevation: 5.0,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                              child: Image.asset(
                                  "assets/images/sikshyatechnology.jpg")),
                          iconColor: Colors.black,
                          title: Text(
                            book[index]['username'],
                            style: const TextStyle(
                                color: Colors.black, fontSize: 30.0),
                          ),
                          subtitle: Text(
                            book[index]['description'],
                            style: TextStyle(
                                fontSize: 20.0, color: Colors.grey[700]),
                          ),
                          isThreeLine: true,
                        ),
                        Container(
                            padding: const EdgeInsets.all(10.0),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                    // elevation: 3.0,
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => updatebook(
                                                    userId: user!.uid,
                                                    bookId: book[index].id,
                                                    name: book[index]
                                                        ['username'],
                                                    description: book[index]
                                                        ['description'],
                                                    createdDate: book[index]
                                                        ['createdDate'],
                                                    createdTime: book[index]
                                                        ['createdTime'],
                                                  )));
                                    },
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                    // color: Colors.green,
                                  ),
                                  ElevatedButton(
                                    //elevation: 3.0,
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(user!.uid)
                                          .collection('books')
                                          .doc(book[index].id)
                                          .delete();
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                    //  color: Colors.orangeAccent,
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                );
              })
                  /*
                children: snapshot.data!.docs.map((book) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: ((context) {
                        return bookdetail(
                          userId: loggedInUser.uid!,
                          name: book['name'],
                          description: book['description'],
                          createdDate: book['createdDate'],
                          createdTime: book['createdTime'],
                        );
                      })));
                    },
                    child: Card(
                      elevation: 5.0,
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                                child: Image.asset(
                                    "assets/images/sikshyatechnology.jpg")),
                            iconColor: Colors.black,
                            title: Text(
                              book['name'],
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 30.0),
                            ),
                            subtitle: Text(
                              book['description'],
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.grey[700]),
                            ),
                            isThreeLine: true,
                          ),
                          Container(
                              padding: const EdgeInsets.all(10.0),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                      // elevation: 3.0,
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    updatebook(
                                                      userId: loggedInUser.uid,
                                                      bookId: book.id,
                                                      name: book['name'],
                                                      description:
                                                          book['description'],
                                                      createdDate:
                                                          book['createdDate'],
                                                      createdTime:
                                                          book['createdTime'],
                                                    )));
                                      },
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                      // color: Colors.green,
                                    ),
                                    ElevatedButton(
                                      //elevation: 3.0,
                                      onPressed: () {
                                        FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(loggedInUser.uid)
                                            .collection('books')
                                            .doc(book.id)
                                            .delete();
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                      //  color: Colors.orangeAccent,
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  );
                }).toList(),
               */
                  ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.blue,
            ),
          );
        },
      ),
    );
  }
}
