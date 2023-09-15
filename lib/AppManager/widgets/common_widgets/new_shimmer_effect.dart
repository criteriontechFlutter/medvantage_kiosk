  import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffect extends StatelessWidget {
  final Widget child;
  final bool loading;
  final bool noData;
  const ShimmerEffect({Key? key, required this.child, required this.loading, required this.noData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     if(loading){
     return ListView.separated(
      itemCount: 2,separatorBuilder: ((_, __) =>const SizedBox(height: 15,) ),
      itemBuilder: ((_, __) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
        ),
        width: MediaQuery.of(context).size.width,
        child:Shimmer(enabled: loading,gradient:const LinearGradient(
          colors: [
            Color(0xFFEBEBF4),
            Color(0xFFF4F4F4),
            Color(0xFFEBEBF4),
          ],
          stops:[
            0.1,
            0.3,
            0.4,
          ],
          begin:Alignment(-1.0, -0.3),
          end:Alignment(1.0, 0.3),
          tileMode: TileMode.repeated,
        ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10.0,12,0,12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.grey,
                  height: 15,
                  width: 300,
                ),
                const SizedBox(height: 10,),
                Container(
                  color: Colors.grey,
                  height: 15,
                  width: 260,
                ),
                const SizedBox(height: 10,),
                Container(
                  color: Colors.grey,
                  height: 15,
                  width: 220,
                ),
              ],
            ),
          ),
      ) )
    )
        );}
     else if(noData){

       return Center(child: Lottie.asset('assets/no_data_found.json',height:150,width: 150));}
     else {
       return child;
     }
  }
}
