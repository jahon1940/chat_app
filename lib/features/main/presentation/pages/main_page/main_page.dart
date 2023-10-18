import 'package:empty_feature_folder/constants/constants.dart';
import 'package:empty_feature_folder/features/settings/presentation/pages/settings_page/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../chats/presentation/pages/chats_page/chats_page.dart';
import '../../bloc/main_bloc.dart';

class MainPage extends StatelessWidget {

  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
        index: state.bottomMenu.index,
        children: const [
          ChatsPage(),
          SettingsPage(),
        ],
          ),
          bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          context
              .read<MainBloc>()
              .add(SetBottomEvent(menu: BottomMenu.values[index]));
        },
        currentIndex: state.bottomMenu.index,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        fixedColor: Colors.black,

        items:  [
          BottomNavigationBarItem(
            label: "Chats",
            icon: SvgPicture.asset(AppIcons.chat,color: Colors.grey,),
            activeIcon: SvgPicture.asset(AppIcons.chat,color: Colors.black,),

          ),
          BottomNavigationBarItem(
            label: "Settings",
            icon: SvgPicture.asset(AppIcons.settings,color: Colors.grey,),
            activeIcon: SvgPicture.asset(AppIcons.settings,color: Colors.black,),
          ),
        ],
          ),
        );
      },
    );
  }
}
