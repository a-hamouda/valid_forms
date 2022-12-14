import '../constant/phone_number_area.g.dart';
import 'core/validation_predicate.dart';

/// International mobile number validation predicate.
/// Depends on code generated by tool/libphonenumber_generator.
///
/// {@template input_guide}
/// Expected input should be in the form: +<country code><phone number>.
/// Input should only contain plus sign [+] followed by country code and then
/// the number.
///
///   Examples: +12015550123 & +201001234567.
/// {@endtemplate}
abstract class MobileNumberValidationPredicate extends ValidationPredicate {
  const MobileNumberValidationPredicate({
    required this.mobileNumber,
  });

  final String mobileNumber;
}

/// International mobile number validation predicate for some allowed areas.
///
/// Validating a valid number for an area that's not allowed will be
/// reported as invalid.
///
/// {@macro input_guide}
class SomeMobileNumberValidationPredicate
    extends MobileNumberValidationPredicate {
  const SomeMobileNumberValidationPredicate({
    required super.mobileNumber,
    required List<PhoneNumberArea> allowedAreas,
  }) : _allowedAreas = allowedAreas;

  final List<PhoneNumberArea> _allowedAreas;

  @override
  bool call() => _allowedAreas
      .map((e) => e.mobilePattern)
      .where((p) => p != null)
      .any((p) => p!.hasMatch(mobileNumber));
}

/// International mobile number validation predicate for all areas.
///
/// {@macro input_guide}
class AllMobileNumberValidationPredicate
    extends MobileNumberValidationPredicate {
  const AllMobileNumberValidationPredicate({
    required super.mobileNumber,
    List<PhoneNumberArea> forbiddenAreas = const [],
  }) : _forbiddenAreas = forbiddenAreas;

  final List<PhoneNumberArea> _forbiddenAreas;

  @override
  bool call() => PhoneNumberArea.values
      .where((e) => !_forbiddenAreas.contains(e))
      .map((e) => e.mobilePattern)
      .where((p) => p != null)
      .any((p) => p!.hasMatch(mobileNumber));
}
