import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokedex_sprout_test/detail.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var baseUrl = "https://pokeapi.co/api/v2/";
  List pokedex = [];
  var readyToRender = false;

  @override
  void initState() {
    super.initState();
    if(mounted) {
      fetchPokemonData();
    }
  }

  @override
  Widget build(BuildContext context) {
    var widthOfTheScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -50,
            right: -50,
            child: Image.asset('assets/images/pokeball-bg.png', width: 200, fit: BoxFit.fitWidth),
          ),
          Positioned(
            top: 70,
            left: 10,
            child: Text(
              "Pokedex",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold
              ),
            )
          ),
          Positioned(
            top: 150,
            bottom: 0,
            width: widthOfTheScreen,
            // width: widthOfTheScreen,
          child: Column(
            children: [
              readyToRender == true ? Expanded(child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.4
              ), itemCount: pokedex.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => Detail(
                        pokemonData: pokedex[index], 
                        color: getColor(pokedex[index]['types'][0]['type']['name']),
                        pokemonTag: index + 1,
                      )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          color: getColor(pokedex[index]['types'][0]['type']['name']),
                          borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: -10,
                              right: -10,
                              child: Image.asset('assets/images/pokeball.png', height: 100, fit: BoxFit.fitHeight),
                            ),
                            Positioned(
                              top: 25,
                              left: 20,
                              child: Text(
                                pokedex[index]['name'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold, 
                                  fontSize: 18,
                                  color: Colors.white
                                ),
                              ),
                            ),
                            Positioned(
                              top: 50,
                              left: 20,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (var type in pokedex[index]['types']) 
                                  Container(
                                    margin: EdgeInsets.only(bottom: 5),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 4, bottom: 4),
                                      child: Text(
                                        type['type']['name'],
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                      color: Colors.black26
                                    ),
                                  ),
                                ],
                              )
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: CachedNetworkImage(
                                height: 100,
                                width: 100,
                                fit: BoxFit.fitHeight,
                                imageUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/"+ (index+1).toString() +".png"
                              )
                            )
                          ]
                        )
                      ),
                    ),
                  );
                },
              )) : Center(
                child: CircularProgressIndicator(),
              )
            ],
          ),
        )],
      )
    );
  }

  void fetchPokemonData() async {
    http.get(Uri.parse(baseUrl + "pokemon?offset=0&limit=100")).then((data) async {
      if (data.statusCode == 200) {
        var response = jsonDecode(data.body);
        pokedex = response['results'];
        var index = 1;
        for (var pokemon in pokedex) {
          await fetchPokemonDataPerId(index);
          index++;
        }
        setState(() {
          readyToRender = true;
        });   
      } else {
      }
    });
  }

  Future fetchPokemonDataPerId(id) async {
    await http.get(Uri.parse(baseUrl + "pokemon/" + id.toString())).then((data){
      if (data.statusCode == 200) {
        var response = jsonDecode(data.body);
        response.forEach((key, value) {
          pokedex[id-1][key] = value;
        });
      } else {
      }
    });
  }

  Color getColor(type) {
    if(type == 'fire') {
      return Colors.red;
    } else if (type == 'grass'){
      return Colors.lightGreen;
    } else if (type == 'water'){
      return Colors.blue;
    } else if (type == 'electric'){
      return Colors.yellow;
    } else if (type == 'poison'){
      return Colors.purple;
    } else if (type == 'ground'){
      return Colors.brown;
    } else if (type == 'fairy'){
      return Colors.pink;
    } else if (type == 'bug'){
      return Colors.greenAccent;
    } else if (type == 'fighting'){
      return Colors.orange;
    } else if (type == 'psychic'){
      return Colors.indigo;
    } else if (type == 'ghost'){
      return Colors.deepPurple;
    } else if (type == 'rock'){
      return Colors.grey;
    } else {
      return Colors.black87;
    }
  }
}