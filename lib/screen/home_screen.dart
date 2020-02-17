// import 'dart:convert';
// import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:your_shop/models/list_items.dart';
import 'package:your_shop/providers/items_provider.dart';
import 'package:your_shop/utils/price_utils.dart';

class HomeScreen extends StatelessWidget {
  final ItemsProvider _itemsProvider = ItemsProvider();
  // final url = 'https://infomath-b5ab3.firebaseio.com/.json';

  @override
  Widget build(BuildContext context) {
    print('entra build homescreen');
    final _screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                _firstSection(_screenSize),
                SizedBox(height: 10),
                _titleSection('Trend'),
                SizedBox(height: 10),
              ],
            ),
          ),
          FutureBuilder<List<Item>>(
            //TODO mas de dos peticiones
            future: _itemsProvider.requestItems(),
            // initialData: [],
            builder: (context, snapshot) {
              // print('status connection ${snapshot.connectionState}');

              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  final data = snapshot.data;
                  return SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.65,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => _item(data[index], context),
                      childCount: data.length,
                    ),
                  );
                  break;
                case ConnectionState.waiting:
                  return SliverList(
                    delegate: SliverChildListDelegate(
                        [Center(child: CircularProgressIndicator())]),
                  );
                  break;
                default:
                  return SliverList(
                    delegate: SliverChildListDelegate(
                        [Center(child: CircularProgressIndicator())]),
                  );
              }
            },
          ),
        ],
      ),
    );
  }

  Padding _titleSection(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ),
    );
  }

  Container _firstSection(Size _screenSize) {
    return Container(
      height: _screenSize.height * 0.5,
      child: Image.network(
        'https://pngimage.net/wp-content/uploads/2018/06/womens-fashion-png-4.png',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _item(Item clothe, BuildContext context) {
    return Card(
      elevation: 16,
      margin: EdgeInsets.all(8),
      // color: Colors.blue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 6,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('detail', arguments: clothe);
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) {
                //       return DetailScreen(clothe);
                //     },
                //   ),
                // );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Hero(
                  tag: clothe.id,
                  child: FadeInImage(
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: AssetImage('assets/images/pucharse.png'),
                    image: NetworkImage(clothe.urlImage),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                clothe.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              PriceUtils.convertPriceToString(clothe.price),
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
