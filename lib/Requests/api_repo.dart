import 'package:http/http.dart' as http;

class ApiRepo {
  final String userName;
  final String url = 'api.github.com';

  ApiRepo(this.userName);

  Future<http.Response> fetchUser() {
    return http.get(Uri.https(url, 'users/$userName'));
  }

  Future<http.Response> fetchFollowers() {
    return http.get(Uri.https(url, 'users/$userName/followers'));
  }
}
