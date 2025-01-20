import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/image_post.dart';
import 'package:flutter_application_1/services/storage/storage_service.dart';
import 'package:provider/provider.dart';

class TabNews extends StatefulWidget {
  const TabNews({super.key});

  @override
  State<TabNews> createState() => _TabNewsState();
}

class _TabNewsState extends State<TabNews> {

  @override
  void initState() {
    super.initState();

    fetchImages();
  }

  //fetch images
  Future<void>fetchImages() async{
    await Provider.of<StorageService>(context, listen: false).fetchImages();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<StorageService>(
      builder: (context, storageService, child){
      
      //ñist of image urls
      final List<String> imageUrls=storageService.imageUrls;
      
      //home page UI
      return Scaffold(
        appBar: AppBar(
          title: Center(child: Text(storageService.isUploading? 'Uploading...': 'News')),
        ),
       floatingActionButton: FloatingActionButton(
        onPressed: ()=> storageService.uploadImage(),
        child: Icon(Icons.add),
       ),
       body: ListView.builder(
        itemCount: imageUrls.length,
        itemBuilder: (context, index){
          //get each individual image
          final String imageUrl=imageUrls[index];

          //image post ui
          return ImagePost(imageUrl: imageUrl);
        },
       ),
      );
    },);
  }
}