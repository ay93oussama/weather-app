import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:weather/core/constants/colors.dart';
import 'package:weather/core/constants/images.dart';
import 'package:weather/core/router/app_router.dart';
import 'package:weather/presentation/states/cubits/weather_state.dart';
import 'package:weather/presentation/states/cubits/wether_cubit.dart';
import 'package:weather/presentation/widgets/divider_widget.dart';
import 'package:weather/presentation/widgets/error_widget.dart';
import 'package:weather/presentation/widgets/loading_widget.dart';
import 'package:weather/presentation/widgets/temp_symbol.dart';
import 'package:weather/presentation/widgets/tile.dart';
import 'package:weather/presentation/widgets/units_slider_widget.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int dayOfWeek = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              UIColors.orange,
              UIColors.lightPurple,
              UIColors.black,
            ],
            stops: const [0.2, 0.5, 1.0], // Control where the color stops happen
          ),
        ),
        child: BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoadingState) {
              return const LoadingWidget();
            } else if (state is WeatherLoadedState) {
              return _buildBody(state);
            } else if (state is WeatherErrorState) {
              return ErrorMsgWidget(msg: state.message);
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Rostock',
                style: TextStyle(
                  color: UIColors.white,
                  height: 1,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Gap(3),
              FaIcon(
                FontAwesomeIcons.locationArrow,
                size: 16,
                color: UIColors.white,
              ),
            ],
          ),
          Text(
            'Stay informed!',
            style: TextStyle(color: UIColors.white, letterSpacing: -1, fontSize: 22, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
          ),
        ],
      ),
      backgroundColor: UIColors.transparent,
      elevation: 0,
      actions: const [UnitsSliderWidget()],
    );
  }

  Widget _buildBody(WeatherLoadedState state) {
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<WeatherCubit>(context).fetchWeather();
      },
      child: ListView(
        children: [
          _buildWeatherDisplay(state),
          const DividerWidget(),
          _buildWeatherInfo(state),
          const DividerWidget(),
          _buildOthersSection(),
          const Gap(10),
          _buildHorizontalList(state),
        ],
      ),
    );
  }

  Widget _buildWeatherDisplay(WeatherLoadedState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Image.asset(UIImages.getWeatherIcon(state.weathers[dayOfWeek].weather?.firstOrNull?.id ?? 0)),
        Text(
          '${state.weathers[dayOfWeek].main?.temp?.toStringAsFixed(0)}${tempSymbol()}',
          style: TextStyle(
            fontSize: 120,
            color: UIColors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          '${state.weathers[dayOfWeek].weather?.firstOrNull?.main?.toUpperCase()}',
          style: TextStyle(
            fontSize: 19,
            color: UIColors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Gap(3),
        Text(
          //    'Friday 16 • 09.41 am',
          state.weathers[dayOfWeek].formattedDate,
          style: TextStyle(
            fontSize: 15,
            color: UIColors.white,
            fontWeight: FontWeight.w200,
          ),
        ),
      ],
    );
  }

  Widget _buildWeatherInfo(WeatherLoadedState state) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Tile(
              leading: UIImages.humidity,
              title: 'Humidity',
              subTitle: '${state.weathers[dayOfWeek].main?.humidity}%',
            ),
            Tile(
              leading: UIImages.windFace,
              title: 'Wind speed',
              subTitle: '${state.weathers[0].wind?.speed}km/h',
            ),
          ],
        ),
        const DividerWidget(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Tile(
              leading: UIImages.compass,
              title: 'pressure',
              subTitle: '${state.weathers[dayOfWeek].main?.pressure} hPa',
            ),
            Tile(
              leading: UIImages.sun,
              title: 'Temp. min',
              subTitle: '${state.weathers[dayOfWeek].main?.tempMin}${tempSymbol()}',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOthersSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => Navigator.of(context).pushNamed(AppRouter.weekWeatherView),
          child: Text(
            'Others',
            style: TextStyle(
              fontSize: 19,
              color: UIColors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const Gap(5),
        FaIcon(
          FontAwesomeIcons.chevronRight,
          size: 16,
          color: UIColors.white,
        ),
      ],
    );
  }

  Widget _buildHorizontalList(WeatherLoadedState state) {
    return SizedBox(
      height: 70,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: state.weathers.length,
        separatorBuilder: (BuildContext context, int index) => const Gap(7),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              setState(() {
                dayOfWeek = index;
              });
            },
            child: Stack(
              children: [
                Container(
                  width: 120,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: dayOfWeek == index
                        ? Border.all(
                            width: 2,
                            color: UIColors.orange,
                          )
                        : null,
                    borderRadius: BorderRadius.circular(4),
                    color: UIColors.darkPurple,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${state.weathers[index].formattedAbbreviatedDayOfWeekName} ${state.weathers[index].dtTxt?.day}',
                        style: TextStyle(fontSize: 14, color: UIColors.white, fontStyle: FontStyle.italic, fontWeight: FontWeight.w200),
                      ),
                      const Gap(3),
                      Text(
                        '${state.weathers[index].main?.temp?.toStringAsFixed(0)}${tempSymbol()}',
                        style: TextStyle(fontWeight: FontWeight.w800, color: UIColors.white, fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 5,
                  child: Image.asset(
                    UIImages.getWeatherIcon(state.weathers[index].weather?.firstOrNull?.id ?? 0),
                    width: 50,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
