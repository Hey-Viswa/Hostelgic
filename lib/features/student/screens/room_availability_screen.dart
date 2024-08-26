import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../api_services/api_provider.dart';
import '../../../api_services/api_utils.dart';
import '../../../common/app_bar.dart';
import '../../../common/constants.dart';
import '../../../models/room_availability_model.dart';
import 'change_room_screen.dart';

class RoomAvailabilityScreen extends StatefulWidget {
  const RoomAvailabilityScreen({super.key});

  @override
  State<RoomAvailabilityScreen> createState() => _RoomAvailabilityScreenState();
}

class _RoomAvailabilityScreenState extends State<RoomAvailabilityScreen> {
  RoomAvailability? roomAvailabile;

  Future<void> fetchData() async {
    try {
      final apiProvider = Provider.of<ApiProvider>(context, listen: false);
      final roomAvailability =
          await apiProvider.getRequest(ApiUrls.roomAvailability);

      if (roomAvailability.statusCode == 200) {
        final Map<String, dynamic> room = json.decode(roomAvailability.body);
        print(roomAvailability.body);

        roomAvailabile = RoomAvailability.fromJson(room);
      } else {
        print('Failed to fetch data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Room Availabilities'),
      backgroundColor: Colors.grey[200],
      body: FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return roomAvailabile == null
                ? const Center(
                    child: Text(
                      "No Availability",
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.all(16.0.w),
                    child: ListView.builder(
                      itemCount: roomAvailabile!.result.length,
                      itemBuilder: (context, index) {
                        final room = roomAvailabile!.result[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: RoomCard(room: room),
                        );
                      },
                    ),
                  );
          }
        },
      ),
    );
  }
}

class RoomCard extends StatelessWidget {
  final Result room;

  const RoomCard({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.r),
      ),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Image.asset(
                AppConstants.bed,
                height: 70.h,
                width: 70.w,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Room no. - ${room.roomNumber}',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Block ${room.blockId.block}',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Capacity: ${room.roomCapacity}',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Current Capacity: ${room.roomCurrentCapacity}',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 4.h),
                  if (room.roomType != null)
                    Text(
                      'Type: ${room.roomType!.roomType}',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.grey[700],
                      ),
                    ),
                  SizedBox(height: 8.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 8.0.w, vertical: 4.0.h),
                    decoration: BoxDecoration(
                      color: room.roomCurrentCapacity == 5
                          ? Colors.amber
                          : Colors.green,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: room.roomCurrentCapacity == 5
                          ? Text(
                              'Unavailable',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ChangeRoomScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'Available',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
