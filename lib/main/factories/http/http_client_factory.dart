import 'package:http/http.dart';

import 'package:flutter_clean/data/http/http.dart';
import 'package:flutter_clean/infra/http/http.dart';

HttpClient makeHttpClient() {
  final client = Client();
  return HttpAdapter(client);
}
