import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../api_services/api_calls.dart';
import '../../../api_services/api_provider.dart';
import '../../../api_services/api_utils.dart';
import '../../../common/app_bar.dart';
import '../../../common/constants.dart';
import '../../../models/issue_model.dart';

class IssueScreen extends StatefulWidget {
  const IssueScreen({super.key});

  @override
  State<IssueScreen> createState() => _IssueScreenState();
}

class _IssueScreenState extends State<IssueScreen> {
  IssueModel? issueModel;

  Future<void> fetchIssues() async {
    try {
      final apiProvider = Provider.of<ApiProvider>(context, listen: false);
      final issueResponse = await apiProvider.getRequest(ApiUrls.allIssues);

      if (issueResponse.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(issueResponse.body);
        setState(() {
          issueModel = IssueModel.fromJson(data);
        });
      } else {
        throw Exception('Failed to fetch issues');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Student Issues'),
      body: FutureBuilder(
        future: fetchIssues(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final List<Result> issues = issueModel?.result ?? [];
            return issues.isEmpty
                ? const Center(
                    child: Text(
                      "No Issues found",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  )
                : ListView.builder(
                    itemCount: issues.length,
                    itemBuilder: (context, index) {
                      final issue = issues[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: IssueCard(issue: issue),
                      );
                    },
                  );
          }
        },
      ),
    );
  }
}

class IssueCard extends StatelessWidget {
  final Result issue;

  const IssueCard({super.key, required this.issue});

  @override
  Widget build(BuildContext context) {
    ApiCall apiCall = ApiCall();
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage(AppConstants.person),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${issue.studentDetails.firstName} ${issue.studentDetails.lastName}',
                        style: TextStyle(
                          color: const Color(0xFF333333),
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Username: ${issue.studentDetails.firstName}',
                        style: TextStyle(
                          color: const Color(0xFF333333),
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Room Number: ${issue.roomDetails.roomNumber}',
                        style: TextStyle(
                          color: const Color(0xFF333333),
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Email Id: ${issue.studentDetails.emailId}',
                        style: TextStyle(
                          color: const Color(0xFF333333),
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Phone No.: ${issue.studentDetails.phoneNumber}',
                        style: TextStyle(
                          color: const Color(0xFF333333),
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Text(
              'Issue:',
              style: TextStyle(
                color: const Color(0xFF333333),
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              issue.issue,
              style: TextStyle(
                color: const Color(0xFF333333),
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Student comment:',
              style: TextStyle(
                color: const Color(0xFF333333),
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              '“${issue.studentComment}”',
              style: TextStyle(
                color: const Color(0xFF333333),
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 20.h),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  apiCall.closeAnIssue(
                    issue.issueId,
                    'Considered',
                    context,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                ),
                child: Text(
                  'Resolve',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
