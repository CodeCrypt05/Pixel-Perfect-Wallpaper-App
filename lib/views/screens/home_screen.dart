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
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text('Anime Heaven Wallpaper')),
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
                                ? Color.fromARGB(255, 0, 0, 0)
                                : Color.fromARGB(255, 240, 240, 240),
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
