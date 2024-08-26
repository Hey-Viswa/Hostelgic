import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../api_services/api_calls.dart';
import '../../../api_services/api_provider.dart';
import '../../../api_services/api_utils.dart';
import '../../../common/app_bar.dart';
import '../../../common/constants.dart';
import '../../../common/spacing.dart';
import '../../../models/staff_info_model.dart';

class StaffInfoScreen extends StatefulWidget {
  const StaffInfoScreen({super.key});

  @override
  State<StaffInfoScreen> createState() => _StaffInfoScreenState();
}

class _StaffInfoScreenState extends State<StaffInfoScreen> {
  StaffInfoModel? staffInfoModel;
  ApiCall apicall = ApiCall();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAllStaff();
  }

  Future<void> fetchAllStaff() async {
    try {
      final apiProvider = Provider.of<ApiProvider>(context, listen: false);
      final allstaff = await apiProvider.getRequest(ApiUrls.allStaff);

      if (allstaff.statusCode == 200) {
        final Map<String, dynamic> room = json.decode(allstaff.body);
        staffInfoModel = StaffInfoModel.fromJson(room);
      } else {
        print('Failed to fetch data');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'All Staff'),
      body: ApiUrls.roleId == 2 || ApiUrls.roleId == 3
          ? const Center(
              child: Text(
                "You don't have permission to view this page",
                style: TextStyle(color: Colors.redAccent, fontSize: 18),
              ),
            )
          : isLoading
              ? const Center(child: CircularProgressIndicator())
              : staffInfoModel == null || staffInfoModel!.result.isEmpty
                  ? const Center(
                      child: Text(
                        "No Staff is Registered yet.",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              MediaQuery.of(context).size.width > 600 ? 2 : 1,
                          childAspectRatio: 2 / 1.2,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                        ),
                        itemCount: staffInfoModel!.result.length,
                        itemBuilder: (context, index) {
                          final staff = staffInfoModel!.result[index];
                          return Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF00C853),
                                  Color(0xFF007B3B),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Image.asset(
                                            AppConstants.person,
                                            width: 90.w,
                                            height: 90.h,
                                          ),
                                          heightSpacer(20),
                                          Text(
                                            '${staff.jobRole}',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                      widthSpacer(20),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Name: ${staff.firstName}',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            heightSpacer(8.0),
                                            Text(
                                              'Email: ${staff.emailId}',
                                              style: TextStyle(
                                                color: Colors.white70,
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                            heightSpacer(8.0),
                                            Text(
                                              'Contact: ${staff.phoneNumber}',
                                              style: TextStyle(
                                                color: Colors.white70,
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    apicall.deleteStaff(context, staff.emailId);
                                    setState(() {
                                      fetchAllStaff();
                                    });
                                  },
                                  child: Container(
                                    width: double.maxFinite,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 12),
                                    decoration: BoxDecoration(
                                      color: Colors.redAccent,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Text(
                                      'Delete',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
    );
  }
}
