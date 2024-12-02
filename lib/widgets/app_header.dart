import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/utils.dart';
import '../../config/theme/app_text_theme.dart';
import '../../config/theme/dark_theme.dart';
import '../../widgets/app_background.dart';
import '../../screens/home/profile_screen.dart';

class AppHeader extends StatelessWidget {
  final Size deviceSize;
  final DateTime date;
  final WidgetRef ref;
  final String title;

  const AppHeader({
    Key? key,
    required this.deviceSize,
    required this.date,
    required this.ref,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 27,
      child: Stack(
        children: [
          AppBackground(
            headerHeight: deviceSize.height * 0.27,
            header: SizedBox(
              height: deviceSize.height * 0.27, // Ensure the header has a fixed height
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0), // Adjust the value as needed
                      child: GestureDetector(
                        onTap: () {
                          // Navigate to ProfileScreen when the icon is tapped
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ProfileScreen()),
                          );
                        },
                        child: Icon(
                          Icons.person,
                          size: 30.0, // Customize the size
                          color: Colors.white, // Customize the color
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => Helpers.selectDate(context, ref),
                    child: Text(
                      Helpers.dateFormatter(date), // Format the date to string
                      style: AppTextTheme.applyBodyColor(
                          DarkTheme.theme.textTheme,
                          bodyColor: Colors.white
                      ).bodyMedium?.copyWith(
                        fontWeight: FontWeight.normal,
                        fontSize: 18, // Adjust size for the date text
                      ),
                    ),
                  ),
                  const SizedBox(height: 10), // Add space between date and title
                  Text(
                    title, // Dynamic title
                    style: AppTextTheme.applyBodyColor(
                        DarkTheme.theme.textTheme,
                        bodyColor: Colors.white
                    ).displayLarge?.copyWith(
                      fontSize: 40, // Adjust font size for the title
                      fontWeight: FontWeight.bold, // Make title bold
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
