import 'package:auto_route/auto_route.dart';
import 'package:dogs_case/constants/string_utils.dart';
import 'package:dogs_case/screens/home/bloc/home_bloc.dart';
import 'package:dogs_case/screens/home/bloc/home_event.dart';
import 'package:dogs_case/screens/home/bloc/home_state.dart';
import 'package:dogs_case/screens/home/home_screen.dart';
import 'package:dogs_case/screens/settings/settings_page.dart';
import 'package:dogs_case/screens/splash/splash_screen.dart';
import 'package:dogs_case/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage(name: 'MainScreenRouter')
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(context)..add(const LoadHomeEvent()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.isLoadingLoad ?? true) {
            return const SplashScreen();
          }
          return Scaffold(
              appBar: AppBar(
                  title: const Text(
                    StringUtils.appName,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  leading: const SizedBox.shrink(),
                  centerTitle: true,
                  surfaceTintColor: Colors.transparent),
              resizeToAvoidBottomInset: false,
              body: Center(
                  child: Stack(
                children: [
                  state.isLoadingData
                      ? const Center(child: CircularProgressIndicator())
                      : HomeScreen(state.dogList ?? [], state.searchText),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: CustomBottomNavBar(onTapBottomBar, context))
                ],
              )));
          // bottomNavigationBar: const CustomBottomNavBar());
        },
      ),
    );
  }

  onTapBottomBar(int index, BuildContext context) {
    if (index == 1) {
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) {
            return const SettingsPage();
          });
    } else {
      context.read<HomeBloc>().add(const LoadHomeEvent(homeButtonClick: true));
    }
  }
}
