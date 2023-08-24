import 'package:cherry_toast/cherry_toast.dart';
import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'database.dart';
import 'hero_dialog_route.dart';
import 'package:cherry_toast/resources/arrays.dart';

class searchSeries extends StatefulWidget {
  const searchSeries({Key? key}) : super(key: key);

  @override
  State<searchSeries> createState() => _SeriesState();
}

class _SeriesState extends State<searchSeries> {

  bool isSelected = false;
  double h = 180;

  Stream<List<Series>> getSeries() => FirebaseFirestore.instance
  .collection('series')
  .snapshots()
  .map((snapshot) => snapshot.docs.map((series) => Series.fromJson(series.data())).toList()
  );

   Widget series(Series series) {
    if(phrase == '')
    {
      return Container();
    }
    else if(series.name.toString().toLowerCase().contains(phrase.toString().toLowerCase())){
    return Hero(
      tag: series.name,
      child: Material(
        type: MaterialType.transparency,
        child: Container(
                                      child: GestureDetector(
                                        onTap: (){
                                          Navigator.of(context).push(
                                            HeroDialogRoute(
                                              builder: (context) { 
                                                return Material(
        type: MaterialType.transparency,
        surfaceTintColor: Color.fromARGB(255, 0, 169, 247),
          elevation: 50,
          animationDuration: Duration(seconds: 3),
          borderRadius: BorderRadius.circular(25),
          child: Center(
            child: SingleChildScrollView(
              child: Hero(
                            tag: series.name,
                            child: Material(
                                  type: MaterialType.transparency,
                                  child: Container(
                              width: MediaQuery.of(context).size.width * 0.85,
                              child: SingleChildScrollView(
                                child: Column(
                                                  children: [
                                                    SizedBox(height: 10,),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(10),
                                                                  ),
                                                              padding: EdgeInsets.symmetric(
                                                                  horizontal: 20, vertical: 10),
                                                              child: Text(
                                                                      "${series.name}",
                                                                      style: GoogleFonts.caveat(textStyle: const TextStyle(fontSize: 25), color: Color.fromARGB(255, 0, 225, 255)),
                                                                    )
                                                                  ),
                                                        ),
                                                        Container(
                                                                height: 150,
                                                                padding: EdgeInsets.symmetric(
                                                                    horizontal: 50, vertical: 50),
                                                                decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(10),
                                                                    image: DecorationImage(
                                                                        image: NetworkImage(
                                                                            series.poster,))),
                                                              ),
                                                      ]
                                                      ),
                                                      SizedBox(height: 20,),
                                                      
                                                      Container(
                                                        height: MediaQuery.of(context).size.height * 0.6,
                                                        child: ListView.builder(
                                                          shrinkWrap: true,
                                                          itemCount: series.seasons.length,
                                                          itemBuilder:(context, index) {
                                                            return Container(
                                                                height: 210,
                                                                child: Column(
                                                                    children: [
                                                                      Text('Season ${index + 1}',style: GoogleFonts.caveat(textStyle: const TextStyle(fontSize: 25), color: Color.fromARGB(255, 0, 225, 255)),),
                                                                      SizedBox(height: 10,),
                                                                      Container(
                                                                        height: 150,
                                                                        width: 800,
                                                                        child: GridView.builder(
                                                                          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                                                            maxCrossAxisExtent: 120,
                                                                            childAspectRatio: 3/2,
                                                                            crossAxisSpacing: 10,
                                                                            mainAxisSpacing: 10
                                                                            ),
                                                                          
                                                                          shrinkWrap: true,
                                                                          itemCount: series.seasons[index]['episodes'].length,
                                                                          itemBuilder: (context, ind) {
                                                                            return 
                                                                             GestureDetector(
                                                                              onLongPress: () => FlutterClipboard.copy(series.seasons[index]['episodes'][ind]).then((value) => CherryToast.success(borderRadius: 8,title: Text("Link Copied", style: TextStyle(color: Color.fromARGB(255, 18, 221, 248)),),backgroundColor: Color.fromARGB(255, 0, 0, 0),toastPosition: Position.bottom,toastDuration: Duration(seconds: 2, microseconds: 500), animationCurve: Curves.easeInOut, animationType: AnimationType.fromBottom,iconWidget: Icon(Icons.copy_rounded),displayCloseButton: false,).show(context)),
                                                                               child: ActionChip(
                                                                                elevation: 20,
                                                                                surfaceTintColor: Colors.black,
                                                                                shadowColor: Color.fromARGB(255, 0, 225, 255),
                                                                                label: Text('Episode ${ind + 1}',
                                                                                style: GoogleFonts.caveat(textStyle: const TextStyle(fontSize: 18), 
                                                                                color: Color.fromARGB(255, 0, 225, 255)),),
                                                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                                                padding: EdgeInsets.all(0),
                                                                                onPressed: () => launchUrl(Uri.parse(series.seasons[index]['episodes'][ind],), mode: LaunchMode.externalNonBrowserApplication),
                                                                                
                                                                              ),
                                                                             );
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                
                                                              
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                ),
                              ),
                            ),
                          ),
            ),
        ),
          );
                                                }
                                                )
                                                );
                                                },
                                        child: Column(
                                          children: [
                                            SizedBox(height: 10,),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          ),
                                                      padding: EdgeInsets.symmetric(
                                                          horizontal: 20, vertical: 10),
                                                      child: Text(
                                                              "${series.name}",
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
                                                                    series.poster,), fit: BoxFit.fill)),
                                                      ),
                                              ]
                                              ),
                                              SizedBox(height: 20,)
                                          ],
                                        ),
                                      ),
                                  ),
      ),
    );
    }
    else{
      return Container();
    }
  }

  String phrase = '';
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
        title: Text("Search Series", style: GoogleFonts.dancingScript(textStyle: const TextStyle(fontSize: 25)),),
        centerTitle: true,
      ),
      body: 
            Column(
             
              children: [Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: CupertinoTextField(
                  autofocus: true,
                  cursorColor: Color.fromARGB(255, 0, 225, 255),
                  onChanged: (value) {
                    setState(() {
                      phrase = value;
                    });
                  },
                 style: GoogleFonts.caveat(textStyle: const TextStyle(fontSize: 25), color: Color.fromARGB(255, 0, 225, 255)),
                 placeholder: 'Search Series',
                 placeholderStyle: GoogleFonts.caveat(textStyle: const TextStyle(fontSize: 25), color: Color.fromARGB(175, 145, 145, 145)),
                ),
              ),
              SizedBox(height: 20,),
                Expanded(
                  child: StreamBuilder<List<Series>>(
                    stream: getSeries(),
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
                          children: list!.map(series).toList(),
                          
                        );
                      }
                      else
                      {
                        return Center(
                        child: Image.asset('assets/loading.gif'),
                      );
                      }
                      
                    }
                  ),
                ),
              ],
            )
    );
  }
}