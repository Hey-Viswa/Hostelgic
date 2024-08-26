import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../api_services/api_calls.dart';
import '../../../api_services/api_provider.dart';
import '../../../api_services/api_utils.dart';
import '../../../common/app_bar.dart';
import '../../../common/constants.dart';
import '../../../models/room_change_model.dart';

class RoomChangeRequestScreen extends StatefulWidget {
  const RoomChangeRequestScreen({super.key});

  @override
  State<RoomChangeRequestScreen> createState() =>
      _RoomChangeRequestScreenState();
}

class _RoomChangeRequestScreenState extends State<RoomChangeRequestScreen> {
  RoomChangeModel? roomModel;

  Future<void> fetchRequests() async {
    try {
      final apiProvider = Provider.of<ApiProvider>(context, listen: false);
      final requestResponse =
          await apiProvider.getRequest(ApiUrls.roomChangeRequests);

      if (requestResponse.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(requestResponse.body);
        roomModel = RoomChangeModel.fromJson(data);
      } else {
        throw Exception('Failed to fetch requests');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Room Change Requests'),
      body: ApiUrls.roleId == 2 || ApiUrls.roleId == 3
          ? const Center(
              child: Text("You don't have permission to view this page"),
            )
          : FutureBuilder(
              future: fetchRequests(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final List<Result> room = roomModel?.result ?? [];
                  return room.isEmpty
                      ? const Center(
                          child: Text("No change room requests found"),
                        )
                      : ListView.builder(
                          itemCount: room.length,
                          itemBuilder: (context, index) {
                            final request = room[index];
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: RoomCard(request: request),
                            );
                          },
                        );
                }
              },
            ),
    );
  }
}

class RoomCard extends StatelessWidget {
  final Result request;

  const RoomCard({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    ApiCall apiCall = ApiCall();
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.teal.shade200,
                  Colors.teal.shade100,
                ],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            padding: EdgeInsets.all(16.sp),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: const AssetImage(AppConstants.person),
                  radius: 35.sp,
                ),
                SizedBox(width: 16.sp),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${request.studentDetails.firstName} ${request.studentDetails.lastName}',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8.sp),
                      Text(
                        'Username: ${request.studentDetails.firstName}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        'Current Room: ${request.currentRoomNumber}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        'Current Block: ${request.currentBlock}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(height: 8.sp),
                      Text(
                        'Email Id: ${request.studentDetails.emailId}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        'Phone No.: ${request.studentDetails.phoneNumber}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Asked For:',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8.sp),
                Text(
                  'Block: ${request.toChangeBlock}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.pinkAccent,
                  ),
                ),
                Text(
                  'Room No: ${request.toChangeRoomNumber}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.pinkAccent,
                  ),
                ),
                SizedBox(height: 16.sp),
                Text(
                  'Reason:',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8.sp),
                Text(
                  request.changeReason,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 16.sp),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          apiCall.approveOrRejectRequest(
                            request.roomChangeRequestId,
                            'REJECTED',
                            'REJECTED',
                            context,
                          );
                        },
                        child: Text(
                          'Reject',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.sp),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          apiCall.approveOrRejectRequest(
                            request.roomChangeRequestId,
                            'APPROVED',
                            'APPROVED',
                            context,
                          );
                        },
                        child: Text(
                          'Approve',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
