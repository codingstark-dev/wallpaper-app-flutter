import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  const Category({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Container(
                color: Colors.white,
                height: 10,
                width: 160,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      "https://static.vecteezy.com/system/resources/previews/000/099/566/non_2x/free-flat-nature-vector-background.jpg",
                      fit: BoxFit.cover,
                    ),
                    Center(
                      child: Text(
                        "Nature",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold,),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
