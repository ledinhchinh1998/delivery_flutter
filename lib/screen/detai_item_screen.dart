import 'package:delivery_app/extension/color_extension.dart';
import 'package:delivery_app/models/categories_model.dart';
import 'package:delivery_app/models/item_model.dart';
import 'package:delivery_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class DetailItemScreen extends StatelessWidget {
  ItemModel item;
  @override
  Widget build(BuildContext context) {
    return StateFullDetailItem(item: item);
  }
}

class StateFullDetailItem extends StatefulWidget {
  final ItemModel item;
  const StateFullDetailItem({Key key, this.item}) : super(key: key);

  @override
  _StateFullDetailItemState createState() => _StateFullDetailItemState();
}

class _StateFullDetailItemState extends State<StateFullDetailItem> {
  bool isFavorite = false;
  var listItem = List<String>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 0,
              child: Container(
                child: Image.network(
                  widget.item.image,
                  fit: BoxFit.fill,
                  width: size.width,
                  height: size.height / 3 + 20,
                ),
              ),
            ),
            Positioned(
              right: 0,
              left: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                    color: HexColor.fromHex("#F6F5F5")
                ),
                width: size.width,
                height: size.height - size.height / 3,
                child: Expanded(
                  child: ListView(
                    children: [
                      Text(
                        widget.item.name,
                        style: TextStyle(
                            color: HexColor.fromHex("#2D0C57"),
                            fontWeight: FontWeight.bold,
                            fontSize: 30
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            "${widget.item.price}",
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
                      SizedBox(height: 10),
                      Text(
                        "~ 150g / piece",
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 17
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        widget.item.detail,
                        style: TextStyle(
                            color: HexColor.fromHex("#9586A8"),
                            fontSize: 17
                        ),
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FlatButton(
                            onPressed: () {
                              isFavorite = !isFavorite;
                              setState(() {

                              });
                            },
                            child: Icon(
                                Icons.favorite,
                                color: isFavorite ? Colors.red : Colors.grey,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                    color: HexColor.fromHex("#9586A8")
                                )
                            ),
                            minWidth: 70,
                            height: 50,
                          ),
                          SizedBox(width: 20),
                          Flexible(
                            child: GestureDetector(
                              onTap: () {
                                if (Utils().read("listCart") != null) {
                                  print("data is not exist");
                                  Utils().read("listCart");
                                  print(json.encode(widget.item).toString());
                                  listItem.add(json.encode(widget.item));
                                  Utils().save("listCart", listItem);
                                } else {
                                  print("data is exist");
                                }
                                setState(() {
                                  // Toast.show("Thêm vào giỏ hàng thành công", context, duration: 1, gravity: Toast.CENTER);
                                });
                              },
                              child: Container(
                                height: 50,
                                padding: EdgeInsets.only(left: 10, right: 10),
                                decoration: BoxDecoration(
                                    color: HexColor.fromHex("#0BCE83"),
                                    borderRadius: BorderRadius.circular(8)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add_shopping_cart,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "ADD TO CART",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 15,
              left: 10,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: HexColor.fromHex("#2D0C57"),
                ),
              ),
            ),
            Positioned(
                top: 15,
                right: 10,
                child: Stack(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.add_shopping_cart,
                        color: Colors.white,
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 0,
                      child: Container(
                        alignment: Alignment.center,
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(7.5)
                        ),
                        child: Text(
                          "1",
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.white
                          ),
                        ),
                      ),
                    )
                  ],
                )
            ),
          ],
        )
    );
  }
}

