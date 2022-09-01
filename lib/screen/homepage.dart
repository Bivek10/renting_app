import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    double width = MediaQuery.of(context).size.width;
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
            return GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
              childAspectRatio: 1 / 1.45,
              children: List.generate(book.length, (index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
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
                    child: Container(
                      decoration: BoxDecoration(
                        color:
                            Color.fromARGB(255, 240, 165, 44).withOpacity(0.4),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 8,
                          right: 8,
                          top: 8,
                          bottom: 4,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 100,
                              width: width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: AssetImage(
                                    "assets/images/ford1.png",
                                  ),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                book[index]["username"],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: GoogleFonts.roboto(
                                  textStyle:
                                      Theme.of(context).textTheme.headline4,
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Description: ",
                                        style: GoogleFonts.roboto(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w800,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                      Row(
                                        //mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.timer,
                                            color: Colors.orangeAccent,
                                            size: 15,
                                          ),
                                          Text(
                                            book[index]['description'],
                                            style: GoogleFonts.roboto(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .headline4,
                                              fontSize: 13,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w800,
                                              fontStyle: FontStyle.normal,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                /*
                                Expanded(
                                  flex: 5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Close At",
                                        style: GoogleFonts.roboto(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w800,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Icon(
                                            Icons.timer,
                                            color: Colors.orangeAccent,
                                            size: 14,
                                          ),
                                          Text(
                                            centerdata["close"],
                                            style: GoogleFonts.roboto(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .headline4,
                                              fontSize: 13,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontStyle: FontStyle.normal,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              */
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.orangeAccent,
                                    size: 15,
                                  ),
                                  Expanded(
                                    child: Text(
                                      book[index]["title"],
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.roboto(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                        fontSize: 13,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w800,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(user!.uid)
                                        .collection('books')
                                        .doc(book[index].id)
                                        .delete();
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: InkWell(
                                      onTap: () async {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    updatebook(
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
                                      child: Chip(
                                        backgroundColor: Colors.white,
                                        label: Text(
                                          "update",
                                          style: GoogleFonts.roboto(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .headline4,
                                            fontSize: 13,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w800,
                                            fontStyle: FontStyle.normal,
                                          ),
                                        ),
                                        deleteIcon: CircleAvatar(
                                          radius: 20,
                                          backgroundColor:
                                              Color.fromARGB(255, 233, 132, 30),
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                            size: 15,
                                          ),
                                        ),
                                        onDeleted: () async {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      updatebook(
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
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            );
            //return Text(documentSnapshot[0].data().toString());
            /*
            return Padding(
              padding: const EdgeInsets.all(8.0),
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
                    elevation: 2.0,
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
                                color: Colors.black, fontSize: 20.0),
                          ),
                          subtitle: Text(
                            book[index]['description'],
                            style: TextStyle(
                                fontSize: 15.0, color: Colors.grey[700]),
                          ),
                        ),
                        
                        Container(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  // elevation: 3.0,
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => updatebook(
                                                  userId: user!.uid,
                                                  bookId: book[index].id,
                                                  name: book[index]['username'],
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
                            )),
                      
                      ],
                    ),
                  ),
                );
              })),
            );
            */
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
