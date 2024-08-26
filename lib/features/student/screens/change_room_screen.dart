import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../api_services/api_calls.dart';
import '../../../api_services/api_utils.dart';
import '../../../common/app_bar.dart';
import '../../../common/spacing.dart';
import '../../auth/widgets/custom_button.dart';
import '../../auth/widgets/custom_text_field.dart';

class ChangeRoomScreen extends StatefulWidget {
  const ChangeRoomScreen({super.key});

  @override
  State<ChangeRoomScreen> createState() => _ChangeRoomScreenState();
}

class _ChangeRoomScreenState extends State<ChangeRoomScreen> {
  ApiCall apiCall = ApiCall();
  String? selectedBlock;
  String? selectedRoom;
  TextEditingController reason = TextEditingController();
  List<String> blockOptions = ['A', 'B'];
  List<String> roomOptionsA = ['101', '102', '103'];
  List<String> roomOptionsB = ['201', '202', '203'];

  @override
  void dispose() {
    super.dispose();
    reason.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: buildAppBar(context, 'Change Room'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current Block and Room No.',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    heightSpacer(15),
                    Row(
                      children: [
                        _buildInfoCard('Room No', ApiUrls.roomNumber),
                        widthSpacer(20),
                        _buildInfoCard('Block No', ApiUrls.blockNumber),
                      ],
                    ),
                    heightSpacer(25),
                    Text(
                      'Shift to Block and Room No.',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    heightSpacer(15),
                    Row(
                      children: [
                        Expanded(
                          child: _buildDropdown(
                            value: selectedBlock,
                            items: blockOptions,
                            hint: 'Select Block',
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedBlock = newValue;
                                selectedRoom = null;
                              });
                            },
                          ),
                        ),
                        widthSpacer(20),
                        Expanded(
                          child: _buildDropdown(
                            value: selectedRoom,
                            items: selectedBlock == 'A'
                                ? roomOptionsA
                                : roomOptionsB,
                            hint: 'Select Room',
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedRoom = newValue;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    heightSpacer(25),
                    Text(
                      'Reason for Change',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    heightSpacer(15),
                    CustomTextField(
                      controller: reason,
                      inputHint: 'Write your reason',
                    ),
                    heightSpacer(40),
                    CustomButton(
                      press: () {
                        if (selectedRoom != null &&
                            selectedBlock != null &&
                            reason.text.isNotEmpty) {
                          apiCall.roomChangeRequest(
                            selectedRoom!,
                            selectedBlock!,
                            reason.text,
                            context,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Please fill all fields before submitting.'),
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                        }
                      },
                      buttonText: 'Submit',
                      size: null,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String? info) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(15.w),
        decoration: BoxDecoration(
          color: const Color(0xFF2E8B57),
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            heightSpacer(10),
            Text(
              info ?? '',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String? value,
    required List<String> items,
    required String hint,
    required ValueChanged<String?>? onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: DropdownButton<String>(
        value: value,
        isExpanded: true,
        underline: const SizedBox(),
        hint: Text(hint),
        onChanged: onChanged,
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
      ),
    );
  }
}
