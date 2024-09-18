import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_sight_scope/core/helpers/spacing.dart';
import 'package:social_sight_scope/core/utils/color_manager.dart';
import 'package:social_sight_scope/core/widgets/app_button.dart';
import 'package:social_sight_scope/core/widgets/app_padding.dart';
import 'package:translator/translator.dart';

class TranslationScreen extends StatefulWidget {
  @override
  _TranslationScreenState createState() => _TranslationScreenState();
}

class _TranslationScreenState extends State<TranslationScreen> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _translatedTextController =
      TextEditingController();
  final translator = GoogleTranslator();

  String _fromLanguage = 'ar';
  String _toLanguage = 'en';

  void _translateText() async {
    var translation = await translator.translate(
      _textController.text,
      from: _fromLanguage,
      to: _toLanguage,
    );
    setState(() {
      _translatedTextController.text = translation.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('مترجم النصوص'),
      ),
      body: Column(
        children: [
          Expanded(
            child: AppPaddingWidget(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButtonFormField<String>(
                      value: _fromLanguage,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: ColorManager.primaryColor.withOpacity(.1)
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          _fromLanguage = newValue!;
                        });
                      },
                      items: _buildDropdownMenuItems(),
                    ),
                    verticalSpace(10.h),
                    TranslateTextFieldWidget(
                      textController: _textController,
                      label: 'أدخل النص',
                    ),
                    verticalSpace(10.h),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: ColorManager.errorColor.withOpacity(.1)
                      ),
                      value: _toLanguage,
                      onChanged: (String? newValue) {
                        setState(() {
                          _toLanguage = newValue!;
                        });
                      },
                      items: _buildDropdownMenuItems(),
                    ),
                    verticalSpace(10.h),
                    TranslateTextFieldWidget(
                      textController: _translatedTextController,
                      label: 'النص المترجم',
                      readOnly: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
          AppPaddingWidget(
              child: AppButton(onPressed: _translateText, text: 'ترجمة')),
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> _buildDropdownMenuItems() {
    final languages = {
      'af': 'Afrikaans',
      'sq': 'Albanian',
      'am': 'Amharic',
      'ar': 'العربية',
      'hy': 'Armenian',
      'az': 'Azerbaijani',
      'eu': 'Basque',
      'be': 'Belarusian',
      'bn': 'Bengali',
      'bs': 'Bosnian',
      'bg': 'Bulgarian',
      'ca': 'Catalan',
      'ceb': 'Cebuano',
      'zh-CN': 'Chinese (Simplified)',
      'zh-TW': 'Chinese (Traditional)',
      'co': 'Corsican',
      'hr': 'Croatian',
      'cs': 'Czech',
      'da': 'Danish',
      'nl': 'Dutch',
      'en': 'English',
      'eo': 'Esperanto',
      'et': 'Estonian',
      'fi': 'Finnish',
      'fr': 'Français',
      'fy': 'Frisian',
      'gl': 'Galician',
      'ka': 'Georgian',
      'de': 'Deutsch',
      'el': 'Greek',
      'gu': 'Gujarati',
      'ht': 'Haitian Creole',
      'ha': 'Hausa',
      'haw': 'Hawaiian',
      'he': 'Hebrew',
      'hi': 'Hindi',
      'hmn': 'Hmong',
      'hu': 'Hungarian',
      'is': 'Icelandic',
      'ig': 'Igbo',
      'id': 'Indonesian',
      'ga': 'Irish',
      'it': 'Italian',
      'ja': 'Japanese',
      'jv': 'Javanese',
      'kn': 'Kannada',
      'kk': 'Kazakh',
      'km': 'Khmer',
      'rw': 'Kinyarwanda',
      'ko': 'Korean',
      'ku': 'Kurdish',
      'ky': 'Kyrgyz',
      'lo': 'Lao',
      'la': 'Latin',
      'lv': 'Latvian',
      'lt': 'Lithuanian',
      'lb': 'Luxembourgish',
      'mk': 'Macedonian',
      'mg': 'Malagasy',
      'ms': 'Malay',
      'ml': 'Malayalam',
      'mt': 'Maltese',
      'mi': 'Maori',
      'mr': 'Marathi',
      'mn': 'Mongolian',
      'my': 'Myanmar (Burmese)',
      'ne': 'Nepali',
      'no': 'Norwegian',
      'ny': 'Nyanja (Chichewa)',
      'or': 'Odia (Oriya)',
      'ps': 'Pashto',
      'fa': 'Persian',
      'pl': 'Polish',
      'pt': 'Portuguese',
      'pa': 'Punjabi',
      'ro': 'Romanian',
      'ru': 'Russian',
      'sm': 'Samoan',
      'gd': 'Scots Gaelic',
      'sr': 'Serbian',
      'st': 'Sesotho',
      'sn': 'Shona',
      'sd': 'Sindhi',
      'si': 'Sinhala (Sinhalese)',
      'sk': 'Slovak',
      'sl': 'Slovenian',
      'so': 'Somali',
      'es': 'Español',
      'su': 'Sundanese',
      'sw': 'Swahili',
      'sv': 'Swedish',
      'tl': 'Tagalog (Filipino)',
      'tg': 'Tajik',
      'ta': 'Tamil',
      'tt': 'Tatar',
      'te': 'Telugu',
      'th': 'Thai',
      'tr': 'Turkish',
      'tk': 'Turkmen',
      'uk': 'Ukrainian',
      'ur': 'Urdu',
      'ug': 'Uyghur',
      'uz': 'Uzbek',
      'vi': 'Vietnamese',
      'cy': 'Welsh',
      'xh': 'Xhosa',
      'yi': 'Yiddish',
      'yo': 'Yoruba',
      'zu': 'Zulu',
      // أضف المزيد من اللغات هنا
    };

    return languages.entries.map((entry) {
      return DropdownMenuItem<String>(
        value: entry.key,
        child: Row(
          children: [
            // CountryFlag.fromLanguageCode(
            //   entry.key,
            //   width: 40.sp,
            //   height: 30.sp,
            //   shape: RoundedRectangle(8.r),
            // ),
            // SizedBox(width: 8),
            Text(entry.value),
          ],
        ),
      );
    }).toList();
  }
}

class TranslateTextFieldWidget extends StatelessWidget {
  const TranslateTextFieldWidget({
    super.key,
    required TextEditingController textController,
    required this.label,
    this.readOnly = false,
  }) : _textController = textController;

  final TextEditingController _textController;
  final String label;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: readOnly,
      minLines: 1,
      maxLines: 10,
      controller: _textController,
      decoration: InputDecoration(
        labelText: label,
      ),
    );
  }
}
