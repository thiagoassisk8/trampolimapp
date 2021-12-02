import 'package:flutter/material.dart';
import 'package:trampolimApp/services/data.service.dart';
import 'package:trampolimApp/widgets/pokemon.card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<HomeScreen> {
  List _pokemons = List();
  DataService _service = DataService();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _service.getPokemons().then((result) {
      _pokemons = result;
      setState(() => _isLoading = false);
    });
  }

  goToDetail(pokemon) {
    Navigator.pushNamed(context, '/details', arguments: pokemon);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Pokedx'),
      ),
      body: (_isLoading)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 5.3)),
              itemCount: _pokemons.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => goToDetail(_pokemons[index]),
                  child: Card(
                    child: GridTile(
                      child: Column(
                        children: [
                          PokemonCard(_pokemons[index]),
                          Image.network(
                              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${index + 1}.png'),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
