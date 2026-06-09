import 'package:cure_app/core/utils/app_colors.dart';
import 'package:cure_app/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatTab extends StatelessWidget {
  const ChatTab({super.key});

  final List<BuildChatTile> chats = const [
    BuildChatTile(
      name: 'CURE Support',
      lastMessage: 'Hello! How can we help you today?',
      time: '10:30 AM',
      isOnline: true,
      unreadCount: 1,
    ),
    BuildChatTile(
      name: 'Dr. Ahmed Ali',
      lastMessage: 'Your test results are ready.',
      time: 'Yesterday',
      isOnline: false,
      unreadCount: 0,
    ),
    BuildChatTile(
      name: 'Home Nursing Team',
      lastMessage: 'We are on our way to your location.',
      time: '12 May',
      isOnline: false,
      unreadCount: 0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0.w),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Text('Messages', style: AppStyles.semiBold24Text),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
            SliverList.builder(
              itemBuilder: (context, index) => chats[index],
              itemCount: chats.length,
            ),
          ],
        ),
      ),
    );
  }
}

class BuildChatTile extends StatelessWidget {
  const BuildChatTile({
    super.key,
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.isOnline,
    required this.unreadCount,
  });

  final String name;
  final String lastMessage;
  final String time;
  final bool isOnline;
  final int unreadCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 28.r,
                backgroundColor: AppColors.primaryColor.withValues(alpha: 0.1),
                child: Icon(
                  Icons.person,
                  color: AppColors.primaryColor,
                  size: 28.sp,
                ),
              ),
              if (isOnline)
                Positioned(
                  bottom: 2,
                  right: 2,
                  child: Container(
                    width: 14.w,
                    height: 14.h,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppStyles.semiBold18Text),
                SizedBox(height: 6.h),
                Text(
                  lastMessage,
                  style: AppStyles.semiBold16Text.copyWith(
                    color: AppColors.greyColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: 10.w),
          // Time and Unread Count
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                time,
                style: AppStyles.semiBold16Text.copyWith(
                  color: unreadCount > 0
                      ? AppColors.primaryColor
                      : AppColors.greyColor,
                ),
              ),
              SizedBox(height: 8.h),
              if (unreadCount > 0)
                Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    unreadCount.toString(),
                    style: AppStyles.bold12Text.copyWith(color: Colors.white),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
