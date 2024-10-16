import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:weather/core/constants/colors.dart';
import 'package:weather/core/constants/images.dart';
import 'package:weather/domain/entities/weather.dart';
import 'package:weather/presentation/states/cubits/weather_state.dart';
import 'package:weather/presentation/states/cubits/wether_cubit.dart';
import 'package:weather/presentation/widgets/divider_widget.dart';
import 'package:weather/presentation/widgets/error_widget.dart';
import 'package:weather/presentation/widgets/loading_widget.dart';
import 'package:weather/presentation/widgets/temp_symbol.dart';

class WeekWeatherView extends StatelessWidget {
  const WeekWeatherView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar(context) {
    return AppBar(
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: FaIcon(
          FontAwesomeIcons.circleArrowLeft,
          color: UIColors.white,
        ),
      ),
      centerTitle: false,
      title: Text(
        'Back',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: UIColors.white,
          fontSize: 22,
        ),
      ),
      backgroundColor: UIColors.transparent,
      elevation: 0,
    );
  }

  Widget _buildBody(BuildContext context) {
    return Stack(
      children: [
        _buildBackground(),
        Positioned(
          top: 50,
          right: 0,
          child: Image.asset(
            UIImages.comet,
            width: 150,
          ),
        ),
        _buildContent(context),
      ],
    );
  }

  Widget _buildBackground() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            UIColors.blue,
            UIColors.purple,
            UIColors.black,
          ],
          stops: const [0.2, 0.5, 1.0],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(150),
          Text(
            'This Week',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: UIColors.white,
              fontSize: 25,
              height: 1.8,
            ),
          ),
          const Gap(30),
          BlocBuilder<WeatherCubit, WeatherState>(
            builder: (context, state) {
              if (state is WeatherLoadingState) {
                return const LoadingWidget();
              } else if (state is WeatherLoadedState) {
                return _buildWeatherList(context, state);
              } else if (state is WeatherErrorState) {
                return ErrorMsgWidget(msg: state.message);
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherList(BuildContext context, WeatherLoadedState state) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<WeatherCubit>().fetchWeather();
      },
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: state.weathers.length,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        separatorBuilder: (_, __) => const DividerWidget(),
        itemBuilder: (context, index) {
          final weather = state.weathers[index];
          return _buildWeatherRow(weather);
        },
      ),
    );
  }

  Widget _buildWeatherRow(Weather weather) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          weather.formattedAbbreviatedDayOfWeekName,
          style: TextStyle(
            color: UIColors.white,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        _buildWeatherCondition(weather),
        Text(
          '${weather.main?.temp?.toStringAsFixed(0)}${tempSymbol()}',
          style: TextStyle(
            color: UIColors.white,
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildWeatherCondition(Weather weather) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          UIImages.getWeatherIcon(weather.weather?.firstOrNull?.id ?? 0),
          width: 35,
        ),
        const Gap(5),
        Text(
          '${weather.weather?.firstOrNull?.main}',
          style: TextStyle(
            color: UIColors.white,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
