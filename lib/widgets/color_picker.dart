import 'package:flutter/material.dart';
import 'package:notethings/widgets/constant.dart';

class ColorPicker extends StatelessWidget {
  final Function(int) onTap;
  final int selectedIndex;

  const ColorPicker({
    this.onTap,
    this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 60,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: noteBGColors.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                onTap(index);
              },
              highlightColor: Colors.grey,
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              child: Container(
                padding: EdgeInsets.all(8.0),
                width: 60,
                height: 60,
                child: Container(
                  child: Center(
                      child: selectedIndex == index
                          ? Icon(Icons.done)
                          : Container()),
                  decoration: BoxDecoration(
                      color: noteBGColors[index],
                      shape: BoxShape.circle,
                      border: Border.all(width: 1, color: Colors.black)),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
