import 'package:http/http.dart' as http;
import 'dart:convert';

const maxlimit = '152';
const URI = 'pokeapi.co';
const URIimg = 'raw.githubusercontent.com';

class DataService {
  Future<List<dynamic>> getPokemons() {
    return http
        .get(Uri.https(URI, 'api/v2/pokemon/', {'limit': maxlimit}))
        .then((response) {
      var res = json.decode(response.body);
      if (res['results'] != null) {
        return res['results'];
      }
      return List();
    });
  }

  Future<Map> getDetails(String pokemonName) {
    return http
        .get(Uri.https(URI, 'api/v2/pokemon/${pokemonName}'))
        .then((response) {
      var res = json.decode(response.body);
      return res;
    });
  }
}
