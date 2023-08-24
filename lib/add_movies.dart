import 'package:cherry_toast/cherry_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_fonts/google_fonts.dart';

class addMovies extends StatefulWidget {
  const addMovies({Key? key}) : super(key: key);

  @override
  State<addMovies> createState() => _addMoviesState();
}

class _addMoviesState extends State<addMovies> {

  TextEditingController title = TextEditingController();
  TextEditingController link = TextEditingController();
  TextEditingController poster = TextEditingController();

  Future upload({required String t, required String l, required String p}) async
  {
    if(t == '')
    {
      CherryToast.error(borderRadius: 8,title: Text("Please Provide Movie Title"),backgroundColor: Color.fromARGB(255, 0, 0, 0),toastPosition: Position.bottom,toastDuration: Duration(seconds: 2), animationCurve: Curves.easeInOut,animationType: AnimationType.fromBottom,displayCloseButton: false,enableIconAnimation: true,).show(context);
    }
    else if(l == '')
    {
      CherryToast.error(borderRadius: 8,title: Text("Please Provide Movie Movie Link"),backgroundColor: Color.fromARGB(255, 0, 0, 0),toastPosition: Position.bottom,toastDuration: Duration(seconds: 2), animationCurve: Curves.easeInOut,animationType: AnimationType.fromBottom,displayCloseButton: false,enableIconAnimation: true,).show(context);
    }
    else if(p == '')
    {
      CherryToast.error(borderRadius: 8,title: Text("Please Provide Poster Movie Link"),backgroundColor: Color.fromARGB(255, 0, 0, 0),toastPosition: Position.bottom,toastDuration: Duration(seconds: 2), animationCurve: Curves.easeInOut,animationType: AnimationType.fromBottom,enableIconAnimation: true,displayCloseButton: false,).show(context);
    }
    else{
    final addMovie = await FirebaseFirestore.instance.collection('movies').doc();

    final format = {
      'name' : t,
      'url': l,
      'poster': p
    };

    CherryToast.success(borderRadius: 8,title: Text("${t} Uploaded Successfully"),backgroundColor: Color.fromARGB(255, 76, 76, 76),toastPosition: Position.bottom,toastDuration: Duration(seconds: 2,), animationCurve: Curves.easeInOut,animationType: AnimationType.fromBottom,displayCloseButton: false,enableIconAnimation: true,).show(context);

    await addMovie.set(format);
    setState(() {
      title.text = '';
      link.text = '';
      poster.text = '';
    });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
        title: Text("Add Movies", style: GoogleFonts.dancingScript(textStyle: const TextStyle(fontSize: 25)),),
        centerTitle: true,
      ),
      body:
          SingleChildScrollView(
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
                child:
                    GlassmorphicContainer(
                      border: 1,
                      blur: 50,
                      linearGradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 255, 255, 255).withOpacity(0.2),
                  Color.fromARGB(132, 244, 242, 242).withOpacity(0.2)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
            borderGradient: LinearGradient(colors: [
              Colors.white24.withOpacity(0.2),
              Colors.white70.withOpacity(0.2)
            ]),
                      borderRadius: 8,
                          height: 600,
                          width: 500,
                          child: Container(
                             padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                            child: Column(
                              children: [
                                SizedBox(height: 15.5,),
                                CircleAvatar(
                                  foregroundImage: AssetImage('assets/cinema.gif'),
                                  radius: 80,
                                ),
                                SizedBox(height: 15.5,),
                                TextField(
                                  controller: title,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.abc),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      ),
                                      hintText: "Movie Title",
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                          color: Color.fromARGB(255, 5, 200, 226),
                                          width: 2.0,
                                          ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                          color: Color.fromARGB(255, 23, 42, 249),
                                          width: 2.0,
                                          ),
                                      ),
                                  ),
                                ),
                                SizedBox(height: 35,),TextField(
                                  controller: link,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.movie),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      ),
                                      hintText: "Movie Link",
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                          color: Color.fromARGB(255, 5, 200, 226),
                                          width: 2.0,
                                          ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                          color: Color.fromARGB(255, 23, 42, 249),
                                          width: 2.0,
                                          ),
                                      ),
                                  ),
                                ),
                                SizedBox(height: 35,),
                                TextField(
                                  controller: poster,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.photo_size_select_actual_rounded),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      ),
                                      hintText: "Movie Poster Link",
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                          color: Color.fromARGB(255, 5, 200, 226),
                                          width: 2.0,
                                          ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                          color: Color.fromARGB(255, 23, 42, 249),
                                          width: 2.0,
                                          ),
                                      ),
                                  ),
                                ),
                                SizedBox(height: 35,),
                                InkWell(
                                  splashColor: Colors.cyan,
                                  onTap: () => upload(t: title.text, l: link.text, p: poster.text),
                                  child: Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(230, 242, 0, 255),
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  height: 50,
                                  width: 130,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 90,
                                        height: 50,
                                        decoration: BoxDecoration(
                                    color: Color.fromARGB(156, 0, 200, 255),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight:  Radius.circular(15),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 20, top: 8, bottom: 8),
                                    child:
                                      Text(
                                      "Upload",
                                      style: GoogleFonts.caveat(textStyle: const TextStyle(fontSize: 25)),
                                      overflow: TextOverflow.clip,
                                      
                                      ),
                                    ),
                                      ),
                                      Padding(padding: EdgeInsets.only(left: 10),),
                                      Icon(
                                        Icons.cloud_upload_rounded,
                                        size: 25,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                ),
              ),
            ),
          ),
    );
  }
}