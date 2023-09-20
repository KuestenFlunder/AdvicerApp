import 'package:api_name/application/advicer/advicer_bloc.dart';
import 'package:api_name/presentation/advicer/widgets/advice_field.dart';
import 'package:api_name/presentation/advicer/widgets/error_massage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../application/theme/theme_service.dart';
import 'widgets/custom_button.dart';

class AdvicerPage extends StatelessWidget {
  const AdvicerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Advicer", style: themeData.textTheme.headline1),
        actions: [
          Visibility(
            visible: !Provider.of<ThemeService>(context).useSystemTheme,
            child: Switch(
                value: Provider.of<ThemeService>(context).isDarkModeOn,
                onChanged: (_) {
                  Provider.of<ThemeService>(context, listen: false)
                      .toggleTheme();
                }),
          ),
          Switch(
              value: Provider.of<ThemeService>(context).useSystemTheme,
              activeColor: Colors.redAccent,
              onChanged: (_) {
                Provider.of<ThemeService>(context, listen: false)
                    .toggleUseSystemTheme();
              })
        ],
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: BlocBuilder<AdvicerBloc, AdvicerState>(
                    bloc: BlocProvider.of<AdvicerBloc>(context),
                    // initial AdviceRequestEvent when page is loaded
                    // ..add(AdviceRequestedEvent())

                    builder: (context, adviceState) {
                      if (adviceState is AdvicerInitial) {
                        return Text(
                          "Your Advice is waiting for you!",
                          style: themeData.textTheme.headline1,
                        );
                      } else if (adviceState is AdvicerStateLoading) {
                        return CircularProgressIndicator(
                            color: themeData.colorScheme.secondaryContainer);
                      } else if (adviceState is AdvicerStateLoaded) {
                        return AdviceField(
                          advice: adviceState.advice,
                          id: adviceState.id,
                        );
                      } else if (adviceState is AdvicerStateError) {
                        return ErrorMassage(message: adviceState.message);
                      }
                      return const Placeholder();
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 200,
                child: Center(
                  child: CustomButton(
                    onPressed: () {
                      BlocProvider.of<AdvicerBloc>(context)
                          .add(AdviceRequestedEvent());
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
