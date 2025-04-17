import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_clone/common/helpers/is_dark_mode.dart';
import 'package:spotify_clone/core/configs/assets/app_img.dart';
import 'package:spotify_clone/core/configs/assets/app_vectors.dart';
import 'package:spotify_clone/core/configs/theme/app_colors.dart';
import 'package:spotify_clone/features/home_page/presentations/widgets/new_songs.dart';
import 'package:spotify_clone/features/main_page/presentations/cubit/page_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){}, 
          icon: Icon(
            Icons.settings,
            color: context.isDarkMode ? Colors.white : Colors.black
          )
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: SvgPicture.asset(
          AppVectors.logo_mini,
          height: 40,
          width: 40,
        ),
        actions: [
          IconButton(
            onPressed: (){
              final isMiniPlayer = context.read<PageCubit>().isMiniPlayer;
              BlocProvider.of<PageCubit>(context).changePage(1,isMiniPlayer);
            }, 
            icon: Icon(
              Icons.search,
              color: context.isDarkMode ? Colors.white : Colors.black
            )
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(child: _homeTopCard()),
            const SizedBox(height: 20),
            _tabBar(context),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 300,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    NewSongs(),
                    const Center(child: Text('Videos')),
                    const Center(child: Text('Artists')),
                    const Center(child: Text('Podcasts')),
                  ]
                ),
              ),
            ),
            if(context.read<PageCubit>().isMiniPlayer)...[
              const SizedBox(
                height: 40,
              )
            ]
          ],
        ),
      ),
    );
  }

  Widget _homeTopCard() {
    return SizedBox(
      height: 140,
      child: Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: SvgPicture.asset(
            AppVectors.homeBackground,
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 40),
            child: Image.asset(
              AppImg.homepage,
            ),
          ),
        )
      ]),
    );
  }

  Widget _tabBar(BuildContext context) {
    return TabBar(
      onTap: (index) {
        setState(() {
          _tabController.index = index;
        });
      },
      tabAlignment: TabAlignment.start,
      labelPadding: const EdgeInsets.symmetric(horizontal: 16),
      isScrollable: true,
      controller: _tabController,
      indicatorColor : AppColors.primary,
      labelColor: context.isDarkMode  ? Colors.white :  Colors.black,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      tabs: const [
        Text(
          'News',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          'Videos',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          'Artists',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          'Podcasts',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ]
    );
  }
}
