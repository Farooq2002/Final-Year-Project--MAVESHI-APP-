import 'package:flutter/material.dart';

class AnimalListTile extends StatelessWidget {
  final String name;
  final String subTitle;
  final String description;
  final String image;
  final VoidCallback onPress;
  const AnimalListTile(
      {Key? key,
      required this.name,
      required this.subTitle,
      required this.image,
      required this.description,
      required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: onPress,
        child: Stack(
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 100,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black87),
                      child: Image.network(
                        image,
                        fit: BoxFit.fill,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    FittedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(fontFamily: 'Nunito'),
                          ),
                          Text(subTitle),
                          Text(description)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Positioned(
                top: 0.0,
                left: 300.0,
                right: 0.0,
                bottom: 70.0,
                child: Icon(Icons.favorite_border))
          ],
        ),
      ),
    );
  }
}
