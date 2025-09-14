import 'package:flutter/material.dart';
import 'package:hology_fe/features/mission/widgets/list_mission.dart';
import 'package:hology_fe/shared/theme.dart';

class Mission extends StatefulWidget {
  const Mission({super.key});

  @override
  State<Mission> createState() => _MissionState();
}

class _MissionState extends State<Mission> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Misi",
            style: TextStyle(
              color: Colors.black,
              fontWeight: semibold,
              fontSize: 18,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Container(
            color: whitegreenColor,
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xff99D69D),
                    borderRadius: BorderRadius.all(Radius.circular(99)),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      color: greenColor,
                      borderRadius: BorderRadius.horizontal(
                        left: _tabController.index == 0
                            ? const Radius.circular(99)
                            : Radius.zero,
                        right: _tabController.index == 1
                            ? const Radius.circular(99)
                            : Radius.zero,
                      ),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: whiteColor,
                    unselectedLabelColor: whiteColor,
                    onTap: (_) {
                      setState(() {});
                    },
                    tabs: const [
                      Tab(text: "Harian"),
                      Tab(text: "Mingguan"),
                    ],
                  ),
                ),
                SizedBox(height: 25),
                Expanded(
                  child: TabBarView(
                    children: [
                      SingleChildScrollView(child: ListMission()),
                      SingleChildScrollView(child: ListMission()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
