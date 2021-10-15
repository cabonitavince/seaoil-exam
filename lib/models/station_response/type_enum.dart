import 'package:seaoil_technical_exam/models/station_response/enum_values.dart';

enum Type { COXO, COCO, CODO, COCO_WILCO }

final typeValues = EnumValues({
  "COCO": Type.COCO,
  "COCO (WILCO)": Type.COCO_WILCO,
  "CODO": Type.CODO,
  "COXO": Type.COXO
});