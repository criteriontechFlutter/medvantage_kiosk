import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PainIntensityWidget extends StatelessWidget {
  final String intensityPicture;
  final double intensityPictureHeight;
  final String labelPain;
  final Color activeColor;
  final double lowerValue;
  final double upperValue;
  final double painIntensity;
  final Function updatePainIntensity;
  const PainIntensityWidget({Key? key,required this.lowerValue,required this.upperValue,required this.painIntensity,
    required this.updatePainIntensity, required this.intensityPicture, required this.intensityPictureHeight, required this.labelPain, required this.activeColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 5,),
        SizedBox(
          height: 90,
            child: SvgPicture.asset(intensityPicture,height: intensityPictureHeight,)),
        Text(labelPain,style: MyTextTheme().mediumBCB,),
        const SizedBox(height: 10,),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 20,
            trackShape:const RoundedRectSliderTrackShape()
          ),
          child: Slider(value: painIntensity,
              activeColor: activeColor,
              inactiveColor: activeColor.withOpacity(0.2),
              label: labelPain,
              min: lowerValue,
              max: upperValue,
              onChanged: (val){
                updatePainIntensity(val);
              }),
        )
      ],
    );
  }
}
