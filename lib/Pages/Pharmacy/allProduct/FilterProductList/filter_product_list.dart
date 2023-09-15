
import 'package:flutter/material.dart';

import '../../../../AppManager/app_color.dart';
import '../../../../AppManager/my_text_theme.dart';
import '../../../../AppManager/widgets/my_app_bar.dart';
import 'filter_product_modal.dart';
class FilterProductList extends StatefulWidget {
  const FilterProductList({Key? key}) : super(key: key);

  @override
  State<FilterProductList> createState() => _FilterProductListState();
}

class _FilterProductListState extends State<FilterProductList> {

  FilterProductModal modal = FilterProductModal();
bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.pharmacyPrimaryColor,
      child: SafeArea(
        child: Scaffold(
         appBar:MyWidget().myAppBar(context,title: 'Filter',action: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(), backgroundColor: AppColor.orangeButtonColor,
                      //minimumSize: Size(10, 20)
                  ),
                  onPressed: () {
                    print('ppppppppppp');
                    //App().navigate(context, FilterProductList());
                  },
                  child: Text('Clear ALL',
                      style: MyTextTheme().smallWCN)),
            ),
          ]),
          body: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 150,
                      color: AppColor.bgColor,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 15, 8, 10),
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.separated(
                                itemCount: modal.controller.filterOptions.length,
                                  separatorBuilder: (context,index)=>SizedBox(height: 20),
                                  itemBuilder: (context,index) {
                                  return Text(modal.controller.filterOptions[index]['filterType'].toString(),style: MyTextTheme().mediumGCB,);
                                  }
                                  ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: AppColor.white,
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.separated(
                                  itemCount: modal.controller.filterOptions.length,
                                  separatorBuilder: (context,index)=>SizedBox(height: 0),
                                  itemBuilder: (context,index) {
                                    return Row(
                                      children: [
                                        Checkbox(
                                          side: BorderSide(width: 1,color: AppColor.greyLight),
                                          shape:  RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(3),
                                          ),
                                   value: isChecked,
                                   onChanged: (bool? value)
                                            {
                                              isChecked = value!;
                                              setState(() {

                                              });
                                            }
                                 ),
                                        Text('Dettol')
                                      ],
                                    );
                                  }
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: AppColor.white,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10,bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: AppColor.red,
                        ),
                        onPressed: () { },
                        child: Text('Close'),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: AppColor.pharmacyPrimaryColor,
                        ),
                        onPressed: () { },
                        child: Text('Apply'),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
