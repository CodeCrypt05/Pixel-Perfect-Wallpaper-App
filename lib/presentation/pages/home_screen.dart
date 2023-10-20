import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixel_perfect_wallpaper_app/data/dummy_data/tabs_list.dart';
import 'package:pixel_perfect_wallpaper_app/presentation/pages/about_us_screen.dart';
import 'package:pixel_perfect_wallpaper_app/presentation/tabs/animal_collection_tab.dart';
import 'package:pixel_perfect_wallpaper_app/presentation/tabs/art_collection_tab.dart';
import 'package:pixel_perfect_wallpaper_app/presentation/tabs/creative_collection_tab.dart';
import 'package:pixel_perfect_wallpaper_app/presentation/tabs/nature_collection_tab.dart';
import 'package:pixel_perfect_wallpaper_app/presentation/tabs/trending_tab.dart';
import 'package:pixel_perfect_wallpaper_app/presentation/widgets/search_bar.dart';
import 'package:pixel_perfect_wallpaper_app/presentation/widgets/show_toast.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

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
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
          child: IconButton(
            icon: const Icon(
              Icons.menu,
              size: 30.0,
              color: Colors.black,
            ),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer(); // Open the drawer
            },
          ),
        ),
        title: const Text('Pixel Perfect Wallpapers'),
        centerTitle: true,
        toolbarHeight: 70,
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
    }
    return const TrendingTab();
  }

  Widget tabs(Size size) {
    return Container(
      width: size.width,
      height: size.height * 0.078,
      margin: const EdgeInsets.only(left: 18, right: 18),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: items.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;

            return GestureDetector(
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
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Center(
                  child: Text(
                    item,
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      color: current == index ? Colors.white : Colors.grey,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // CUSTOM TABBAR
  // Widget tabs(Size size) {
  //   return Container(
  //     width: size.width,
  //     height: size.height * 0.078,
  //     margin: const EdgeInsets.only(left: 18, right: 18),
  //     child: Column(
  //       children: [
  //         SizedBox(
  //           width: size.width,
  //           height: size.height * 0.064,
  //           child: ListView.builder(
  //               physics: const BouncingScrollPhysics(),
  //               itemCount: items.length,
  //               scrollDirection: Axis.horizontal,
  //               itemBuilder: (ctx, index) {
  //                 return Column(
  //                   mainAxisAlignment: MainAxisAlignment.end,
  //                   children: [
  //                     GestureDetector(
  //                       onTap: () {
  //                         setState(() {
  //                           current = index;
  //                         });
  //                       },
  //                       child: AnimatedContainer(
  //                         duration: const Duration(milliseconds: 300),
  //                         margin: const EdgeInsets.all(5),
  //                         width: 80,
  //                         height: 45,
  //                         decoration: BoxDecoration(
  //                           color: current == index
  //                               ? const Color.fromARGB(255, 0, 0, 0)
  //                               : const Color.fromARGB(255, 240, 240, 240),
  //                           borderRadius: current == index
  //                               ? BorderRadius.circular(28)
  //                               : BorderRadius.circular(28),
  //                         ),
  //                         child: Center(
  //                           child: Text(
  //                             items[index],
  //                             style: GoogleFonts.roboto(
  //                                 fontWeight: FontWeight.w500,
  //                                 color: current == index
  //                                     ? Colors.white
  //                                     : Colors.grey),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 );
  //               }),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}

// Another Navigation Drawer Class
class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({super.key});

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  ShowToast toast = const ShowToast();
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
              radius: 55,
              backgroundImage: AssetImage("assets/images/logo.png"),
            ),
            SizedBox(
              height: 12,
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

  bool isDarkModeEnabled = false;

  Widget buildMenu(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.star_border_outlined),
          title: const Text('Rate This App'),
          onTap: _showRatingAppDialog,
        ),
        ListTile(
          leading: const Icon(Icons.share_outlined),
          title: const Text('Share App'),
          onTap: () {
            Navigator.pop(context);
            _onShare(context);
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
                builder: (context) => const AbpoutUsScreen(),
              ),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.privacy_tip_outlined),
          title: const Text('Privacy Policy'),
          onTap: _launchURL,
        ),
      ],
    );
  }

  // Share My app function
  void _onShare(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    await Share.share("Hello World",
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }

  // Privacy Policy Function
  final Uri url = Uri.parse(
      'https://sites.google.com/view/pixel-perfect-wallpaper-app/home');

  void _launchURL() async {
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

  // Rate Us Function
  void _showRatingAppDialog() {
    final ratingDialog = RatingDialog(
      starSize: 28,
      starColor: Colors.amber,
      title: const Text(
        'Are you enjoying our app?',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      message: const Text(
          textAlign: TextAlign.center,
          'Please give us 5-stars if you like & let us know your feedback',
          style: TextStyle(fontSize: 14)),
      image: Image.asset(
        "assets/images/logo.png",
        height: 80,
      ),
      enableComment: false,
      submitButtonText: 'Submit',
      submitButtonTextStyle:
          const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        if (response.rating <= 0.0) {
          toast.showToast('Please provide a rating before submitting.');
        } else {
          launchUrl(url);
        }
      },
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ratingDialog,
    );
  }
}
