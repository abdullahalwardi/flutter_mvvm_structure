class PhoneNumber {
  String countryISOCode;
  String countryCode;
  String number;

  PhoneNumber({
    required this.countryISOCode,
    required this.countryCode,
    required this.number,
  });

  String get completeNumber {
    return countryCode + number;
  }

  @override
  String toString() =>
      'PhoneNumber(countryISOCode: $countryISOCode, countryCode: $countryCode, number: $number)';
}

final RegExp _countryCodesRegex = RegExp("""\\+(?:
  998|996|995|994|993|992|977|976|975|974|973|972|971|970|968|967|966|965|964|
  963|962|961|960|886|880|856|855|853|852|850|692|691|690|689|688|687|686|685|
  683|682|681|680|679|678|677|676|675|674|673|672|670|599|598|597|595|593|592|
  591|590|509|508|507|506|505|504|503|502|501|500|423|421|420|389|387|386|385|
  383|382|381|380|379|378|377|376|375|374|373|372|371|370|359|358|357|356|355|
  354|353|352|351|350|299|298|297|291|290|269|268|267|266|265|264|263|262|261|
  260|258|257|256|255|254|253|252|251|250|249|248|246|245|244|243|242|241|240|
  239|238|237|236|235|234|233|232|231|230|229|228|227|226|225|224|223|222|221|
  220|218|216|213|212|211|98|95|94|93|92|91|90|86|84|82|81|66|65|64|63|62|61|
  60|58|57|56|55|54|53|52|51|49|48|47|46|45|44\\D?1624|44\\D?1534|44\\D?1481|
  44|43|41|40|39|36|34|33|32|31|30|27|20|7|1\\D?939|1\\D?876|1\\D?869|1\\D?868|
  1\\D?849|1\\D?829|1\\D?809|1\\D?787|1\\D?784|1\\D?767|1\\D?758|1\\D?721|
  1\\D?684|1\\D?671|1\\D?670|1\\D?664|1\\D?649|1\\D?473|1\\D?441|1\\D?345|
  1\\D?340|1\\D?284|1\\D?268|1\\D?264|1\\D?246|1\\D?242|1)\\D?""");

final RegExp _fullPhoneNumber = RegExp(
  r"^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4}$",
);

const String initialCountryCode = "IQ";

final PhoneNumber iraqiPhoneNumber = PhoneNumber(
  countryISOCode: "IQ",
  countryCode: "+964",
  number: "7707868927",
);

const String iraqiPhoneNumberStarter = "07";

extension PhoneNumberExtension on PhoneNumber {
  PhoneNumber copyWith({
    String? countryISOCode,
    String? countryCode,
    String? number,
  }) {
    return PhoneNumber(
      countryISOCode: countryISOCode ?? this.countryISOCode,
      countryCode: countryCode ?? this.countryCode,
      number: number ?? this.number,
    );
  }
}

PhoneNumber? phoneNumberFromString(String phoneNumber) {
  try {
    if (_fullPhoneNumber.hasMatch(phoneNumber)) return null;

    String phoneNumberPart = phoneNumber.replaceAll(_countryCodesRegex, "");
    String countryCodePart = phoneNumber.split(phoneNumberPart).first;

    if (countryCodePart.isEmpty || phoneNumber.isEmpty) return null;

    return PhoneNumber(
      countryCode: countryCodePart,
      number: phoneNumberPart,
      countryISOCode: '',
    );
  } catch (e) {
    return null;
  }
}
