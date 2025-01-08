import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text;
  final String profilePictureUrl;
  final void Function()? onTap;
  const UserTile({super.key, required this.text, this.onTap, required this.profilePictureUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(color: Color.fromARGB(201, 249, 7, 63),
        borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
             CircleAvatar(
              backgroundImage: NetworkImage(profilePictureUrl),
              radius: 25, // Tamaño del avatar
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}