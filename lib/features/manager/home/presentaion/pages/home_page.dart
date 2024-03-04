import 'package:flutter/material.dart';
import '../../../../../core/features/profile/manager/presentation/provider/manager_profile_provider.dart';
import '../widgets/widgets.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ManagerProfileProvider managerProfileProvider;

  @override
  void initState(){
    super.initState();
    managerProfileProvider = ManagerProfileProvider.of(context, listen: false);
    managerProfileProvider.getManagerProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Appbar(),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.2,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black26),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Colors.white,
              ),
              child: RefreshIndicator(
                onRefresh: ()async{
                  managerProfileProvider.getManagerProfileData();
                },
                child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height*0.03,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height*0.5,
                          width: double.infinity,
                          child: const MenuCircle(),
                        ),
                      ],
                    ),
                  ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
