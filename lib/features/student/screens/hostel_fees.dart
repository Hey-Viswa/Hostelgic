import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/app_bar.dart';
import '../../../common/constants.dart';
import '../../../common/spacing.dart';

class HostelFee extends StatelessWidget {
  final String? blockNumber;
  final String? roomNumber;
  final String? maintenanceCharge;
  final String? parkingCharge;
  final String? waterCharge;
  final String? roomCharge;
  final String? totalCharge;

  HostelFee({
    super.key,
    required this.blockNumber,
    required this.roomNumber,
    required this.maintenanceCharge,
    required this.parkingCharge,
    required this.waterCharge,
    required this.roomCharge,
    required this.totalCharge,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context,
        'Hostel Fees',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            heightSpacer(20),
            SvgPicture.asset(
              AppConstants.hostel,
              height: 150.h,
            ),
            heightSpacer(20),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF2E8B57).withOpacity(0.3), Colors.white],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hostel Details',
                      style: TextStyle(
                        color: Color(0xFF2E8B57),
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    heightSpacer(20),
                    buildDetailRow('Block No.', blockNumber ?? 'N/A'),
                    buildDetailRow('Room No.', roomNumber ?? 'N/A'),
                    heightSpacer(20),
                    Text(
                      'Payment Details',
                      style: TextStyle(
                        color: const Color(0xFF333333),
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    heightSpacer(20),
                    buildDetailRow('Maintenance Charge',
                        '\$ ${maintenanceCharge ?? '0.00'}'),
                    buildDetailRow(
                        'Parking Charge', '\$ ${parkingCharge ?? '0.00'}'),
                    buildDetailRow(
                        'Water Charge', '\$ ${waterCharge ?? '0.00'}'),
                    buildDetailRow('Room Charge', '\$ ${roomCharge ?? '0.00'}'),
                    heightSpacer(20),
                    const Divider(color: Color(0xFF2E8B57), thickness: 2),
                    heightSpacer(20),
                    buildDetailRow(
                        'Total Amount', '\$ ${totalCharge ?? '0.00'}',
                        isBold: true),
                    heightSpacer(30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDetailRow(String title, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: const Color(0xFF464646),
              fontSize: 16.sp,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: const Color(0xFF464646),
              fontSize: 16.sp,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
