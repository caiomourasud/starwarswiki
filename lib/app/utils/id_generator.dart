class IdGenerator {
  static int generateId({required url, required type}) {
    String id = url.replaceAll('http://swapi.dev/api/$type/', '');
    id = id.replaceAll('/', '');
    return int.parse(id);

    //http://swapi.dev/api/films/
    //http://swapi.dev/api/people/
    //http://swapi.dev/api/planets/
    //http://swapi.dev/api/species/
    //http://swapi.dev/api/starships/
    //http://swapi.dev/api/vehicles/
  }
}
