package com.tanzigang.sunmi_printer;

import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.IBinder;
import android.os.RemoteException;
import android.widget.Toast;

import java.util.ArrayList;

import woyou.aidlservice.jiuiv5.*;

public class SunmiPrinterMethod {

    final private String TAG = SunmiPrinterMethod.class.getSimpleName();
    private ArrayList<Boolean> _printingText = new ArrayList<Boolean>();
    private IWoyouService _woyouService;
    private Context _context;

    public SunmiPrinterMethod(Context context) {
        this._context = context;
    }

    private ServiceConnection connService = new ServiceConnection() {
        @Override
        public void onServiceConnected(ComponentName name, IBinder service) {
            try {
                _woyouService = IWoyouService.Stub.asInterface(service);
                String serviceVersion = _woyouService.getServiceVersion();
                Toast.makeText(_context, "Sunmi Printer Service Connected. Version :" + serviceVersion, Toast.LENGTH_LONG).show();
            } catch (RemoteException e) {
                e.printStackTrace();
            }
        }

        @Override
        public void onServiceDisconnected(ComponentName name) {
            Toast.makeText(_context, "Sunmi Printer Service Disconnected", Toast.LENGTH_LONG).show();
        }
    };

    public void bindPrinterService() {
        Intent intent = new Intent();
        intent.setPackage("woyou.aidlservice.jiuiv5");
        intent.setAction("woyou.aidlservice.jiuiv5.IWoyouService");
        _context.bindService(intent, connService, Context.BIND_AUTO_CREATE);
    }

    public void unbindPrinterService() {
        _context.unbindService(connService);
    }

    public void initPrinter() {
        try {
            _woyouService.printerInit( this._callback() );

        } catch (RemoteException e) {

        }
    }

    public int updatePrinter() {
        try {
            final int status =  _woyouService.updatePrinterState();
            return status;
        } catch (RemoteException e) {
            return 0; // error
        }
    }

    public void printText(String text) {
        this._printingText.add(this._printText(text));
    }

    private Boolean _printText(String text) {
        try {
            _woyouService.printText(text, this._callback());
            return true;
        } catch (RemoteException e) {
            return false;
        }
    }

    public Boolean setAlignment(Integer alignment) {
        try {
            _woyouService.setAlignment(alignment, this._callback());
            return true;
        } catch (RemoteException e) {
            return false;
        }
    }

    public Boolean setFontSize(Double fontSize) {
        double v = fontSize;
        try {
            _woyouService.setFontSize((float) v, this._callback());
            return true;
        } catch (RemoteException e) {
            return false;
        }
    }

    public Boolean setFontBold(Boolean bold) {

        if (bold == null) {
            bold = false;
        }

        byte[] command = new byte[]{0x1B, 0x45, 0x1};

        if (bold == false) {
            command = new byte[]{0x1B, 0x45, 0x0};
        }

        try {
            _woyouService.sendRAWData(command, this._callback());
            return true;
        } catch (RemoteException e) {
            return false;
        }
    }

    public Boolean printColumn(String[] stringColumns, int[] columnWidth, int[] columnAlignment) {
        try {
            _woyouService.printColumnsString(stringColumns, columnWidth, columnAlignment, this._callback());
            return true;
        } catch (RemoteException e) {
            return false;
        }
    }

//
//    public Boolean setFontType(String fontType) {
//        byte[] command = EscPosCommand.setFont(fontType);
//        try {
//            woyouService.sendRAWData(command, _callback());
//            return true;
//        } catch (RemoteException e) {
//            return false;
//        }
//    }
//
//    public Boolean setEmphasized(Boolean emphasized) {
//        byte[] command = EscPosCommand.setEmphasized(emphasized);
//        try {
//            woyouService.sendRAWData(command, _callback());
//            return true;
//        } catch (RemoteException e) {
//            return false;
//        }
//    }
//
    public Boolean printImage(Bitmap bitmap) {

        try {
            _woyouService.printBitmap(bitmap, this._callback());
//            _woyouService.lineWrap(3, null);
            return true;
        } catch (RemoteException e) {
            return false;
        }
    }

    public int getPrinterMode() {
        try {
            final int mode = _woyouService.getPrinterMode();
            return mode;
        } catch (RemoteException e) {
            return 3; // error;
        }
    }

    public void labelLocate() {
        try {
            _woyouService.labelLocate();
        } catch (RemoteException e) {

        }
    }

    public void labelOutput() {
        try {
            _woyouService.labelOutput();
        } catch (RemoteException e) {

        }
    }

    public void lineWrap(int lines) {
        try {
            _woyouService.lineWrap(lines, this._callback());
        } catch (RemoteException e) {

        }
    }

    public void sendRaw(byte[] bytes) {
        try {
            this._woyouService.sendRAWData(bytes, this._callback());
        } catch (RemoteException e) {

        }
    }

    
    public void enterPrinterBuffer(Boolean clear) {
        try {
            this._woyouService.enterPrinterBuffer(clear);
        } catch (RemoteException e) {

        }
    }

    public void commitPrinterBuffer() {
        try {
            this._woyouService.commitPrinterBuffer();
        } catch (RemoteException e) {

        }
    }

    public void exitPrinterBuffer(Boolean clear) {
        try {
            this._woyouService.exitPrinterBuffer(clear);
        } catch (RemoteException e) {

        }
    }

    public void setAlignment(int alignment) {
        try {
            _woyouService.setAlignment(alignment, this._callback());
        } catch (RemoteException e) {

        }
    }

    private ICallback _callback() {
        return new ICallback() {
            @Override
            public void onRunResult(boolean isSuccess) throws RemoteException {
            }

            @Override
            public void onReturnString(String result) throws RemoteException {
            }

            @Override
            public void onRaiseException(int code, String msg) throws RemoteException {

            }

            @Override
            public void onPrintResult(int code, String msg) throws RemoteException {
            }

            @Override
            public IBinder asBinder() {
                return null;
            }
        };
    }
}
