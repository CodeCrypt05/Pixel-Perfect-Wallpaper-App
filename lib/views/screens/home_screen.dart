import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixel_perfect_wallpaper_app/data/tabs_list.dart';
import 'package:pixel_perfect_wallpaper_app/views/tabs/anime_tab.dart';
import 'package:pixel_perfect_wallpaper_app/views/tabs/favorite_tab.dart';
import 'package:pixel_perfect_wallpaper_app/views/tabs/genre_tab.dart';
import 'package:pixel_perfect_wallpaper_app/views/tabs/trending_tab.dart';
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
        title: const Text('Anime Heaven Wallpaper'),
        actions: const [
          Padding(
            padding:
                EdgeInsets.only(right: 16.0), // Adjust the padding as needed
            child: Icon(
              Icons.favorite,
            ),
          )
        ],
        toolbarHeight: 70, // Adjust the height as needed
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const UserAccountsDrawerHeader(
              accountName: Center(
                child: Text(
                  'Anime Haven Wallpaper',
                  style: TextStyle(color: Colors.black, fontSize: 15.0),
                ),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage(
                    'assets/images/lakes.jpg'), // Replace with your image asset
              ),
              decoration: BoxDecoration(
                color: Colors.white, // Set the background color of the header
              ),
              accountEmail: null,
            ),
            ListTile(
              title: Text('Share App'),
              onTap: () {
                // Handle menu item 2 tap
              },
            ),
            ListTile(
              title: Text('Privacy Policy'),
              onTap: () {
                // Handle menu item 1 tap
              },
            ),
            ListTile(
              title: Text('Notification'),
              onTap: () {
                // Handle menu item 2 tap
              },
            ),
            // Add more menu items as needed
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: size.width,
            height: size.height * 0.06,
            child: SearchBarWidget(),
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
      return const AnimeTab();
    } else if (current == 2) {
      return const GenreTab();
    } else if (current == 3) {
      return const FavoriteTab();
    }
    return const TrendingTab();
  }

  Widget tabs(Size size) {
    return Container(
      width: size.width,
      height: size.height * 0.07,
      margin: const EdgeInsets.only(left: 18, right: 18),
      child: Column(
        children: [
          /// CUSTOM TABBAR
          SizedBox(
            width: size.width,
            height: size.height * 0.07,
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
