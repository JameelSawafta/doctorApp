import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';

import '../doctor/appointment.dart';


class AllDoctors extends StatefulWidget {
  var allDoctors;
  var userData;

  AllDoctors({Key? key, this.allDoctors, this.userData}) : super(key: key);

  @override
  State<AllDoctors> createState() => _AllDoctorsState();
}

class _AllDoctorsState extends State<AllDoctors> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment:CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Text("All Doctors",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      showSearch(context: context, delegate: DataSearch(doctors: widget.allDoctors, userData: widget.userData));
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: widget.allDoctors?.length ?? 0,
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(

                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  widget.allDoctors?[index]['photo'] == null
                                      ? Image.asset('images/person.png', width: 70, height: 70)
                                      : Image.network(
                                    widget.allDoctors?[index]['photo'],
                                    width: 70,
                                    height: 70,
                                    loadingBuilder: (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Image.asset('images/person.png', width: 70, height: 70);
                                    },
                                    errorBuilder: (context, error, stackTrace) =>
                                        Image.asset('images/person.png', width: 70, height: 70),
                                  ),

                                  SizedBox(width: 10,),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(widget.allDoctors?[index]['name'] !=null ? "Dr ${widget.allDoctors?[index]['name']}" : "",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                        SizedBox(height: 2,),
                                        Text(widget.allDoctors?[index]['jobTitle'] ?? "",style: TextStyle(fontSize: 13,color: Color(0xff7563F7)),),
                                        SizedBox(height: 4,),
                                        // year of experience
                                        Text("${widget.allDoctors?[index]['yearsExperience'] ?? ""} Years of Experience",style: TextStyle(fontSize: 13,),),

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  RatingBar.builder(
                                    initialRating: widget.allDoctors?[index]['rating']?.toDouble() ?? 0,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 20,
                                    itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    ignoreGestures: true,
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  ),
                                  Spacer(),
                                  InkWell(
                                    onTap: (){
                                      Get.to(Appointment(doctorData: widget.allDoctors?[index],userData: widget.userData,));
                                    },
                                    child: Container(
                                      height: 34,
                                      width: 112,
                                      decoration: BoxDecoration(
                                        color: Color(0xffB28CFF),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Center(child: Text("View",style: TextStyle(color: Colors.white,fontSize: 14),)),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}



class DataSearch extends SearchDelegate{

  DataSearch({this.doctors,this.userData});

  var doctors ;
  var userData;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        }
    );
  }

  @override
  Widget buildResults(BuildContext context) {

    var filteredNames = [];

    for(int i = 0 ; i < doctors.length ; i++){
      if(doctors[i]['name'].toLowerCase().contains(query.toLowerCase())){
        filteredNames.add(doctors[i]);
      }
    }


    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: filteredNames.length ?? 0,
      itemBuilder: (context,index){
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        filteredNames[index]['photo'] == null
                            ? Image.asset('images/person.png', width: 70, height: 70)
                            : Image.network(
                          filteredNames[index]['photo'],
                          width: 70,
                          height: 70,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Image.asset('images/person.png', width: 70, height: 70);
                          },
                          errorBuilder: (context, error, stackTrace) =>
                              Image.asset('images/person.png', width: 70, height: 70),
                        ),
                        SizedBox(width: 10,),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(filteredNames[index]['name'] !=null ? "Dr ${filteredNames[index]['name']}" : "",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                              SizedBox(height: 2,),
                              Text(filteredNames[index]['jobTitle'] ?? "",style: TextStyle(fontSize: 13,color: Color(0xff7563F7)),),
                              SizedBox(height: 4,),
                              // year of experience
                              Text("${filteredNames[index]['yearsExperience'] ?? ""} Years of Experience",style: TextStyle(fontSize: 13,),),

                            ],
                          ),
                        ),

                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        RatingBar.builder(
                          initialRating: filteredNames[index]['rating']?.toDouble() ?? 0,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 20,
                          itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          ignoreGestures: true,
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                        Spacer(),
                        InkWell(
                          onTap: (){
                            Get.to(Appointment(doctorData: filteredNames[index], userData: userData));
                          },
                          child: Container(
                            height: 34,
                            width: 112,
                            decoration: BoxDecoration(
                              color: Color(0xffB28CFF),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(child: Text("View",style: TextStyle(color: Colors.white,fontSize: 14),)),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }


  @override
  Widget buildSuggestions(BuildContext context) {



    var filteredNames = [];

    for(int i = 0 ; i < doctors.length ; i++){
      if(doctors[i]['name'].toLowerCase().contains(query.toLowerCase())){
        filteredNames.add(doctors[i]);
      }
    }


    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: filteredNames.length ?? 0,
      itemBuilder: (context,index){
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        filteredNames[index]['photo'] == null
                            ? Image.asset('images/person.png', width: 70, height: 70)
                            : Image.network(
                          filteredNames[index]['photo'],
                          width: 70,
                          height: 70,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Image.asset('images/person.png', width: 70, height: 70);
                          },
                          errorBuilder: (context, error, stackTrace) =>
                              Image.asset('images/person.png', width: 70, height: 70),
                        ),
                        SizedBox(width: 10,),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(filteredNames[index]['name'] !=null ? "Dr ${filteredNames[index]['name']}" : "",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                              SizedBox(height: 2,),
                              Text(filteredNames[index]['jobTitle'] ?? "",style: TextStyle(fontSize: 13,color: Color(0xff7563F7)),),
                              SizedBox(height: 4,),
                              // year of experience
                              Text("${filteredNames[index]['yearsExperience'] ?? ""} Years of Experience",style: TextStyle(fontSize: 13,),),

                            ],
                          ),
                        ),

                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        RatingBar.builder(
                          initialRating: filteredNames[index]['rating']?.toDouble() ?? 0,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 20,
                          itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          ignoreGestures: true,
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                        Spacer(),
                        InkWell(
                          onTap: (){
                            Get.to(Appointment(doctorData: filteredNames[index], userData: userData));
                          },
                          child: Container(
                            height: 34,
                            width: 112,
                            decoration: BoxDecoration(
                              color: Color(0xffB28CFF),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(child: Text("View",style: TextStyle(color: Colors.white,fontSize: 14),)),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

}