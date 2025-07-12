import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suitmedia_project1/blocs/user/user_bloc.dart';
import 'package:suitmedia_project1/blocs/user/user_event.dart';
import 'package:suitmedia_project1/blocs/user/user_state.dart';
import 'package:suitmedia_project1/constants/font_weight.dart';
import 'package:suitmedia_project1/widgets/poppins_text.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    context.read<UserBloc>().add(FetchUsers());
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  Future<void> _onRefresh() async {
    context.read<UserBloc>().add(FetchUsers(isRefresh: true));
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_hasReachedMax()) {
      context.read<UserBloc>().add(FetchUsers());
    }
  }

  bool _hasReachedMax() {
    final state = context.read<UserBloc>().state;
    return state is UserLoaded && state.hasReachedMax;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: PoppinsText(
          text: "Third Screen",
          fontSize: 18,
          fontWeight: semiBold,
          color: Color(0xff04021D),
        ),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoading && (state is! UserLoaded)) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserError) {
            return Center(child: Text("Error : ${state.message}"));
          }
          if (state is UserLoaded) {
            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: ListView.builder(
                itemCount: state.users.length + 1,
                itemBuilder: (context, index) {
                  if (index >= state.users.length) {
                    return state.hasReachedMax
                        ? const SizedBox.shrink()
                        : Center(child: CircularProgressIndicator());
                  }
                  final user = state.users[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.avatar),
                    ),
                    title: PoppinsText(
                      text: user.fullName,
                      fontSize: 16,
                      fontWeight: medium,
                      color: Color(0xff04021D),
                    ),
                    subtitle: PoppinsText(
                      text: user.email,
                      fontSize: 10,
                      fontWeight: medium,
                      color: Color(0xff686777),
                    ),
                    onTap: () => Navigator.pop(context, user),
                  );
                },
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
