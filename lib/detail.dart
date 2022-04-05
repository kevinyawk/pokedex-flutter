import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class Detail extends StatefulWidget {
  final pokemonData;
  final Color color;
  final pokemonTag;
  
  const Detail({ Key? key, this.pokemonData, required this.color, this.pokemonTag }) : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    var widthOfTheScreen = MediaQuery.of(context).size.width;
    var heightOfTheScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: widget.color,
      body: Stack(
        children: [
          Positioned(
            top: (heightOfTheScreen / 2) - 260,
            right: -50,
            child: Image.asset('assets/images/pokeball-bg.png', width: 200, fit: BoxFit.fitWidth),
          ),
          Positioned(
            top: 50,
            left: 20,
            child: Text(
              widget.pokemonData['name'],
              style: TextStyle(
                fontWeight: FontWeight.bold, 
                fontSize: 40,
                color: Colors.white
              ),
            ),
          ),
          Positioned(
            top: 70,
            right: 20,
            child: Text(
              "#" + widget.pokemonTag.toString().padLeft(3, '0'),
              style: TextStyle(
                fontWeight: FontWeight.bold, 
                fontSize: 20,
                color: Colors.white
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: 20,
            child: Row(
              children: [ 
                for (var type in widget.pokemonData['types']) 
                Container(
                  margin: const EdgeInsets.only(right: 5),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 4, bottom: 4),
                    child: Text(
                      type['type']['name'],
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white24
                  ),
                ),
              ]
            )
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: widthOfTheScreen,
              height: heightOfTheScreen * 0.6,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                color: Colors.white,
              ),
              // child: Text("Success"),
              child: DefaultTabController(
                length: 4,
                initialIndex: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const TabBar(
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        labelPadding: EdgeInsets.only(top: 40, bottom: 10),
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorWeight: 2,
                        indicatorColor: Colors.indigo,
                        tabs: [
                          Tab(text: 'About',),
                          Tab(text: 'Base Stats'),
                          Tab(text: 'Evolution'),
                          Tab(text: 'Moves'),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 10, bottom:0, left: 20, right: 20),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 20),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: widthOfTheScreen * 0.3,
                                            child: Text(
                                              'Name',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black54
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: widthOfTheScreen * 0.3,
                                            child: Text(
                                              widget.pokemonData['name'],
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 20),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: widthOfTheScreen * 0.3,
                                            child: Text(
                                              'Height',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black54
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: widthOfTheScreen * 0.3,
                                            child: Text(
                                              (intl.NumberFormat.decimalPattern().format(widget.pokemonData['height'] * 0.1)).toString() + "cm",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 20),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: widthOfTheScreen * 0.3,
                                            child: Text(
                                              'Weight',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black54
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: widthOfTheScreen * 0.3,
                                            child: Text(
                                              intl.NumberFormat.decimalPattern().format(widget.pokemonData['weight'] * 0.1).toString() + "kg",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: widthOfTheScreen * 0.3,
                                            child: Text(
                                              'Abilities',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black54
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: widthOfTheScreen * 0.5,
                                            child: Text(
                                              getAbilitiesAsString(widget.pokemonData['abilities']),
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10, bottom:0, left: 20, right: 20),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    for (var stat in widget.pokemonData['stats']) 
                                    Container(
                                      margin: EdgeInsets.only(bottom: 20),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: widthOfTheScreen * 0.3,
                                            child: Text(
                                              stat['stat']['name'],
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black54
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: widthOfTheScreen * 0.2,
                                            child: Text(
                                              stat['base_stat'].toString(),
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: widthOfTheScreen * 0.3 * (stat['base_stat']/100),
                                            height: 5,
                                            color: stat['base_stat'] >= 50 ? Colors.green : Colors.red
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10, bottom:0, left: 20, right: 20),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Icon(Icons.build, size: 100),
                                    Text(
                                      "Under Maintenance",
                                      style: TextStyle(
                                        fontSize: 20
                                      ),
                                    )
                                  ]
                                )
                              )
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10, bottom:0, left: 20, right: 20),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Icon(Icons.build, size: 100),
                                    Text(
                                      "Under Maintenance",
                                      style: TextStyle(
                                        fontSize: 20
                                      ),
                                    )
                                  ]
                                )
                              )
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ),
          ),
          Positioned(
            top: (heightOfTheScreen / 2) - 240,
            left: (widthOfTheScreen / 2) - 100,
            child: CachedNetworkImage(
              height: 200,
              fit: BoxFit.fitHeight,
              imageUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/"+ (widget.pokemonTag).toString() +".png"
            )
          )
        ]
      ),
    );
  }

  String getAbilitiesAsString(abilities) {
    var allAbilities = [];
    for (var ability in abilities) {
      allAbilities.add(ability['ability']['name']);
    }
    return allAbilities.join(", ");
  }
}