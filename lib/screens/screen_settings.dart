import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/my_list_tile.dart';

class ScreenSettings extends StatelessWidget {
  final void Function()? onProfileTap;
  final void Function()? onSingOut;
  const ScreenSettings({super.key, required this.onProfileTap, required this.onSingOut});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          //header
          DrawerHeader(
            child: Icon(
              Icons.person,
              color: Colors.black,
              size: 64,
              )
            ),

          //home list tile
          MyListTile(
            icon: Icons.home, 
            text: 'H O M E',
            onTap: () => Navigator.pop(context),
            ),

          //profile list tile
            MyListTile(
            icon: Icons.person, 
            text: 'P R O F I L E',
            onTap: onProfileTap,
            ),

          //logout list tile
          MyListTile(
            icon: Icons.logout, 
            text: 'L O G O U T',
            onTap: onSingOut,
            ),
        ],
      ),
    );
  }
  
}