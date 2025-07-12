import 'package:flutter/material.dart';
import 'package:suitmedia_project1/models/user.dart';
import 'package:suitmedia_project1/constants/font_weight.dart';
import 'package:suitmedia_project1/screens/third_screen.dart';
import 'package:suitmedia_project1/widgets/poppins_text.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key, required this.name});

  final String name;

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  User? selectedUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        //   icon: Icon(Icons.arrow_back),
        // ),
        centerTitle: true,
        title: PoppinsText(
          text: "Second Screen",
          fontSize: 18,
          fontWeight: semiBold,
          color: Color(0xff04021D),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PoppinsText(
                    text: "welcome",
                    fontSize: 12,
                    fontWeight: regular,
                    color: Color(0xff04021D),
                  ),
                  PoppinsText(
                    text: widget.name,
                    fontSize: 18,
                    fontWeight: semiBold,
                    color: Color(0xff04021D),
                  ),
                ],
              ),
            ),
            Spacer(),
            PoppinsText(
              text: "Selected User ${selectedUser?.fullName ?? "Name"}",
              fontSize: 24,
              fontWeight: semiBold,
              color: Color(0xff04021D),
              textAlign: TextAlign.center,
            ),
            // PoppinsText(
            //   text: selectedUser?.fullName ?? "",
            //   fontSize: 24,
            //   fontWeight: semiBold,
            //   color: Color(0xff04021D),
            //   textAlign: TextAlign.center,
            // ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: SizedBox(
                width: double.infinity,
                height: 41,

                child: ElevatedButton(
                  onPressed: () async {
                    final user = await Navigator.push<User>(
                      context,
                      MaterialPageRoute(builder: (_) => const ThirdScreen()),
                    );

                    if (user != null) {
                      setState(() {
                        selectedUser = user;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff2B637B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(12),
                    ),
                  ),
                  child: PoppinsText(
                    text: "Choose a User",
                    fontSize: 14,
                    fontWeight: medium,
                    color: Color(0xffFFFFFF),
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
