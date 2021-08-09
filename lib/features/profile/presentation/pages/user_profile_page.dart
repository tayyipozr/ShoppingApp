import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:shopping_app/features/profile/presentation/cubit/user_cubit.dart';
import 'package:shopping_app/features/profile/presentation/cubit/user_state.dart';
import 'package:shopping_app/injection_container.dart' as injection;

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
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: CubitConsumer<UserCubit, UserState>(
          listener: (BuildContext context, UserState state) {
            if (state is UserError) {
              Scaffold.of(context).showSnackBar(SnackBar(content: Text("HERE")));
            }
          },
          builder: (BuildContext context, UserState state) {
            if (state is UserInitial) {
              return _buildProgressIndicator();
            } else if (state is UserLoading) {
              return _buildProgressIndicator();
            } else if (state is UserLoaded) {
              return _buildUserInfoColumn(state);
            } else {
              print(state.runtimeType);
              return _buildError();
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
        CircleAvatar(
          child: Icon(Icons.account_circle),
          minRadius: 30,
        ),
        ListTile(
          leading: Icon(Icons.account_circle),
          title: Text("Name"),
          subtitle: Text(state.user.name),
        ),
        Divider(
          color: Colors.grey,
          thickness: 0.8,
        ),
        ListTile(
          leading: Icon(Icons.mail),
          title: Text("Email"),
          subtitle: Text(state.user.email),
        ),
        Divider(
          color: Colors.grey,
          thickness: 0.8,
        ),
        ListTile(
          leading: Icon(Icons.calendar_today_sharp),
          title: Text("Birthday"),
          subtitle: Text(state.user.birthday.toIso8601String()),
        ),
        Divider(
          color: Colors.grey,
          thickness: 0.8,
        ),
        ListTile(
          leading: Icon(Icons.shopping_cart),
          title: Text("My Cart"),
          subtitle: Text(state.user.cart.length.toString()),
        ),
        ListTile(
          leading: Icon(Icons.favorite),
          title: Text("My Favorites"),
          subtitle: Text(state.user.favoriteProducts.length.toString()),
        ),
        Divider(
          color: Colors.grey,
          thickness: 0.8,
        ),
        RaisedButton(
          onPressed: () {},
          child: Text("Update Profile"),
        )
      ],
    );
  }
}
