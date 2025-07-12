import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suitmedia_project1/blocs/polindrome/palindrome_bloc.dart';
import 'package:suitmedia_project1/blocs/polindrome/palindrome_event.dart';
import 'package:suitmedia_project1/blocs/polindrome/palindrome_state.dart';
import 'package:suitmedia_project1/screens/second_screen.dart';
import 'package:suitmedia_project1/constants/font_weight.dart';
import 'package:suitmedia_project1/widgets/poppins_text.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final _nameCtrl = TextEditingController();
  final _palindromeCtrl = TextEditingController();

  void _showResultDialog(bool isPalindrome) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Palindrome Check'),
        content: Text(
          isPalindrome ? 'It is a palindrome.' : 'It is not a palindrome.',
        ),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background_screen.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 130),
              child: GestureDetector(
                child: CircleAvatar(
                  backgroundColor: Colors.white.withValues(alpha: 0.4),
                  maxRadius: 116,
                  child: Icon(
                    Icons.person_add_alt_1,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Gap(32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  TextField(
                    controller: _nameCtrl,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xffE2E3E4),
                      hintText: "name",
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: medium,
                        color: Color(0xff686777),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  Gap(30),
                  TextField(
                    controller: _palindromeCtrl,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xffE2E3E4),
                      hintText: "Palindrome",
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: medium,
                        color: Color(0xff686777),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  Gap(58),
                  SizedBox(
                    width: double.infinity,
                    height: 41,
                    child: ElevatedButton(
                      onPressed: () {
                        final input = _palindromeCtrl.text.trim();
                        context.read<PalindromeBloc>().add(
                          CheckPalindromeEvent(input),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff2B637B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(12),
                        ),
                      ),
                      child: PoppinsText(
                        text: "CHECK",
                        fontSize: 14,
                        fontWeight: medium,
                        color: Color(0xffFFFFFF),
                      ),
                      // child: Text(
                      //   'Check',
                      //   style: GoogleFonts.poppins(
                      //     color: Color(0xffFFFFFF),
                      //     fontWeight: medium,
                      //     fontSize: 14,
                      //   ),
                      // ),
                    ),
                  ),
                  Gap(16),
                  SizedBox(
                    width: double.infinity,
                    height: 41,
                    child: ElevatedButton(
                      onPressed: () {
                        final name = _nameCtrl.text.trim();
                        if (name.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Name Cannot be Empty")),
                          );
                          return;
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SecondScreen(name: name),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff2B637B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(12),
                        ),
                      ),
                      child: PoppinsText(
                        text: "NEXT",
                        fontSize: 14,
                        fontWeight: medium,
                        color: Color(0xffFFFFFF),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Gap(20),
            BlocListener<PalindromeBloc, PalindromeState>(
              listener: (context, state) {
                if (state is PalindromeResults) {
                  _showResultDialog(state.isPalindrome);
                }
              },
              child: SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _palindromeCtrl.dispose();
    super.dispose();
  }
}
