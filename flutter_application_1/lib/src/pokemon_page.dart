import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class PokemonPage extends StatefulWidget {
  const PokemonPage({Key? key}) : super(key: key);

  @override
  State<PokemonPage> createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  List pokemons = [];

  @override
  void initState() {
    Future.microtask(() async {
      await loadPokemons();
    });
    super.initState();
  }

  Future<void> loadPokemons() async {
    final data = await http
        .get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=100'));
    setState(() {
      pokemons = json.decode(data.body)['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pokémon')),
      body: Wrap(
        children: List.generate(
            pokemons.length,
            (index) => Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text('$index'),
                    Text(pokemons[index]['name']),
                  ],
                ))),
      ),
    );
  }
}
