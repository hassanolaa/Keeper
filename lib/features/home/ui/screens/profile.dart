import 'package:bookmarker/core/routing/router.dart';
import 'package:bookmarker/core/theming/colors.dart';
import 'package:bookmarker/core/theming/size.dart';
import 'package:bookmarker/features/Auth/ui/screens/sign_in.dart';
import 'package:bookmarker/features/Auth/ui/screens/sign_up.dart';
import 'package:bookmarker/features/home/cubit/user_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatelessWidget {

  void launchURL(Uri uri) async {
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit()..fetchUserData(),
      child: BlocConsumer<UserCubit, UserState>(
          listener: (context, state) {
            if (state is UserError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(state.message),
                ),
              );
            } else if (state is UserDeleted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green,
                  content: Text('User deleted successfully'),
                ),
              );
              context.navigateTo(SignUpPage());
            }
          },
          builder: (context, state) {
            final cubit = BlocProvider.of<UserCubit>(context);

            return Scaffold(
              body: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/background.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
                    context.height_box(0.05),
                    CircleAvatar(
                      radius: context.fontSize(30),
                      backgroundColor: colors.coco,
                      child: Icon(
                        Icons.person,
                        size: context.fontSize(40),
                        color: Colors.white,
                      ),
                    ),
                    context.height_box(0.02),
                    Text(
                      state is UserLoaded
                          ? cubit.userData['username']
                          : "loading..",
                      style: TextStyle(
                          fontSize: context.fontSize(20),
                          fontWeight: FontWeight.bold,
                          color: colors.coco),
                    ),
                    context.height_box(0.01),
                    Text(
                      state is UserLoaded
                          ? cubit.userData['email']
                          : "loading..",
                      style: TextStyle(
                        fontSize: context.fontSize(14),
                        color: Colors.grey,
                      ),
                    ),
                    context.height_box(0.05),
                    Expanded(
                      child: ListView(
                        children: [
                       
                          _buildProfileOption(
                              'Language', Icons.language, () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                  backgroundColor: Colors.orange,  
                                  content: Text('This app is only supported in English for now'),
                                ));
                              }),
                          _buildProfileOption(
                              'Subscription', Icons.subscriptions, () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                  backgroundColor: Colors.green,  
                                  content: Text('You are now anjoined to our premium service for free'),
                                ));
                              }),
                            _buildProfileOption(
                              'About us', Icons.info, () {
                                // dialog to show the developer info and social media links
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('About Us'),
                                    content: Container(
                                      height: context.height(0.2),
                                      child: Column(
                                        children: [
                                          Text(
                                              'This app is developed by Hassan Abdelkhalek. \n\nFor more information, contact me on me social media platforms.'),
                                          context.height_box(0.02),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              IconButton(
                                                icon: Icon(Icons.facebook),
                                                onPressed: () {
                                                  launchURL(Uri.parse('https://www.facebook.com/hasan.abd.180'));
                                                },
                                              ),
                                              IconButton(
                                                icon: Icon(Bootstrap.linkedin),
                                                onPressed: () {
                                                  launchURL(Uri.parse('https://www.linkedin.com/in/hassan-abdlkhalek/'));

                                                },
                                              ),
                                              IconButton(
                                                icon: Icon(Bootstrap.github),
                                                onPressed: () {
                                                  launchURL(Uri.parse('https://github.com/hassanolaa'));
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('Close'),
                                      ),
                                    ],
                                  ),
                                );
                                
                              }),                     
                          _buildProfileOption(
                              'Delete Account', Icons.delete, () {
                                // dialog to confirm delete
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('Delete Account'),
                                    content: Text(
                                        'Are you sure you want to delete your account?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          cubit.deleteUser();
                                          Navigator.pop(context);
                                        },
                                        child: Text('Delete'),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                          _buildProfileOption('Logout', Icons.logout, () {
                            // dialog to confirm logout
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Logout'),
                                content: Text(
                                    'Are you sure you want to logout from your account?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      FirebaseAuth.instance.signOut();
                                      Navigator.pop(context);
                                      context.navigateTo(SignInPage());
                                    },
                                    child: Text('Logout'),
                                  ),
                                ],
                              ),
                            );
                            
                            }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget _buildProfileOption(String title, IconData icon, Function onTap) {
    return ListTile(
      leading: Icon(
        icon,
        color: colors.coco,
      ),
      title: Text(
        title,
        style: TextStyle(color: colors.coco),
      ),
      trailing: Icon(Icons.chevron_right),
      onTap: () {
        onTap();
      },
    );
  }
}
