import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:weather/core/constants/images.dart';
import 'package:weather/presentation/states/cubits/wether_cubit.dart';
import 'package:weather/presentation/widgets/temp_symbol.dart';

class ErrorMsgWidget extends StatelessWidget {
  final String msg;
  const ErrorMsgWidget({super.key, required this.msg});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(UIImages.peekingEyeEmoji),
        Text(
          '00${tempSymbol()}',
          style: const TextStyle(
            fontSize: 120,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Text(
          'ERROR',
          style: TextStyle(
            fontSize: 19,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Gap(3),
        Text(
          msg,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.w200,
          ),
        ),
        const Gap(13),
        CircleAvatar(
          radius: 25,
          backgroundColor: const Color(0xFF1A1929),
          child: IconButton(
            icon: const FaIcon(
              FontAwesomeIcons.arrowRotateRight,
              color: Colors.white,
            ),
            onPressed: () => BlocProvider.of<WeatherCubit>(context).fetchWeather(),
          ),
        ),
      ],
    );
  }
}
