import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maveshi/models/driver_model.dart';
import 'package:maveshi/screens/animal_categories_screens/buffalo_category_screen.dart';
import 'package:maveshi/screens/animal_categories_screens/cow_category_screen.dart';
import 'package:maveshi/screens/animal_categories_screens/goat_category_screen.dart';
import 'package:maveshi/screens/animal_categories_screens/others_category_screen.dart';
import 'package:maveshi/screens/animal_categories_screens/sheep_category_screen.dart';
import 'package:maveshi/screens/butcher_details.dart';
import 'package:maveshi/screens/driver_details_screen.dart';
import 'package:maveshi/utils/colors.dart';
import 'package:maveshi/utils/fonts.dart';

import '../../models/butcher_profile_model.dart';
import '../../widgets/drivers_tile.dart';
import '../../widgets/my_drawer.dart';
import '../animal_categories_screens/lamb_category_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'Home-Page';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  // ==========butcher ref============
  final CollectionReference butcherCollection =
      FirebaseFirestore.instance.collection('butcher');

  //=============drivers reference==================
  final CollectionReference driveCollection =
      FirebaseFirestore.instance.collection('Drivers');
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // leading: InkWell(
        //   onTap: () {
        //     Scaffold.of(context).openDrawer();
        //   },
        //   child: Padding(
        //     padding: const EdgeInsets.all(14.0),
        //     child: Image.asset(
        //       'assets/icons/menuIcons.png',
        //       color: Colors.white,
        //     ),
        //   ),
        // ),
        elevation: 0.0,
        centerTitle: true,
        title: const Text(
          'Home',
        ),
      ),
      drawer: const MyDrawer(),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //==================search=====================================
              Container(
                height: 110,
                decoration: const BoxDecoration(color: AppColour.primaryColor),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: _textController,
                        decoration: InputDecoration(
                          hintText: '   Search here ...',
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          suffixIcon: const Icon(Icons.search),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //=========================================Different Categories=====================================================

              DefaultTabController(
                length: 3, // length of tabs
                initialIndex: 0,
                child: Column(
                  children: <Widget>[
                    const TabBar(
                      isScrollable: true,
                      indicatorColor: AppColour.primaryColor,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.black,
                      tabs: [
                        Tab(text: 'Animals'),
                        Tab(text: 'Butcher'),
                        Tab(text: 'Drivers'),
                      ],
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height *
                          0.29, //height of TabBarView
                      decoration: const BoxDecoration(
                          border: Border(
                              top: BorderSide(color: Colors.grey, width: 0.5))),
                      child: TabBarView(children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Categories',
                                    style: AppFonts.boldText),
                                const SizedBox(height: 5),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.21,
                                  width: double.infinity,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        CategoryCard(
                                          title: 'Cow',
                                          image: 'assets/pictures/cows.png',
                                          onPress: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const CowCategory(
                                                          animalType: '',
                                                        )));
                                          },
                                        ),
                                        CategoryCard(
                                          title: 'Buffalo',
                                          image: 'assets/pictures/buf.jpeg',
                                          onPress: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const BuffaloCategoryScreen(
                                                          animalType: '',
                                                        )));
                                          },
                                        ),
                                        CategoryCard(
                                          title: 'Goat',
                                          image:
                                              'assets/pictures/goatwhite.jpg',
                                          onPress: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const GoatCategoryScreen(
                                                          animalType: '',
                                                        )));
                                          },
                                        ),
                                        CategoryCard(
                                          title: 'Sheep',
                                          image: 'assets/pictures/sheep.png',
                                          onPress: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const SheepCategoryScreen(
                                                          animalType: '',
                                                        )));
                                          },
                                        ),
                                        CategoryCard(
                                          title: 'Lamb',
                                          image: 'assets/pictures/lamb.jpg',
                                          onPress: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const LambCategoryScreen(
                                                          animalType: '',
                                                        )));
                                          },
                                        ),
                                        CategoryCard(
                                          title: 'Other',
                                          image: 'assets/pictures/buf.jpeg',
                                          onPress: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const OthersCategoryScreen(
                                                          animalType: '',
                                                        )));
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 130,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: StreamBuilder<QuerySnapshot>(
                              stream: driveCollection.snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasError) {
                                  return Center(
                                      child: Text("Error : ${snapshot.error}"));
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                if (snapshot.data == null ||
                                    snapshot.data!.docs.isEmpty) {
                                  return const Center(
                                      child: Text('No data available'));
                                }
                                return ListView.builder(
                                  itemCount: snapshot.data?.docs.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    DocumentSnapshot document1 =
                                        snapshot.data!.docs[index];
                                    DriverProfileModel driver =
                                        DriverProfileModel.fromSnapshot(
                                            document1);
                                    return DriverTile(
                                        title: driver.fullName ?? '',
                                        address: driver.address.toString(),
                                        imagePath: driver.profilePicture!,
                                        press: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DriverDetailsScreen(
                                                          driverDetails:
                                                              driver)));
                                        });
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 150,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: StreamBuilder<QuerySnapshot>(
                              stream: butcherCollection.snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasError) {
                                  return Center(
                                      child: Text("Error : ${snapshot.error}"));
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                if (snapshot.data == null ||
                                    snapshot.data!.docs.isEmpty) {
                                  return const Center(
                                      child: Text('No data available'));
                                }
                                return ListView.builder(
                                  itemCount: snapshot.data?.docs.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    DocumentSnapshot document =
                                        snapshot.data!.docs[index];
                                    ButcherProfile butcher =
                                        ButcherProfile.fromSnapshot(document);
                                    return DriverTile(
                                        title: butcher.fullName ?? '',
                                        address: butcher.address.toString(),
                                        imagePath: butcher.profilePicUrl!,
                                        press: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ButcherDetailScreen(
                                                        butcherDetails: butcher,
                                                      )));
                                        });
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ]),
                    )
                  ],
                ),
              ),

//=================================RECOMMENDED===================================================================

              //==========================for butchers=============

              //======================recommended=========================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Recommended', style: AppFonts.boldText),
                      const SizedBox(height: 5),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.21,
                        width: double.infinity,
                        child: StreamBuilder(
                          builder: (context, snapshot) {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return CategoryCard(
                                  title: '',
                                  image: 'assets/pictures/buf.jpeg',
                                  onPress: () {},
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback onPress;
  const CategoryCard(
      {Key? key,
      required this.title,
      required this.image,
      required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Card(
        elevation: 3,
        child: SizedBox(
          height: 150,
          width: 130,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 100,
                width: 130,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(
                      20,
                    )),
                child: Image.asset(
                  image,
                  fit: BoxFit.fill,
                  alignment: Alignment.center,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: AppFonts.boldText,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
