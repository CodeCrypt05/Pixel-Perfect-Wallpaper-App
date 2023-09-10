import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixel_perfect_wallpaper_app/data/tabs_list.dart';
import 'package:pixel_perfect_wallpaper_app/views/screens/tabs/all_collectio.dart';
import 'package:pixel_perfect_wallpaper_app/views/screens/tabs/animal_collection_tab.dart';
import 'package:pixel_perfect_wallpaper_app/views/screens/tabs/art_collection_tab.dart';
import 'package:pixel_perfect_wallpaper_app/views/screens/tabs/creative_collection_tab.dart';
import 'package:pixel_perfect_wallpaper_app/views/screens/tabs/nature_collection_tab.dart';
import 'package:pixel_perfect_wallpaper_app/views/screens/tabs/trending_tab.dart';
import 'package:pixel_perfect_wallpaper_app/widgets/search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            size: 30.0,
          ),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer(); // Open the drawer
          },
        ),
        title: const Text('Pixel Perfect Wallpaper'),
        toolbarHeight: 70, // Adjust the height as needed
      ),
      drawer: const NavigationDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: size.width,
            height: size.height * 0.06,
            child: const SearchBarWidget(),
            // color: Colors.amber,
          ),
          tabs(size),
          Flexible(
            flex: 99,
            child: displayScreens(),
          ),
        ],
      ),
    );
  }

  Widget displayScreens() {
    if (current == 1) {
      return const CreativeCollectionTab();
    } else if (current == 2) {
      return const NatureCollectionTab();
    } else if (current == 3) {
      return const AnimalCollectionTab();
    } else if (current == 4) {
      return const ArtCollectioDart();
    } else if (current == 5) {
      return const AllCollections();
    }
    return const TrendingTab();
  }

  Widget tabs(Size size) {
    return Container(
      width: size.width,
      height: size.height * 0.078,
      margin: const EdgeInsets.only(left: 18, right: 18),
      child: Column(
        children: [
          /// CUSTOM TABBAR
          SizedBox(
            width: size.width,
            height: size.height * 0.064,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: items.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            current = index;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.all(5),
                          width: 80,
                          height: 45,
                          decoration: BoxDecoration(
                            color: current == index
                                ? const Color.fromARGB(255, 0, 0, 0)
                                : const Color.fromARGB(255, 240, 240, 240),
                            borderRadius: current == index
                                ? BorderRadius.circular(28)
                                : BorderRadius.circular(28),
                          ),
                          child: Center(
                            child: Text(
                              items[index],
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w500,
                                  color: current == index
                                      ? Colors.white
                                      : Colors.grey),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildHeader(context),
              buildMenu(context),
            ],
          ),
        ),
      );

  Widget buildHeader(BuildContext context) => Container(
        color: Colors.white,
        padding: EdgeInsets.only(
          top: 24 + MediaQuery.of(context).padding.top,
          bottom: 24,
        ),
        child: const Column(
          children: [
            CircleAvatar(
              radius: 52,
              backgroundImage: AssetImage("assets/images/logo.png"),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Pixel Perfect Wallpaper",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );

  Widget buildMenu(BuildContext context) => Column(
        children: [
          ListTile(
            leading: const Icon(Icons.star_border_outlined),
            title: const Text('Rate This App'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.share_outlined),
            title: const Text('Share App'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About Us'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: const Text('Privacy Policy'),
            onTap: () {},
          ),
        ],
      );
}
