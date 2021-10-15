import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:seaoil_technical_exam/provider/user_session.dart';

class ProviderFactory {
  List<SingleChildWidget> createProviders() {
    return [
      ChangeNotifierProvider(create: (context) => UserSession()),
    ];
  }
}