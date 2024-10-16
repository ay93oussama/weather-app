class ServerException implements Exception {}

//route
class RouteException implements Exception {
  final String message;
  const RouteException(this.message);
}
