import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hology_fe/shared/theme.dart';
import 'package:hology_fe/providers/HomeProvider/home_provider.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<HomeProvider>(context, listen: false).fetchUser(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    final userName = homeProvider.user?.name ?? "";
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Halo,",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: grey,
                ),
              ),
              Text(
                userName,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 5),
            ],
          ),
          GestureDetector(child: Image.asset("assets/images/profile.png", height: 40, width: 40)),
        ],
      ),
    );
  }
}
