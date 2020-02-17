import 'package:flutter/material.dart';
import 'package:your_shop/models/list_items.dart';
import 'package:your_shop/utils/price_utils.dart';

class DetailScreen extends StatelessWidget {
  // GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  
  // final Item _clothe;
  // DetailScreen(this._clothe);

  @override
  Widget build(BuildContext context) {
    print('entra build detail screen');
    final Item _clothe = ModalRoute.of(context).settings.arguments;
    final _size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              _image(_clothe, _size),
              _title(_clothe.name),
              _content(),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: _btnAdd(_size, context),
          ),
        ],
      ),
    );
  }

  Widget _image(Item clothe, Size size) {
    return Hero(
      tag: clothe.id,
      child: FadeInImage(
        width: double.infinity,
        height: size.height * 0.6,
        fit: BoxFit.cover,
        placeholder: AssetImage('assets/images/pucharse.png'),
        image: NetworkImage(clothe.urlImage),
      ),
    );
  }

  Widget _title(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
    );
  }

  Widget _content() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 80),
      child: Text(PriceUtils.lorem()),
    );
  }

  Widget _btnAdd(Size size, BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      width: size.width * 0.70,
      child: RaisedButton(
        color: Colors.black,
        textColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Add to buy',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(70)),
        ),
        onPressed: () {
          // TODO: Insert in wish list
          _showSnackbar(context);
        },
      ),
    );
  }

  _showSnackbar(BuildContext context) {
    _scaffoldKey.currentState
        .showSnackBar(
          SnackBar(
            content: Text('Successful'),
            duration: Duration(milliseconds: 1000),
          ),
        )
        .closed
        .then((value) => Navigator.of(context).pop());
  }
}
