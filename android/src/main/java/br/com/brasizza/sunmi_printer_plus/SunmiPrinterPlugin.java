package br.com.brasizza.sunmi_printer_plus;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.util.Log;
import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import woyou.aidlservice.jiuiv5.ICallback;

/** SunmiPrinterPlugin */
public class SunmiPrinterPlugin implements FlutterPlugin, MethodCallHandler {

  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private static SunmiPrinterMethod sunmiPrinterMethod;

  @Override
  public void onAttachedToEngine(
    @NonNull FlutterPluginBinding flutterPluginBinding
  ) {
    final MethodChannel channel = new MethodChannel(
      flutterPluginBinding.getBinaryMessenger(),
      "sunmi_printer_plus"
    );
    sunmiPrinterMethod =
      new SunmiPrinterMethod(flutterPluginBinding.getApplicationContext());
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
      case "PRINT_QRCODE":
        String data = call.argument("data");
        int modulesize = call.argument("modulesize");
        int errorlevel = call.argument("errorlevel");
        sunmiPrinterMethod.printQRCode(data, modulesize, errorlevel);
        result.success(true);
        break;
      case "PRINT_BARCODE":
        String barCodeData = call.argument("data");
        int barcodeType = call.argument("barcodeType");
        int textPosition = call.argument("textPosition");
        int width = call.argument("width");
        int height = call.argument("height");
        sunmiPrinterMethod.printBarCode(
          barCodeData,
          barcodeType,
          textPosition,
          width,
          height
        );
        sunmiPrinterMethod.lineWrap(1);

        result.success(true);
        break;
      // void printBarCode(String data, int symbology, int height, int width, int textposition,  in ICallback callback);

      case "LINE_WRAP":
        int lines = call.argument("lines");
        sunmiPrinterMethod.lineWrap(lines);
        result.success(true);
        break;
      case "FONT_SIZE":
        int fontSize = call.argument("size");
        sunmiPrinterMethod.setFontSize(fontSize);
        result.success(true);
        break;
      case "SET_ALIGNMENT":
        int alignment = call.argument("alignment");
        sunmiPrinterMethod.setAlignment(alignment);
        result.success(true);
        break;
      case "PRINT_IMAGE":
        byte[] bytes = call.argument("bitmap");
        Bitmap bitmap = BitmapFactory.decodeByteArray(bytes, 0, bytes.length);
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
      // case "LABEL_LOCATE":
      //   sunmiPrinterMethod.labelLocate();
      //   result.success(true);
      //   break;
      // case "LABEL_OUTPUT":
      //   sunmiPrinterMethod.labelOutput();
      //   result.success(true);
      //   break;
      case "ENTER_PRINTER_BUFFER":
        Boolean clearEnter = call.argument("clearEnter");
        sunmiPrinterMethod.enterPrinterBuffer(clearEnter);
        result.success(true);

        break;
      case "COMMIT_PRINTER_BUFFER":
        sunmiPrinterMethod.commitPrinterBuffer();
        result.success(true);
        break;
      case "CUT_PAPER":
        sunmiPrinterMethod.cutPaper();
        result.success(true);
        break;
      case "OPEN_DRAWER":
        sunmiPrinterMethod.openDrawer();
        result.success(true);
        break;

        case "DRAWER_OPENED":
        result.success(sunmiPrinterMethod.timesOpened());
        break;
      
      case "DRAWER_STATUS":
        result.success(sunmiPrinterMethod.drawerStatus());
      break;  
      case "PRINT_ROW":
        String colsStr = call.argument("cols");

        try {
          JSONArray cols = new JSONArray(colsStr);
          String[] colsText = new String[cols.length()];
          int[] colsWidth = new int[cols.length()];
          int[] colsAlign = new int[cols.length()];
          for (int i = 0; i < cols.length(); i++) {
            JSONObject col = cols.getJSONObject(i);
            String textColumn = col.getString("text");
            int widthColumn = col.getInt("width");
            int alignColumn = col.getInt("align");
            colsText[i] = textColumn;
            colsWidth[i] = widthColumn;
            colsAlign[i] = alignColumn;
          }

          sunmiPrinterMethod.printColumn(colsText, colsWidth, colsAlign);
          result.success(true);
        } catch (Exception err) {
          Log.d("SunmiPrinter", err.getMessage());
        }
        break;
      case "EXIT_PRINTER_BUFFER":
        Boolean clearExit = call.argument("clearExit");
        sunmiPrinterMethod.exitPrinterBuffer(clearExit);
        result.success(true);
        break;
      case "PRINTER_SERIAL_NUMBER":
        final String serial = sunmiPrinterMethod.getPrinterSerialNo();
        result.success(serial);
        break;
      case "PRINTER_VERSION":
        final String printer_verison = sunmiPrinterMethod.getPrinterVersion();
        result.success(printer_verison);
        break;
      case "PAPER_SIZE":
        final int paper = sunmiPrinterMethod.getPrinterPaper();
        result.success(paper);
        break;

      // LCD METHODS
      case "LCD_COMMAND":
        int flag = call.argument("flag");
        sunmiPrinterMethod.sendLCDCommand(flag);
        result.success(true);
        break;
      case "LCD_STRING":
        String lcdString = call.argument("string");
        sunmiPrinterMethod.sendLCDString(lcdString);
        result.success(true);
        break;
      case "LCD_BITMAP":
        byte[] lcdBitmapData = call.argument("bitmap");
        Bitmap lcdBitmap = BitmapFactory.decodeByteArray(
                lcdBitmapData, 0, lcdBitmapData.length);
        sunmiPrinterMethod.sendLCDBitmap(lcdBitmap);
        result.success(true);
        break;
      case "LCD_DOUBLE_STRING":
        String topText = call.argument("topText");
        String bottomText = call.argument("bottomText");
        sunmiPrinterMethod.sendLCDDoubleString(topText, bottomText);
        result.success(true);
        break;
      case "LCD_FILL_STRING":
        String lcdFillString = call.argument("string");
        int lcdFillSize = call.argument("size");
        boolean lcdFill = call.argument("fill");
        sunmiPrinterMethod.sendLCDFillString(lcdFillString, lcdFillSize, lcdFill);
        result.success(true);
        break;
      case "LCD_MULTI_STRING":
        ArrayList<String> lcdTextAL = call.argument("text");
        String[] lcdText = Utilities.arrayListToString(lcdTextAL);
        ArrayList<Integer> lcdAlignAL = call.argument("align");
        int[] lcdAlign = Utilities.arrayListToIntList(lcdAlignAL);
        sunmiPrinterMethod.sendLCDMultiString(lcdText, lcdAlign);
        result.success(true);
        break;

      default:
        result.notImplemented();
        break;
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {}
}
