import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:shopping_app/features/profile/presentation/cubit/user_cubit.dart';
import 'package:shopping_app/features/profile/presentation/cubit/user_state.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key key}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  void didChangeDependencies() async {
    await context.cubit<UserCubit>().getUserInfo();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Profile')),
      body: CubitConsumer<UserCubit, UserState>(
        builder: (BuildContext context, UserState state) {
          print(state);
          if (state is UserInitial) {
            return _buildProgressIndicator();
          } else if (state is UserLoading) {
            return _buildProgressIndicator();
          } else if (state is UserLoaded) {
            return _buildUserInfoColumn(state);
          } else {
            return _buildError();
          }
        },
        listener: (BuildContext context, UserState state) {
          if (state is UserError) {
            Scaffold.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
      ),
    );
  }

  Center _buildProgressIndicator() => Center(child: CircularProgressIndicator());

  Center _buildError() => Center(child: Text("Error"));

  Column _buildUserInfoColumn(UserLoaded state) {
    return Column(
      children: [
        SizedBox(height: 16),
        CircleAvatar(
          child: Icon(Icons.account_circle),
          minRadius: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.account_circle),
                  SizedBox(width: 50),
                  Text(state.user.name),
                ],
              ),
              _buildDivider(),
              Row(
                children: [
                  Icon(Icons.mail),
                  SizedBox(width: 50),
                  Text(state.user.email),
                ],
              ),
              _buildDivider(),
              Row(
                children: [
                  Icon(Icons.calendar_today_sharp),
                  SizedBox(width: 50),
                  Text(state.user.birthday.toIso8601String().split("T")[0]),
                ],
              ),
              _buildDivider(),
              Row(
                children: [
                  Icon(Icons.shopping_cart),
                  SizedBox(width: 50),
                  Text(state.user.cart.length.toString()),
                ],
              ),
              _buildDivider(),
            ],
          ),
        )
      ],
    );
  }

  Divider _buildDivider() {
    return Divider(
      height: 30,
      color: Colors.grey,
      thickness: 0.5,
    );
  }
}
