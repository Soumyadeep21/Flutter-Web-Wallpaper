import 'dart:convert';

import 'package:flutter_web/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_web/full_screen.dart';

class displayWallpaper extends StatefulWidget {
  String url;
  displayWallpaper(this.url);

  @override
  displayWallpaperState createState() {
    return new displayWallpaperState();
  }
}

class displayWallpaperState extends State<displayWallpaper> with AutomaticKeepAliveClientMixin{

  //String url = "https://pixabay.com/api/?key=11308358-67ad92507710cb90567e4924c&q=sports+car&image_type=photo&pretty=true";
  bool isDataLoaded = false;
  List data;

  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async{
    var response = await http.get(
      Uri.encodeFull(widget.url),
    );
    print(response.body);
    setState(() {
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['hits'];
      isDataLoaded = true;
    });
    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    if(isDataLoaded)
      // return Container(
      //   color: Colors.black,
      //   child: StaggeredGridView.countBuilder(
      //     addAutomaticKeepAlives: true,
      //     padding: EdgeInsets.all(4.0),
      //     crossAxisCount: 4,
      //     itemCount: data.length,
      //     itemBuilder: (context,i){
      //       String imgPath = data[i]['largeImageURL'];
      //       return Material(
      //         clipBehavior: Clip.antiAlias,
      //         borderRadius: BorderRadius.circular(10.0),
      //         child: InkWell(
      //           child: Hero(
      //               tag: imgPath,
      //               child: CachedNetworkImage(
      //                   fit: BoxFit.cover,
      //                   placeholder: Image.asset('images/place_holder.png'),
      //                   errorWidget: Icon(Icons.error),
      //                   imageUrl: imgPath,
      //               )
      //           ),
      //           onTap: (){
      //             Navigator.of(context).push(
      //                 MaterialPageRoute(builder: (context)=> FullScreenImagePage(imgPath))
      //             );
      //           },
      //         ),
      //       );
      //     },
      //     staggeredTileBuilder: (i)=> StaggeredTile.count(2, i.isEven ? 2 : 3),
      //     mainAxisSpacing: 8.0,
      //     crossAxisSpacing: 8.0,
      //   ),
      // );
      return Container(
        color: Colors.black,
        child: GridView.builder(
          addAutomaticKeepAlives: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemCount: data.length,
          itemBuilder: (context,i){
            String imgPath = data[i]['largeImageURL'];
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: Material(
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(10.0),
                child: InkWell(
                  child: Hero(
                      tag: imgPath,
                      child: Image.network(imgPath,fit: BoxFit.cover,)
                      ),
                  onTap: (){
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context)=> FullScreenImagePage(imgPath))
                    );
                  },
                ),
              ),
            );
          },

        ),
      );
    else
      return Container(
          child: Center(
              child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.yellowAccent)
              )
          ),
          color: Colors.black,
      );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}