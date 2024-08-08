import 'package:get/get.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import '../../../core/config/app_odoo_models.dart';
import '../../../core/config/app_shared_pr.dart';
import '../../../core/utils/general_local_db.dart';
import '../../../core/utils/general_odoo_fun.dart';
import '../data/user.dart';
import '../utils/handle_exception_helper.dart';
import '../utils/odoo_connection_helper.dart';
import 'authentication_repository.dart';

class AuthenticationService implements AuthenticationRepository {
  GeneralOdooFun? _GeneralOdooFunInstance;

  static AuthenticationService? _authenticationServiceInstance;

  AuthenticationService._();

  static AuthenticationService getInstance() {
    _authenticationServiceInstance =
        _authenticationServiceInstance ?? AuthenticationService._();
    return _authenticationServiceInstance!;
  }
  // ========================================== [ AUTHENTICATE ] =============================================

  @override
  Future authenticate(
      {required String username, required String password}) async {
    try {
      OdooProjectOwnerConnectionHelper.odooSession = null;
      await OdooProjectOwnerConnectionHelper.instantiateOdooConnection(
          username: username, password: password);

      List result = await OdooProjectOwnerConnectionHelper.odooClient.callKw({
        'model': OdooModels.resUsers,
        'method': 'search_read',
        'args': [],
        'kwargs': {
          //'context': {'bin_size': true}, // for user image
          'domain': [
            ['id', '=', OdooProjectOwnerConnectionHelper.odooSession!.userId]
          ],
          'fields': [
            'id',
            'name',
            'login',
            'image_1920',
            'pin_code',
            'pin_code_lock',
            'account_lock',
            'pos_config_ids'
          ],
        },
      });
      // _GeneralOdooFunInstance = GeneralOdooFun.getInstance<Customer>(
      //     fromJsonFun: Customer.fromJson, modelName: OdooModels.customer);
      // int affectedRows = await _GeneralOdooFunInstance!.show(id: 0);
      // print("object=========ddd=====================");
      // print(affectedRows);
      // print("object==========ddd====================");
      // print(result.first);
      return User.fromJson(result.first);
    } on OdooSessionExpiredException {
      // OdooProjectOwnerConnectionHelper.sessionClosed = true;
      // if (kDebugMode) {
      //   print("session_expired");
      // }
      return 'session_expired'.tr;
    } on OdooException catch (e) {
    } catch (e) {
      // return "exception".tr;
      return e.toString().replaceFirst('Exception: ', '');
    }
  }
  // ========================================== [ AUTHENTICATE ] =============================================

// ========================================== [ DROP USER TABLE ] =============================================

  @override
  Future deleteData() async {
    var generalLocalDBInstance =
        GeneralLocalDB.getInstance<User>(fromJsonFun: User.fromJson);
    return await generalLocalDBInstance!.deleteData();
  }

  @override
  Future dropTable() async {
    var generalLocalDBInstance =
        GeneralLocalDB.getInstance<User>(fromJsonFun: User.fromJson);
    return await generalLocalDBInstance!.dropTable();
  }

// ========================================== [ DROP USER TABLE ] =============================================
}
