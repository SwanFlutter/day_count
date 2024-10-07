/*import 'package:day_count/widget/cancel_buttom.dart';
import 'package:day_count/widget/confrim_button.dart';
import 'package:day_count/widget/text_feild_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:shamsi_date/shamsi_date.dart';

extension JalaliExtensions on Jalali {
  String formatFullDate() {
    final f = farsiNumberFormatter();
    return '${f.format(year)} / ${f.format(month)} / ${f.format(day)}';
  }

  NumberFormat farsiNumberFormatter() {
    return NumberFormat("##", "fa");
  }
}

typedef OnDateTimeChange = void Function(Jalali dateTime);

class PersianDatePicker extends StatefulWidget {
  final Color? backgroundColorBottomSheet;
  final ConfirmButtonConfig? confrimButtonConfig;
  final CancelButtonConfig? cancelButtonConfig;
  final Color dividerColor;
  final double? elevation;
  final Jalali firstDate;
  final Jalali lastDate;
  final num minAge;
  final OnDateTimeChange? onChanged;
  final double paddingHorizontal;
  final double paddingVertical;
  final Jalali selectedDate;
  final ShapeBorder? shapeBottomSheet;
  final TextFieldConfig textFieldConfig;

  PersianDatePicker({
    super.key,
    ShapeBorder? shapeBottomSheet,
    Jalali? firstDate,
    Jalali? lastDate,
    Jalali? selectedDate,
    this.backgroundColorBottomSheet,
    this.confrimButtonConfig,
    this.cancelButtonConfig,
    this.dividerColor = Colors.black,
    this.elevation = 20,
    this.minAge = 0,
    this.onChanged,
    this.paddingHorizontal = 0,
    this.paddingVertical = 0,
    TextFieldConfig? textFieldConfig,
  })  : selectedDate = selectedDate ?? Jalali(1374, 1, 1),
        firstDate = firstDate ?? Jalali(1300, 1, 1),
        lastDate = lastDate ?? Jalali(1450, 1, 1),
        shapeBottomSheet = shapeBottomSheet ?? RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        textFieldConfig = textFieldConfig ?? TextFieldConfig(),
        super();

  @override
  State<PersianDatePicker> createState() => _PersianDatePickerState();
  static bool _isInitialized = false;

  // مقداردهی داده‌های محلی برای زبان فارسی
  static Future<void> initializeDateFormattingIfNeeded() async {
    if (!_isInitialized) {
      await initializeDateFormatting('fa', null);
      _isInitialized = true;
    }
  }
}

class _PersianDatePickerState extends State<PersianDatePicker> with TickerProviderStateMixin {
  TextEditingController controller = TextEditingController();
  late Jalali currentDate;

  @override
  void initState() {
    super.initState();
    PersianDatePicker.initializeDateFormattingIfNeeded().then((_) {
      currentDate = widget.selectedDate;
      controller.text = currentDate.formatFullDate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: widget.paddingVertical,
          horizontal: widget.paddingHorizontal,
        ),
        child: TextField(
          textAlignVertical: TextAlignVertical.center,
          controller: controller,
          style: widget.textFieldConfig.style,
          cursorColor: widget.textFieldConfig.cursorColor,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: widget.textFieldConfig.height, horizontal: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.textFieldConfig.borderRadius),
              borderSide: BorderSide(color: widget.textFieldConfig.borderColor, width: widget.textFieldConfig.widthBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.textFieldConfig.borderRadius),
              borderSide: BorderSide(color: widget.textFieldConfig.focusedBorderColor, width: widget.textFieldConfig.widthFocusedBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.textFieldConfig.borderRadius),
              borderSide: BorderSide(color: widget.textFieldConfig.enabledBorderColor, width: widget.textFieldConfig.widthEnabledBorder),
            ),
            fillColor: widget.textFieldConfig.fillColor,
            filled: widget.textFieldConfig.filled,
            errorStyle: TextStyle(color: widget.textFieldConfig.errorColor),
            hintText: widget.textFieldConfig.hintText,
            hintStyle: TextStyle(color: widget.textFieldConfig.hintColor),
            labelText: widget.textFieldConfig.labelText,
            labelStyle: TextStyle(color: widget.textFieldConfig.labelHintColor),
            errorText: widget.textFieldConfig.errorText,
            prefix: Text(
              widget.textFieldConfig.prefix.toString(),
            ),
            prefixStyle: widget.textFieldConfig.prefixStyle,
            suffixIcon: InkResponse(
              onTap: onShowCalendarClick,
              child: Icon(widget.textFieldConfig.icon, color: widget.textFieldConfig.iconColor),
            ),
          ),
        ),
      ),
    );
  }

  void onShowCalendarClick() async {
    final aCtr = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      reverseDuration: const Duration(seconds: 1),
    );

    final res = await showModalBottomSheet(
      isScrollControlled: true,
      transitionAnimationController: aCtr,
      elevation: widget.elevation,
      backgroundColor: widget.backgroundColorBottomSheet ?? Theme.of(context).colorScheme.inversePrimary,
      shape: widget.shapeBottomSheet,
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PersianCalendarView(
              minAge: widget.minAge,
              selectedDate: currentDate,
              firstDate: widget.firstDate,
              lastDate: widget.lastDate,
              widget: widget,
            ),
            Divider(
              thickness: 1,
              color: widget.dividerColor,
              indent: 20,
              endIndent: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    height: widget.cancelButtonConfig?.height ?? 55,
                    minWidth: widget.cancelButtonConfig?.minWidth ?? MediaQuery.of(context).size.width * 0.3,
                    color: widget.cancelButtonConfig?.color ?? Colors.red,
                    shape: widget.cancelButtonConfig?.shape ?? const StadiumBorder(),
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      widget.cancelButtonConfig?.text ?? 'بازگشت',
                      style: widget.cancelButtonConfig?.style ??
                          const TextStyle(
                            color: Colors.white,
                          ),
                    ),
                  ),
                  MaterialButton(
                    height: widget.confrimButtonConfig?.height ?? 55,
                    minWidth: widget.confrimButtonConfig?.minWidth ?? MediaQuery.of(context).size.width * 0.3,
                    color: widget.confrimButtonConfig?.color ?? Colors.blue,
                    shape: widget.confrimButtonConfig?.shape ?? const StadiumBorder(),
                    onPressed: () {
                      Navigator.of(context).pop(currentDate);
                    },
                    child: Text(
                      widget.confrimButtonConfig?.text ?? "انتخاب",
                      style: widget.confrimButtonConfig?.style ??
                          const TextStyle(
                            color: Colors.white,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );

    if (res is Jalali) {
      currentDate = res;
      controller.text = currentDate.formatFullDate();
      widget.onChanged?.call(currentDate);
    }
  }
}

class PersianCalendarView extends StatefulWidget {
  final num minAge;
  final Jalali selectedDate;
  final Jalali firstDate;
  final Jalali lastDate;
  final PersianDatePicker widget;

  const PersianCalendarView({
    super.key,
    required this.minAge,
    required this.selectedDate,
    required this.firstDate,
    required this.lastDate,
    required this.widget,
  });

  @override
  State<PersianCalendarView> createState() => _PersianCalendarViewState();
}

class _PersianCalendarViewState extends State<PersianCalendarView> {
  late FixedExtentScrollController yearController;
  late FixedExtentScrollController monthController;
  late FixedExtentScrollController dayController;
  late Jalali currentDate;

  @override
  void initState() {
    super.initState();
    currentDate = widget.selectedDate;

    yearController = FixedExtentScrollController(initialItem: getSelectedYearIndex(currentDate));
    monthController = FixedExtentScrollController(initialItem: getSelectedMonthIndex(currentDate));
    dayController = FixedExtentScrollController(initialItem: getSelectedDayIndex(currentDate));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: SizedBox(
        height: size.height * 0.45,
        width: size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(
                currentDate.formatFullDate(),
                style: const TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Divider(
              thickness: 1,
              color: widget.widget.dividerColor,
              indent: 20,
              endIndent: 20,
            ),
            SizedBox(
              width: size.width * 0.9,
              height: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // year
                  Expanded(
                    child: CupertinoPicker.builder(
                      scrollController: yearController,
                      diameterRatio: 1.0,
                      itemExtent: 60,
                      onSelectedItemChanged: (value) async {
                        final y = getYears()[value];
                        final m = currentDate.month;

                        int dayCount = getDaysInMonth(y, m).length;

                        if (dayCount <= getSelectedDayIndex(currentDate)) {
                          final days = getDaysInMonth(y, m);
                          currentDate = Jalali(y, m, days[days.length - 1]);
                        } else {
                          currentDate = Jalali(y, m, currentDate.day);
                        }

                        yearController.jumpToItem(getSelectedYearIndex(currentDate));
                        setState(() {});
                      },
                      childCount: getYears().length,
                      itemBuilder: (context, index) {
                        return Center(
                          child: Text(
                            convertToPersianDigits(getYears()[index]).toString(),
                            style: const TextStyle(fontSize: 18),
                          ),
                        );
                      },
                    ),
                  ),
                  // month
                  Expanded(
                    child: CupertinoPicker.builder(
                      scrollController: monthController,
                      diameterRatio: 1.0,
                      itemExtent: 60,
                      onSelectedItemChanged: (value) async {
                        final m = getMonths()[value];
                        final y = currentDate.year;

                        int dayCount = getDaysInMonth(y, m).length;

                        if (dayCount <= getSelectedDayIndex(currentDate)) {
                          final days = getDaysInMonth(y, m);
                          currentDate = Jalali(y, m, days[days.length - 1]);
                        } else {
                          currentDate = Jalali(y, m, currentDate.day);
                        }

                        monthController.jumpToItem(getSelectedMonthIndex(currentDate));
                        setState(() {});
                      },
                      childCount: getMonths().length,
                      itemBuilder: (context, index) {
                        return Center(
                          child: Text(
                            convertToPersianDigits(getMonths()[index]),
                            style: const TextStyle(fontSize: 18),
                          ),
                        );
                      },
                    ),
                  ),

                  // day
                  Expanded(
                    child: CupertinoPicker.builder(
                      scrollController: dayController,
                      diameterRatio: 1.0,
                      itemExtent: 60,
                      onSelectedItemChanged: (value) async {
                        final d = getDays()[value];
                        final y = currentDate.year;
                        final m = currentDate.month;
                        currentDate = Jalali(y, m, d);
                        setState(() {});
                      },
                      childCount: getDays().length,
                      itemBuilder: (context, index) {
                        return Center(
                          child: Text(
                            convertToPersianDigits(getDays()[index]),
                            style: const TextStyle(fontSize: 18),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<int> getYears() {
    return List<int>.generate(widget.lastDate.year - widget.firstDate.year + 1, (index) => widget.firstDate.year + index);
  }

  int getSelectedYearIndex(Jalali date) {
    return getYears().indexOf(date.year);
  }

  List<int> getMonths() {
    return List<int>.generate(12, (index) => index + 1);
  }

  int getSelectedMonthIndex(Jalali date) {
    return getMonths().indexOf(date.month);
  }

  List<int> getDays() {
    return List<int>.generate(Jalali(currentDate.year, currentDate.month, 1).monthLength, (index) => index + 1);
  }

  int getSelectedDayIndex(Jalali date) {
    return getDays().indexOf(date.day);
  }

  List<int> getDaysInMonth(int year, int month) {
    return List<int>.generate(Jalali(year, month, 1).monthLength, (index) => index + 1);
  }

  String convertToPersianDigits(int number) {
    final persianDigits = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    return number.toString().replaceAllMapped(RegExp(r'\d'), (match) {
      return persianDigits[int.parse(match.group(0)!)];
    });
  }
}
*/