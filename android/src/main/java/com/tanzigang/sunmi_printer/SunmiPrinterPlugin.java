package com.tanzigang.sunmi_printer;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;

import androidx.annotation.NonNull;

import java.util.HashMap;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import woyou.aidlservice.jiuiv5.ICallback;

/** SunmiPrinterPlugin */
public class SunmiPrinterPlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private static SunmiPrinterMethod sunmiPrinterMethod;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    final MethodChannel channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "sunmi_printer");
    sunmiPrinterMethod = new SunmiPrinterMethod(flutterPluginBinding.getApplicationContext());
    channel.setMethodCallHandler(this);
  }


  // This static function is optional and equivalent to onAttachedToEngine. It
  // supports the old pre-Flutter-1.12 Android projects. You are encouraged to
  // continue supporting plugin registration via this function while apps migrate
  // to use the new Android APIs post-flutter-1.12 via
  // https://flutter.dev/go/android-project-migration.
  //
  // It is encouraged to share logic between onAttachedToEngine and registerWith
  // to keep them functionally equivalent. Only one of onAttachedToEngine or
  // registerWith will be called depending on the user's project.
  // onAttachedToEngine or registerWith must both be defined in the same class.
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "sunmi_printer");
    sunmiPrinterMethod = new SunmiPrinterMethod(registrar.context());
    channel.setMethodCallHandler(new SunmiPrinterPlugin());
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    switch (call.method) {

      case "BIND_PRINTER_SERVICE":
        sunmiPrinterMethod.bindPrinterService();
        result.success(true);

        break;

      case "UNBIND_PRINTER_SERVICE":
        sunmiPrinterMethod.unbindPrinterService();
        result.success(true);

        break;

      case "INIT_PRINTER":
        // ICallback callback = call.argument("callback");
        sunmiPrinterMethod.initPrinter();
        result.success(true);
        break;

      case "GET_UPDATE_PRINTER":

        final int status_code = sunmiPrinterMethod.updatePrinter();

        String status_msg = "";

        // response printer status
        switch (status_code) {
          case 0:
            status_msg = "ERROR";
            break;
          case 1:
            status_msg = "NORMAL";
            break;
          case 2:
            status_msg = "ABNORMAL_COMMUNICATION";
            break;
          case 3:
            status_msg = "OUT_OF_PAPER";
            break;
          case 4:
            status_msg = "PREPARING";
            break;
          case 5:
            status_msg = "OVERHEATED";
            break;
          case 6:
            status_msg = "OPEN_THE_LID";
            break;
          case 7:
            status_msg = "PAPER_CUTTER_ABNORMAL";
            break;
          case 8:
            status_msg = "PAPER_CUTTER_RECOVERED";
            break;
          case 9:
            status_msg = "NO_BLACK_MARK";
            break;
          case 505:
            status_msg = "NO_PRINTER_DETECTED";
            break;
          case 507:
            status_msg = "FAILED_TO_UPGRADE_FIRMWARE";
            break;
          default:
            status_msg = "EXCEPTION";
        }

        result.success(status_msg);
        break;

      case "PRINT_TEXT":
        String text = call.argument("text");

        sunmiPrinterMethod.printText(text);
        result.success(true);

        break;

      case "RAW_DATA":
        sunmiPrinterMethod.sendRaw((byte[]) call.argument("data"));
        result.success(true);
        break;


        case "LINE_WRAP":
        int lines = call.argument("lines");
        sunmiPrinterMethod.lineWrap(lines);
        result.success(true);
        break;
      
      
      case "SET_ALIGNMENT":
        int alignment = call.argument("alignment");
        sunmiPrinterMethod.setAlignment(alignment);
        result.success(true);
        break;

      case "PRINT_IMAGE":
        byte[] bytes = call.argument("bitmap");
        Bitmap bitmap = BitmapFactory.decodeByteArray( bytes, 0, bytes.length );
        sunmiPrinterMethod.printImage(bitmap);
        result.success(true);

        break;

      case "GET_PRINTER_MODE":

        final int mode_code = sunmiPrinterMethod.getPrinterMode();

        String mode_desc = "";

        // response printer status
        switch (mode_code) {
          case 0:
            mode_desc = "NORMAL_MODE";
            break;
          case 1:
            mode_desc = "BLACK_LABEL_MODE";
            break;
          case 2:
            mode_desc = "LABEL_MODE";
            break;
          case 3:
            mode_desc = "ERROR";
            break;
          default:
            mode_desc = "EXCEPTION";
        }

        result.success(mode_desc);
        break;

      case "LABEL_LOCATE":
        sunmiPrinterMethod.labelLocate();
        result.success(true);
        break;

      case "LABEL_OUTPUT":
        sunmiPrinterMethod.labelOutput();
        result.success(true);
        break;

      case "ENTER_PRINTER_BUFFER":
        Boolean clearEnter = call.argument("clearEnter");
        sunmiPrinterMethod.enterPrinterBuffer(clearEnter);
        result.success(true);

        break;

      case "COMMIT_PRINTER_BUFFER":
        sunmiPrinterMethod.commitPrinterBuffer();
        result.success(true);
        break;

      case "EXIT_PRINTER_BUFFER":
        Boolean clearExit = call.argument("clearExit");
        sunmiPrinterMethod.exitPrinterBuffer(clearExit);
        result.success(true);

        break;

      default:
        result.notImplemented();
        break;
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
  }

}
