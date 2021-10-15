import 'package:seaoil_technical_exam/models/station_response/enum_values.dart';

enum Area { SOUTH_LUZON, NCR, VISAYAS, CALABARZON, MINDANAO, NORTH_LUZON, METRO_MANILA, CENTRAL_LUZON, LUZON }

final areaValues = EnumValues({
  "CALABARZON": Area.CALABARZON,
  "CENTRAL LUZON": Area.CENTRAL_LUZON,
  "LUZON": Area.LUZON,
  "METRO MANILA": Area.METRO_MANILA,
  "MINDANAO": Area.MINDANAO,
  "NCR": Area.NCR,
  "NORTH LUZON": Area.NORTH_LUZON,
  "SOUTH LUZON": Area.SOUTH_LUZON,
  "VISAYAS": Area.VISAYAS
});