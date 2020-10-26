
import 'package:delivery_app/extension/color_extension.dart';
import 'package:delivery_app/models/categories_model.dart';
import 'package:delivery_app/models/item_model.dart';
import 'package:delivery_app/screen/detai_item_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ItemListCategory extends StatelessWidget {
  int id;
  CategoriesModel category;
  ItemListCategory({this.id});

  Future<List<ItemModel>> fetchData() async {
    final response = await http.get(category.urlStr);
    if (response != null) {
      String body = utf8.decode(response.bodyBytes);
      final result = json.decode(body);
      List<ItemModel> listItem = result.map<ItemModel>((model){
        ItemModel item = ItemModel.fromJson(model);
        return item;
      }).toList();
      return listItem;
    } else {
      throw Exception('Request API is failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex("#F6F5F5"),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: HexColor.fromHex("#F6F5F5"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: HexColor.fromHex("#2D0C57")),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        child: FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                scrollDirection: Axis.vertical,
                children: [
                  Text(
                    category.name,
                    style: TextStyle(
                        color: HexColor.fromHex("#2D0C57"),
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Search",
                      contentPadding: EdgeInsets.all(10),
                      prefixIcon: Icon(Icons.search, color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(27)
                      )
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        ItemModel item = snapshot.data[index];
                        return ItemBuilder(
                          imgStr: item.image,
                          name: item.name,
                          price: item.price,
                          detail: item.detail,
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_){
                              DetailItemScreen detailItem = DetailItemScreen();
                              detailItem.item = item;
                              return detailItem;
                            }));
                          },
                        );
                      },
                      itemCount: snapshot.data.length,
                    ),
                  )
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(

                ),
              );
            }
          },
        ),
      )
    );
  }
}

class ItemBuilder extends StatefulWidget {
  final String imgStr;
  final String name;
  final int price;
  final String detail;
  final Function onTap;
  ItemBuilder({this.imgStr, this.name, this.price, this.detail, this.onTap});

  @override
  _ItemBuilderState createState() => _ItemBuilderState();
}

class _ItemBuilderState extends State<ItemBuilder> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.only(bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10)
              ),
              child: Image.network(
                widget.imgStr,
                width: 170,
                height: 130,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: size.width - 170 - 50,
                    child: Text(
                      widget.name,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: HexColor.fromHex("#2d0c57")
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "${widget.price}",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: HexColor.fromHex("#2d0c57")
                        ),
                      ),
                      Text(
                        " \u{20B9} / piece",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: HexColor.fromHex("#9586A8")
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: Row(
                      children: [
                        FlatButton(
                          onPressed: (){
                            setState(() {
                              isFavorite = !isFavorite;
                            });
                          },
                          child: Icon(
                              Icons.favorite,
                              color: isFavorite ? Colors.red : HexColor.fromHex("#9586A8")
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                  color: HexColor.fromHex("#9586A8")
                              )
                          ),
                          minWidth: 60,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          child: FlatButton(
                            minWidth: 60,
                            onPressed: (){},
                            child: Icon(Icons.store, color: Colors.white),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: HexColor.fromHex("#0BCE83"),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
