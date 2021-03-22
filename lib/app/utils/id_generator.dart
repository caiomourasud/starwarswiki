class IdGenerator {
  // static final Random _random = Random.secure();
  // static String createCryptoRandomString() {
  //   var values = List<int>.generate(18, (i) => _random.nextInt(256));
  //   return base64Url.encode(values);
  // }
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
