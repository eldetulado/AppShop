import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:your_shop/models/list_items.dart';

class ItemsProvider {

  final url = 'https://infomath-b5ab3.firebaseio.com/.json';


  Future<List<Item>> requestItems() async {
    var resp = await http.get(url);
    Map<String, dynamic> data = jsonDecode(resp.body);
    final items = ListItems.fromJson(data);
    return items.items;
  }
}
