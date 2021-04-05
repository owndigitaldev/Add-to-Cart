import 'package:add_to_cart/common/configs.dart';
import 'package:permission_handler/permission_handler.dart';

export 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Future reqAllPermissions() async {
    return await Future.forEach(
      kPermissions,
      (Permission element) async {
        return await element.request();
      },
    );
  }

  Future reqPermissions(Permission permission) async {
    return permission.request();
  }

  Future checkPermission(Permission permission) async {
    return permission.status;
  }
}
