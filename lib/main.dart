import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:turkmen_localization_support/turkmen_localization_support.dart';

import 'generated/strings.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return TranslationProvider(
      child: Builder(builder: (context) {
        return MaterialApp(
          home: const HomeScreen(),
          locale: TranslationProvider.of(context).flutterLocale,
          supportedLocales: AppLocaleUtils.supportedLocales,
          localizationsDelegates: const [
            ...TkDelegates.delegates,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          debugShowCheckedModeBanner: false,
        );
      }),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _flag = false;

  @override
  Widget build(BuildContext context) {
    return Localizations.override(
      context: context,
      locale: AppLocale.tk.flutterLocale,
      delegates: const [
        ...TkDelegates.delegates,
      ],
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Switch(
                value: _flag,
                onChanged: (value) {
                  _flag = value;

                  if (_flag) {
                    LocaleSettings.setLocale(AppLocale.tk);
                  } else {
                    LocaleSettings.setLocale(AppLocale.ru);
                  }
                },
              ),
              Text(
                context.translations.hello,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              Text(
                DateFormat('dd LLL, yyyy').format(DateTime.now()),
                style: Theme.of(context).textTheme.displayMedium,
              ),
              Text(
                DateFormat(
                  'dd LLL, yyyy',
                  TranslationProvider.of(context).flutterLocale.toLanguageTag(),
                ).format(DateTime.now()),
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
