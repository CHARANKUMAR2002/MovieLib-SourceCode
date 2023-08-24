import 'package:cherry_toast/resources/arrays.dart';
import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'database.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  Stream<List<Movies>> getMovies() => FirebaseFirestore.instance
  .collection('movies')
  .snapshots()
  .map((snapshot) => snapshot.docs.map((movie) => Movies.fromJson(movie.data())).toList()
  );


  Widget movie(Movies movie) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
                        children: [
                          InkWell(
                            onLongPress: () => FlutterClipboard.copy(movie.url).then((value) => CherryToast.success(borderRadius: 8,title: Text("${movie.name} Movie Link Copied", style: TextStyle(color: Color.fromARGB(255, 18, 221, 248)),),backgroundColor: Color.fromARGB(255, 0, 0, 0),toastPosition: Position.bottom,toastDuration: Duration(seconds: 2, microseconds: 500), animationCurve: Curves.easeInOut,animationType: AnimationType.fromBottom,iconWidget: Icon(Icons.copy_rounded),displayCloseButton: false,).show(context)),
                              splashColor: Color.fromARGB(130, 1, 92, 104),
                              onTap: () => launchUrl(Uri.parse(movie.url), mode: LaunchMode.externalNonBrowserApplication),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        child: Text(
                                                movie.name,
                                                style: GoogleFonts.caveat(textStyle: const TextStyle(fontSize: 25), color: Color.fromARGB(255, 0, 225, 255)),
                                              )
                                            ),
                                  ),
                                  Container(
                                          height: 150,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 50, vertical: 50),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      movie.poster,), fit: BoxFit.fill)),
                                        ),
                                ]
                                ),
                            ),
                            ],
                          ),
    );
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
        title: Text("MoviesLib", style: GoogleFonts.dancingScript(textStyle: const TextStyle(fontSize: 25)),),
        centerTitle: true,
      ),
      body: 
            StreamBuilder<List<Movies>>(
              stream: getMovies(),
              builder: (context,  snapshot) {
                
                if(snapshot.hasError)
                {
                  return Center(
                    child: AlertDialog(
                      content: Text("Something Went Wrong",style: GoogleFonts.caveat(textStyle: const TextStyle(fontSize: 25), color: Color.fromARGB(255, 0, 225, 255)),),
                      actions: [
                        Text('')
                      ],
                    ),
                  );
                }
                else if (snapshot.hasData)
                {
                  final list = snapshot.data;
                  
                  return ListView(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    shrinkWrap: true,
                    children: list!.map(movie).toList(),
                  );
                }
                else
                {
                  return Center(
                  child: Image.asset('assets/loading.gif'),
                );
                }
              }
            )
    );
  }  
}
