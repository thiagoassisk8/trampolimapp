import 'package:flutter/material.dart';
import 'package:trampolimApp/services/data.service.dart';
// import 'package:cached_network_image/cached_network_image.dart';

class DetailsScreen extends StatefulWidget {
  Map pokemon;

  DetailsScreen(this.pokemon);

  @override
  _DetailState createState() => new _DetailState();
}

class _DetailState extends State<DetailsScreen> {
  bool _isLoading = true;
  Map _detail;
  List _sprites = [];
  List<Widget> _details = [];
  DataService _service = DataService();
  int selected = 0;

  @override
  void initState() {
    super.initState();
    _service.getDetails(widget.pokemon['name']).then((value) {
      _detail = value;

      getSprites();
      getDetails();
    });
  }

  getSprites() {
    var sprites = _detail['sprites'];
    final filteredMap = Map.from(sprites)
      ..removeWhere((k, v) {
        if (v == null) {
          return true;
        }
        if (v.runtimeType == String) {
          return false;
        }
        return true;
      });
    _sprites = filteredMap.entries
        .map((e) => {'name': e.key, 'url': e.value})
        .toList();
  }

  getDetails() {
    _details.add(Divider(color: Colors.transparent));
    _details.add(Text(' Informações Gerais', style: TextStyle(fontSize: 17)));
    _details.add(ListTile(
      title: Text('Nome'),
      subtitle: Text(_detail['name'].toString()),
    ));
    _details.add(ListTile(
      title: Text('Base Experience'),
      subtitle: Text(_detail['base_experience'].toString()),
    ));
    _details.add(ListTile(
      title: Text('Height'),
      subtitle: Text(_detail['height'].toString()),
    ));
    _details.add(ListTile(
      title: Text('Order'),
      subtitle: Text(_detail['order'].toString()),
    ));
    _details.add(ListTile(
      title: Text('Weight'),
      subtitle: Text(_detail['weight'].toString()),
    ));
    _details.add(ListTile(
      title: Text('Species'),
      subtitle: Text(_detail['species']['name'].toString()),
    ));
    _details.add(Divider());
    _details.add(ListTile(title: Text('Habilidades')));
    var abilities = <Widget>[];
    _detail['abilities'].forEach((v) {
      abilities.add(Chip(label: Text(v['ability']['name'])));
    });
    _details.add(Wrap(
      spacing: 6.0,
      runSpacing: 6.0,
      children: abilities,
    ));
    _details.add(Divider());
    _details.add(ListTile(title: Text('Formas')));
    var forms = <Widget>[];
    _detail['forms'].forEach((v) {
      forms.add(Chip(label: Text(v['name'])));
    });
    _details.add(Padding(
      padding: const EdgeInsets.all(10),
      child: Wrap(
        spacing: 6.0,
        runSpacing: 6.0,
        children: forms,
      ),
    ));
    _details.add(Divider());
    _details.add(ListTile(title: Text('Moves')));
    var moves = <Widget>[];
    _detail['moves'].forEach((v) {
      moves.add(Chip(label: Text(v['move']['name'])));
    });
    _details.add(Padding(
      padding: const EdgeInsets.all(10),
      child: Wrap(
        spacing: 6.0,
        runSpacing: 6.0,
        children: moves,
      ),
    ));
    _details.add(Divider());
    _details.add(ListTile(title: Text('Stats')));
    var stats = <Widget>[];
    _detail['stats'].forEach((v) {
      stats.add(Chip(
          label: Text(v['stat']['name'] + ': ' + v['base_stat'].toString())));
    });
    _details.add(Padding(
      padding: const EdgeInsets.all(10),
      child: Wrap(
        spacing: 6.0,
        runSpacing: 6.0,
        children: stats,
      ),
    ));
    _details.add(Divider());
    _details.add(ListTile(title: Text('Tipos')));
    var type = <Widget>[];
    _detail['types'].forEach((v) {
      type.add(Chip(label: Text(v['type']['name'])));
    });
    _details.add(Padding(
      padding: const EdgeInsets.all(10),
      child: Wrap(
        spacing: 6.0,
        runSpacing: 6.0,
        children: type,
      ),
    ));
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text((_isLoading)
            ? widget.pokemon['name'].toUpperCase()
            : '#' +
                _detail['id'].toString() +
                ' ' +
                _detail['name'].toUpperCase()),
      ),
      body: (_isLoading)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                        padding: const EdgeInsets.only(bottom: 10),
                        color: Colors.blueGrey.shade50,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _sprites.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  // Text("Sprints"),
                                  Divider(color: Colors.transparent),
                                  Chip(
                                    label: Text(_sprites[index]['name']),
                                  ),
                                  // ),
                                  Image.network(_sprites[index]['url'],
                                      height: 150, fit: BoxFit.fitWidth),
                                ],
                              );
                            })),
                    flex: 1,
                  ),
                  Expanded(
                    child: Container(
                      child: ListView(
                        padding: const EdgeInsets.all(10),
                        children: _details,
                      ),
                    ),
                    flex: 2,
                  ),
                ],
              ),
            ),
    );
  }
}
