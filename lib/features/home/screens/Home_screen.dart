import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/constants.dart';
import '../../../common/spacing.dart';
import '../../../theme/colors.dart';
import '../../../theme/text_theme.dart';
import '../widgets/category_card.dart';
import '../widgets/pie_chart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.kBlueColor,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
        title: Text(
          "Dashboard",
          style: AppTextTheme.kLabelStyle.copyWith(
            fontSize: 22.sp,
            color: const Color(0xffffffff),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {},
              child: SizedBox(
                height: 48,
                width: 48,
                child: SvgPicture.asset(AppConstants.profile),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              heightSpacer(20),
              Container(
                height: 150.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [
                      AppColors.kBlueColor.withOpacity(0.8),
                      AppColors.kBlueColor.withOpacity(0.8),
                      AppColors.kBlueColor.withOpacity(0.8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xff2C3E50).withOpacity(0.5),
                      blurRadius: 8,
                      offset: const Offset(4, 0),
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Viswaranjan Giri",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 24.sp,
                            ),
                          ),
                          heightSpacer(10),
                          Row(
                            children: [
                              const Icon(Icons.apartment, color: Colors.white),
                              widthSpacer(5),
                              Text(
                                "Block No : B",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                ),
                              ),
                            ],
                          ),
                          heightSpacer(5),
                          Row(
                            children: [
                              const Icon(Icons.meeting_room,
                                  color: Colors.white),
                              widthSpacer(5),
                              Text(
                                "Room No : 201",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                AppConstants.createIssue,
                                height: 35,
                                width: 35,
                              ),
                            ),
                          ),
                          heightSpacer(10),
                          Text(
                            "Create Issue",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              heightSpacer(20),
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15.w,
                mainAxisSpacing: 15.h,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                children: [
                  CategoryCard(
                    title: "Room Availability",
                    icon: Icons.hotel,
                    color: Colors.blue,
                    onTap: () {
                      // Handle navigation or other actions here
                    },
                  ),
                  CategoryCard(
                    title: "All Issues",
                    icon: Icons.report_problem,
                    color: Colors.red,
                    onTap: () {
                      // Handle navigation or other actions here
                    },
                  ),
                  CategoryCard(
                    title: "Staff Members",
                    icon: Icons.group,
                    color: Colors.green,
                    onTap: () {
                      // Handle navigation or other actions here
                    },
                  ),
                  CategoryCard(
                    title: "Create Staff",
                    icon: Icons.person_add,
                    color: Colors.orange,
                    onTap: () {
                      // Handle navigation or other actions here
                    },
                  ),
                  CategoryCard(
                    title: "Hostel Fee",
                    icon: Icons.attach_money,
                    color: Colors.purple,
                    onTap: () {
                      // Handle navigation or other actions here
                    },
                  ),
                  CategoryCard(
                    title: "Change Request",
                    icon: Icons.edit,
                    color: Colors.teal,
                    onTap: () {
                      // Handle navigation or other actions here
                    },
                  ),
                ],
              ),
              heightSpacer(20),
              const Center(
                child: PieChartSample1(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
