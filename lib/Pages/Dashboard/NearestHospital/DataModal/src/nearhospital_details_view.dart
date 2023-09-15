import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_place/google_place.dart';
import '../../../../../AppManager/app_color.dart';
import '../../../../../AppManager/widgets/my_app_bar.dart';
import '../../../../Specialities/SpecialistDoctors/DoctorProfile/doctor_profile_modal.dart';

class NearHospitalDetails extends StatefulWidget {
  final SearchResult hospitalDetail;
  const NearHospitalDetails({Key? key, required this.hospitalDetail})
      : super(key: key);

  @override
  State<NearHospitalDetails> createState() => _NearHospitalDetailsState();
}

class _NearHospitalDetailsState extends State<NearHospitalDetails> {
  DetailsResult? result = DetailsResult(
    name: 'NA',
    formattedAddress: 'NA',
    adrAddress: 'NA',
    formattedPhoneNumber: '0000',
    // photos: List<Photo>[Photo(photoReference: '')]
  );

  @override
  void initState() {
    super.initState();
    getDetails();
  }

  getDetails() async {
    print('----------------' + widget.hospitalDetail.placeId.toString());
    var googlePlace = GooglePlace("AIzaSyBiCc5Juc52C8oAvuqo_y2rCQh6VU_802Q");
    DetailsResponse? data = await googlePlace.details.get(
        widget.hospitalDetail.placeId.toString(),
        fields:
            "formatted_address,name,rating,formatted_phone_number,photos,user_ratings_total,vicinity,international_phone_number,price_level,url");

    if (data != null) {
      setState(() {
        result = data.result;
      });
    }
  }
  
  DoctorProfileModal doctorProfileModal=DoctorProfileModal();
  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColor.primaryColor,
        child: SafeArea(
            child: Scaffold(
          appBar: MyWidget().myAppBar(context, title: 'Hospital Details'),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/hospital_buildings.svg',
                      height: 18,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text(result!.name.toString(),
                          style: MyTextTheme().mediumBCB),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,0,10,0),
                      child: IconButton(
                        onPressed: () async {
                          print('-------------------'+result!.internationalPhoneNumber.toString().trim().split('+91')[1].trim().length.toString());
                          await doctorProfileModal.sendSMSPatientToDoctor(context,result!.internationalPhoneNumber.toString().trim().split('+91')[1].trim());
                        },
                        icon: Image.asset(
                          'assets/sms.png',
                          height: 25,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                // Text("Address: "),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 15,
                      color: AppColor.orangeButtonColor,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text(
                        result!.formattedAddress.toString(),
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),

                Visibility(
                visible: result!.formattedPhoneNumber!=null,
                  child: Row(
                    children: [
                      Icon(
                        Icons.call,
                        color: AppColor.green,
                        size: 15,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        result!.formattedPhoneNumber.toString(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Visibility(
                  visible:  result!.internationalPhoneNumber!=null,
                  child: Row(
                    children: [
                      Icon(
                        Icons.call,
                        color: AppColor.red,
                        size: 15,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        result!.internationalPhoneNumber.toString(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                (result!.photos??[]).isEmpty?Container(
                  height: 200,
                  width:
                  MediaQuery.of(context).size.width /
                      1.06,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColor.greyLight),
                      borderRadius:
                      BorderRadius.circular(10)),
                  child: Image.asset(
                    'assets/logo.png',
                  ),
                ):CarouselSlider(
                  options: CarouselOptions(
                      autoPlay: true,
                      autoPlayAnimationDuration: const Duration(seconds: 1),
                      aspectRatio: 16 / 9,
                      height: 250.0,
                      enlargeCenterPage: true),
                  items: (result!.photos ?? []).map((snapShot) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: CachedNetworkImage(
                            // imageUrl:snapShot.photoReference.toString(),
                            imageUrl:
                                "https://maps.googleapis.com/maps/api/place/photo?photoreference=${snapShot.photoReference.toString()}&sensor=false&maxheight=1000&maxwidth=1000&key=AIzaSyBiCc5Juc52C8oAvuqo_y2rCQh6VU_802Q",
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            placeholder: (context, url) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Image.asset(
                                'assets/logo.png',
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Image.asset(
                                  'assets/logo.png',)),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),

                //Image.asset('assets/hospital-image-02.jpeg'),
                const SizedBox(
                  height: 10,
                ),
                Text("Rating : " +
                    result!.rating.toString() +
                    '  - ' +
                    result!.userRatingsTotal.toString() +
                    ' feedback'),
                Text(result!.url.toString()),
              ],
            ),
          ),
        )));
  }
}
