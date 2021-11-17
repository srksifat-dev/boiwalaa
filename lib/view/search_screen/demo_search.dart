import 'package:boiwalaa/controller/cart_controller.dart';
import 'package:boiwalaa/model/demo_product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DemoSearchScreen extends StatefulWidget {
  const DemoSearchScreen({Key? key}) : super(key: key);

  @override
  _DemoSearchScreenState createState() => _DemoSearchScreenState();
}

class _DemoSearchScreenState extends State<DemoSearchScreen> {
  final cartController = Get.find<CartController>();
  List<Product> productList = [];

  bool isLoading = false;
  final TextEditingController _search = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void onSearch(String queryText) async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    setState(() {
      isLoading = true;
    });

    await _firestore
        .collection('products')
        .where(
          "searchKey",
          isGreaterThanOrEqualTo: queryText,
          // isLessThan: queryText.substring(0, queryText.length - 1) +
          //     String.fromCharCode(
          //         queryText.codeUnitAt(queryText.length - 1) + 1)
        )
        .get()
        .then((value) {
      cartController.demoList.value = value.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("demo"),
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            width: double.infinity,
            alignment: Alignment.center,
            child: Container(
              height: 50,
              width: 500,
              child: TextField(
                controller: _search,
                onChanged: (val) {
                  onSearch(val);
                },
                decoration: InputDecoration(
                  hintText: "Search",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          Obx(() => SizedBox(
                height: 390,
                width: double.infinity,
                child: ListView.builder(
                    itemCount: cartController.demoList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title:
                            Text("${cartController.demoList[index]["title"]}"),
                      );
                    }),
              ))
        ],
      ),
    );
  }
}
