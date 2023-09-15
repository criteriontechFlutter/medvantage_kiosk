
import 'package:get/get.dart';


class AddAddressController extends GetxController{

 //final formKey = GlobalKey<FormState>().obs;
 var file = ''.obs;


 // List fields=[
 //
 //   {
 //    'lable':'Full Name',
 //    'hintText':"Your full name",
 //    Icon:Icons.person,
 //     'controller':TextEditingController()
 //   },
 //
 //   {
 //    'lable':'Mobile No.',
 //    'hintText':"Your Mobile No.",
 //    Icon:  Icons.phone_android,
 //     'controller':TextEditingController()
 //   },
 //
 //   {
 //    'lable':'House No.',
 //    'hintText':"Your House No.",
 //    Icon:Icons.location_on,
 //     'controller':TextEditingController()
 //   },
 //
 //   {
 //    'lable':'Area',
 //    'hintText':"Your Area",
 //    Icon:Icons.home_filled,
 //     'controller':TextEditingController()
 //   },
 //
 //   {
 //    'lable':'Pin Code',
 //    'hintText':"Pin Code here",
 //    Icon:Icons.event_note_sharp,
 //     'controller':TextEditingController()
 //   },
 //
 //   {
 //    'lable':'State',
 //    'hintText':"State",
 //    Icon:Icons.api,
 //     'controller':TextEditingController()
 //   },
 //   {
 //     'lable':'City',
 //     'hintText':"Your City",
 //     Icon:Icons.home_filled,
 //     'controller':TextEditingController()
 //   },
 //   {
 //     'lable':'Locality',
 //     'hintText':"Your Locality",
 //     Icon:Icons.home_filled,
 //     'controller':TextEditingController()
 //   },
 //
 //   {
 //     'lable':'IsSundayOpen',
 //     'hintText':"IsSundayOpen",
 //     Icon:Icons.home_filled,
 //     'controller':TextEditingController()
 //   },
 //
 //   {
 //     'lable':'IsSaturdayOpen',
 //     'hintText':"IsSaturdayOpen",
 //     Icon:Icons.home_filled,
 //     'controller':TextEditingController()
 //   },
 //
 //  ].obs;
 List isCheck = [].obs;

 RxBool isSundayOpen = false.obs;
 RxBool isSaturdayOpen = false.obs;
 RxBool isDefault = true.obs;
 RxString sun="".obs;
 RxString sat="".obs;
 RxInt def=1.obs;


}

