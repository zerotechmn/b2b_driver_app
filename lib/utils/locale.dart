import 'package:intl/date_symbol_data_custom.dart';
import 'package:intl/date_symbols.dart';

void initializeMongolianLocale() {
  initializeDateFormattingCustom(
    locale: 'mn_MN',
    symbols: DateSymbols(
      NAME: 'mn_MN',
      ERAS: ['МЭӨ', 'МЭ'],
      ERANAMES: ['манай эриний өмнөх', 'манай эриний'],
      NARROWMONTHS: [
        '1',
        '2',
        '3',
        '4',
        '5',
        '6',
        '7',
        '8',
        '9',
        '10',
        '11',
        '12',
      ],
      STANDALONENARROWMONTHS: [
        '1',
        '2',
        '3',
        '4',
        '5',
        '6',
        '7',
        '8',
        '9',
        '10',
        '11',
        '12',
      ],
      MONTHS: [
        'нэгдүгээр сар',
        'хоёрдугаар сар',
        'гуравдугаар сар',
        'дөрөвдүгээр сар',
        'тавдугаар сар',
        'зургаадугаар сар',
        'долоодугаар сар',
        'наймдугаар сар',
        'есдүгээр сар',
        'аравдугаар сар',
        'арван нэгдүгээр сар',
        'арван хоёрдугаар сар',
      ],
      STANDALONEMONTHS: [
        'Нэгдүгээр сар',
        'Хоёрдугаар сар',
        'Гуравдугаар сар',
        'Дөрөвдүгээр сар',
        'Тавдугаар сар',
        'Зургаадугаар сар',
        'Долоодугаар сар',
        'Наймдугаар сар',
        'Есдүгээр сар',
        'Аравдугаар сар',
        'Арван нэгдүгээр сар',
        'Арван хоёрдугаар сар',
      ],
      SHORTMONTHS: [
        '1-р сар',
        '2-р сар',
        '3-р сар',
        '4-р сар',
        '5-р сар',
        '6-р сар',
        '7-р сар',
        '8-р сар',
        '9-р сар',
        '10-р сар',
        '11-р сар',
        '12-р сар',
      ],
      STANDALONESHORTMONTHS: [
        '1-р сар',
        '2-р сар',
        '3-р сар',
        '4-р сар',
        '5-р сар',
        '6-р сар',
        '7-р сар',
        '8-р сар',
        '9-р сар',
        '10-р сар',
        '11-р сар',
        '12-р сар',
      ],
      WEEKDAYS: [
        'ням',
        'даваа',
        'мягмар',
        'лхагва',
        'пүрэв',
        'баасан',
        'бямба',
      ],
      STANDALONEWEEKDAYS: [
        'Ням',
        'Даваа',
        'Мягмар',
        'Лхагва',
        'Пүрэв',
        'Баасан',
        'Бямба',
      ],
      SHORTWEEKDAYS: ['Ня', 'Да', 'Мя', 'Лх', 'Пү', 'Ба', 'Бя'],
      STANDALONESHORTWEEKDAYS: ['Ня', 'Да', 'Мя', 'Лх', 'Пү', 'Ба', 'Бя'],
      NARROWWEEKDAYS: ['Н', 'Д', 'М', 'Л', 'П', 'Б', 'Б'],
      STANDALONENARROWWEEKDAYS: ['Н', 'Д', 'М', 'Л', 'П', 'Б', 'Б'],
      SHORTQUARTERS: ['I', 'II', 'III', 'IV'],
      QUARTERS: ['I улирал', 'II улирал', 'III улирал', 'IV улирал'],
      AMPMS: ['ҮӨ', 'ҮХ'], // Өглөө / Орой (morning/evening) can also be used
      DATEFORMATS: ['y.MM.dd', 'y MMM d', 'y MMMM d', 'y MMMM d, EEEE'],
      TIMEFORMATS: ['HH:mm', 'HH:mm:ss', 'HH:mm:ss z', 'HH:mm:ss zzzz'],
      FIRSTDAYOFWEEK: 1,
      WEEKENDRANGE: [6, 7],
      FIRSTWEEKCUTOFFDAY: 4,
      DATETIMEFORMATS: ['{1}, {0}', '{1}, {0}', '{1}, {0}', '{1}, {0}'],
    ),
    patterns: {
      'd': 'd', // 5
      'E': 'ccc', // Пү
      'EEEE': 'EEEE', // Пүрэв
      'LLL': 'LLL', // 5-р сар
      'LLLL': 'LLLL', // Тавдугаар сар
      'M': 'M', // 5
      'Md': 'M/d', // 5/5
      'MEd': 'EEE, M/d', // Пү, 5/5
      'MMM': 'LLL', // 5-р сар
      'MMMd': 'MMM d', // 5-р сар 5
      'MMMEd': 'EEE, MMM d', // Пү, 5-р сар 5
      'MMMM': 'LLLL', // Тавдугаар сар
      'MMMMd': 'MMMM d', // Тавдугаар сар 5
      'MMMMEEEEd': 'EEEE, MMMM d', // Пүрэв, Тавдугаар сар 5
      'QQQ': 'QQQ', // II улирал
      'QQQQ': 'QQQQ', // Хоёрдугаар улирал
      'y': 'y', // 2025
      'yM': 'y/M', // 2025/5
      'yMd': 'y/M/d', // 2025/5/5
      'yMEd': 'EEE, y/M/d', // Пү, 2025/5/5
      'yMMM': 'y MMM', // 2025 5-р сар
      'yMMMd': 'y MMM d', // 2025 5-р сар 5
      'yMMMEd': 'EEE, y MMM d', // Пү, 2025 5-р сар 5
      'yMMMM': 'y MMMM', // 2025 Тавдугаар сар
      'yMMMMd': 'y MMMM d', // 2025 Тавдугаар сар 5
      'yMMMMEEEEd': 'EEEE, y MMMM d', // Пүрэв, 2025 Тавдугаар сар 5
      'H': 'HH', // 00–23
      'Hm': 'HH:mm',
      'Hms': 'HH:mm:ss',
      'j': 'HH',
      'jm': 'HH:mm',
      'jms': 'HH:mm:ss',
      'jmv': 'HH:mm v',
      'jmz': 'HH:mm z',
      'jz': 'HH z',
      'v': 'v', // time zone
      'z': 'z', // time zone abbreviation
      'zzzz': 'zzzz', // full time zone name
    },
  );
}
