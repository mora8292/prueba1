import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/storage/storage_service.dart';
import 'package:provider/provider.dart';

class ImagePost extends StatelessWidget {
  final String imageUrl;
  const ImagePost({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Consumer<StorageService>(
      builder: (context, storageService, child) => Container(
        decoration: BoxDecoration(color: Colors.grey),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            //delete button
            IconButton(
              onPressed: ()=> storageService.deleteImages(imageUrl), 
              icon: const Icon(Icons.delete),
            ),
            Image.network(
              imageUrl,
              fit: BoxFit.fitWidth,
              loadingBuilder: (context, child, loadingProgress) {
                //loading
                if (loadingProgress!= null) {
                  return SizedBox(
                    height: 300,
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded / 
                        loadingProgress.expectedTotalBytes! 
                        : null,
                      ),
                    ),
                  );
                } else{
                  return child;
                }
              },
              ),
          ],
        ),
      )
    );
  }
}