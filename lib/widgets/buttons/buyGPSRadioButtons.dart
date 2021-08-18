import 'package:flutter/material.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/radius.dart';
import 'package:liveasy/constants/spaces.dart';
class MyRadioOption<T> extends StatelessWidget {

  final T value;
  final T duration;
  final T? groupValue;
  final T? groupDurationValue;
  final String text;
  final ValueChanged<T?> onChanged;
  final ValueChanged<T?> onDurationChanged;

  const MyRadioOption({
    required this.groupDurationValue,
    required this.duration,
    required this.value,
    required this.groupValue,
    required this.text,
    required this.onChanged,
    required this.onDurationChanged
  });

  Widget _buildLabel() {
    final bool isSelected = value == groupValue;
    return Container(
      padding: EdgeInsets.only(left: space_2),
      margin: EdgeInsets.fromLTRB(0, (space_3 - 1), 0, 0),
      width: (space_40 + space_18),
      height: (space_18 + 2),
      decoration: BoxDecoration(
          color: isSelected ? bidBackground : white,
          borderRadius: BorderRadius.circular((radius_1 + 2))
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: isSelected ? AssetImage(
                'assets/icons/selectedIcon.png'
            ) : AssetImage(
                'assets/icons/blueCircle.png'
            ),
            height: space_4,
            width: space_4,
          ),
          SizedBox(
            width: space_4,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildText(),
              SizedBox(
                height: space_3,
              ),
              Row(
                children: [
                  Container(
                    child: Image(
                      image: AssetImage(
                          'assets/icons/tickIcon.png'),
                      height: (space_2 - 1),
                      width: (space_2 - 3),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    child: Text(
                      "Truck location",
                      style: TextStyle(
                          color: isSelected ? white : bidBackground,
                          fontWeight: regularWeight,
                          fontSize: size_6
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: (space_1 - 2),
              ),
              Row(
                children: [
                  Container(
                    child: Image(
                      image: AssetImage(
                          'assets/icons/tickIcon.png'
                      ),
                      height: (space_2 - 1),
                      width: (space_2 - 3),
                    ),
                  ),
                  SizedBox(
                    width: space_1,
                  ),
                  Container(
                    child: Text(
                      "1 year replacement warranty",
                      style: TextStyle(
                          color: isSelected ? white : bidBackground,
                          fontWeight: regularWeight,
                          fontSize: size_6
                      ),
                    ),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildText() {
    final bool isSelected = value == groupValue;
    return Text(
      text,
      style: TextStyle(
          color: isSelected ? white : bidBackground,
          fontWeight: mediumBoldWeight,
          fontSize: size_7
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        onChanged(value),
        onDurationChanged(duration),
      },
      child: Row(
        children: [
          _buildLabel()
        ],
      ),
    );
  }
}