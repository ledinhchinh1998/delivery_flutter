import 'package:delivery_app/extension/color_extension.dart';
import 'package:delivery_app/models/categories_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'item_list_category.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<CategoriesModel> items = [];
  List<CategoriesModel> filteredItem = [];
  bool isFiltering = false;
  var controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<List<CategoriesModel>> fetchAlbum() async {
    final response = await http.get('https://5f2288580e9f660016d883cc.mockapi.io/listItem');
    if (response.statusCode == 200) {
      if (response != null) {
        var body = utf8.decode(response.bodyBytes);
        final parseJson = jsonDecode(body);
        List<CategoriesModel> mlist = parseJson.map<CategoriesModel>((model) {
          return CategoriesModel.fromJson(model);
        }).toList();
        return mlist;
      }
    } else {
      throw Exception('Failed request API');
    }
  }

  void filterSearchResult(String query) {
    if (query.isEmpty) {
      setState(() {});
      return;
    } else {
      setState(() {
        filteredItem.clear();
        items.forEach((element) {
          if (element.name.toLowerCase().contains(query)) {
            filteredItem.add(element);
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
          backgroundColor: HexColor.fromHex("#F6F5F5"),
          body: Container(
            child: RefreshIndicator(
              child: ListView(
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.all(20),
                children: [
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Categories",
                        style: TextStyle(
                            color: HexColor.fromHex("#2D0C57"),
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        onChanged: (value) {
                          print(value);
                          if (value == "") {
                            isFiltering = false;
                          } else {
                            isFiltering = true;
                          }
                          filterSearchResult(value);
                        },
                        controller: controller,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.black,
                            ),
                            hintText: "Search",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(27))),
                      ),
                      SizedBox(height: 20),
                      FutureBuilder(
                          future: fetchAlbum(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              items.clear();
                              items.addAll(snapshot.data);
                              return GridView.builder(
                                  shrinkWrap: true,
                                  physics: ClampingScrollPhysics(),
                                  gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 1 / 1),
                                  itemBuilder: (context, index) {
                                    CategoriesModel category = items[index];
                                    return CardCategories(
                                      imgString: category.image,
                                      title: category.name,
                                      count: category.count,
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context) {
                                              ItemListCategory listCategory =
                                              ItemListCategory();
                                              listCategory.category = category;
                                              return listCategory;
                                            }));
                                      },
                                    );
                                  },
                                  itemCount: snapshot.data == null ? 0 : isFiltering ? filteredItem.length : items.length,
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          })
                    ],
                  )
                ],
              ),
              onRefresh: () {
                isFiltering = false;
                controller.text = "";
                setState(() {

                });
                return fetchAlbum();
              }
            ),
          )),
    );
  }
}

class CardCategories extends StatelessWidget {
  final String imgString;
  final String title;
  final String count;
  final Function onTap;

  CardCategories({this.imgString, this.title, this.count, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              imgString,
              height: 120,
              fit: BoxFit.fill,
              width: double.infinity,
            ),
            Container(
                padding: EdgeInsets.all(5),
                child: Text(
                  title,
                  style: TextStyle(
                      color: HexColor.fromHex("#2D0C57"),
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                )),
            Container(
                padding: EdgeInsets.only(left: 5, bottom: 0),
                child: Text("($count)",
                    style: TextStyle(
                        color: HexColor.fromHex("#9586A8"), fontSize: 14)))
          ],
        ),
      ),
    );
  }
}
