import 'package:flutter/material.dart';
import 'package:pixel_perfect_wallpaper_app/views/screens/about_us_screen.dart';
import 'package:share_plus/share_plus.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 52,
                  backgroundImage: AssetImage("assets/images/logo.png"),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Pixel Perfect Wallpapers",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.star_border_outlined),
            title: const Text('Rate This App'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.share_outlined),
            title: const Text('Share App'),
            onTap: () {
              Navigator.pop(context);
              Share.share("Here you have to put your app link");
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About Us'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AbpoutUsScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: const Text('Privacy Policy'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
