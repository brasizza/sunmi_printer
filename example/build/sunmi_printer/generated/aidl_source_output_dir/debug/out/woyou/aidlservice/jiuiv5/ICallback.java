/*
 * This file is auto-generated.  DO NOT MODIFY.
 */
package woyou.aidlservice.jiuiv5;
public interface ICallback extends android.os.IInterface
{
  /** Default implementation for ICallback. */
  public static class Default implements woyou.aidlservice.jiuiv5.ICallback
  {
    @Override public void onRunResult(boolean isSuccess) throws android.os.RemoteException
    {
    }
    @Override public void onReturnString(java.lang.String result) throws android.os.RemoteException
    {
    }
    @Override public void onRaiseException(int code, java.lang.String msg) throws android.os.RemoteException
    {
    }
    @Override public void onPrintResult(int code, java.lang.String msg) throws android.os.RemoteException
    {
    }
    @Override
    public android.os.IBinder asBinder() {
      return null;
    }
  }
  /** Local-side IPC implementation stub class. */
  public static abstract class Stub extends android.os.Binder implements woyou.aidlservice.jiuiv5.ICallback
  {
    private static final java.lang.String DESCRIPTOR = "woyou.aidlservice.jiuiv5.ICallback";
    /** Construct the stub at attach it to the interface. */
    public Stub()
    {
      this.attachInterface(this, DESCRIPTOR);
    }
    /**
     * Cast an IBinder object into an woyou.aidlservice.jiuiv5.ICallback interface,
     * generating a proxy if needed.
     */
    public static woyou.aidlservice.jiuiv5.ICallback asInterface(android.os.IBinder obj)
    {
      if ((obj==null)) {
        return null;
      }
      android.os.IInterface iin = obj.queryLocalInterface(DESCRIPTOR);
      if (((iin!=null)&&(iin instanceof woyou.aidlservice.jiuiv5.ICallback))) {
        return ((woyou.aidlservice.jiuiv5.ICallback)iin);
      }
      return new woyou.aidlservice.jiuiv5.ICallback.Stub.Proxy(obj);
    }
    @Override public android.os.IBinder asBinder()
    {
      return this;
    }
    @Override public boolean onTransact(int code, android.os.Parcel data, android.os.Parcel reply, int flags) throws android.os.RemoteException
    {
      java.lang.String descriptor = DESCRIPTOR;
      switch (code)
      {
        case INTERFACE_TRANSACTION:
        {
          reply.writeString(descriptor);
          return true;
        }
        case TRANSACTION_onRunResult:
        {
          data.enforceInterface(descriptor);
          boolean _arg0;
          _arg0 = (0!=data.readInt());
          this.onRunResult(_arg0);
          return true;
        }
        case TRANSACTION_onReturnString:
        {
          data.enforceInterface(descriptor);
          java.lang.String _arg0;
          _arg0 = data.readString();
          this.onReturnString(_arg0);
          return true;
        }
        case TRANSACTION_onRaiseException:
        {
          data.enforceInterface(descriptor);
          int _arg0;
          _arg0 = data.readInt();
          java.lang.String _arg1;
          _arg1 = data.readString();
          this.onRaiseException(_arg0, _arg1);
          return true;
        }
        case TRANSACTION_onPrintResult:
        {
          data.enforceInterface(descriptor);
          int _arg0;
          _arg0 = data.readInt();
          java.lang.String _arg1;
          _arg1 = data.readString();
          this.onPrintResult(_arg0, _arg1);
          return true;
        }
        default:
        {
          return super.onTransact(code, data, reply, flags);
        }
      }
    }
    private static class Proxy implements woyou.aidlservice.jiuiv5.ICallback
    {
      private android.os.IBinder mRemote;
      Proxy(android.os.IBinder remote)
      {
        mRemote = remote;
      }
      @Override public android.os.IBinder asBinder()
      {
        return mRemote;
      }
      public java.lang.String getInterfaceDescriptor()
      {
        return DESCRIPTOR;
      }
      @Override public void onRunResult(boolean isSuccess) throws android.os.RemoteException
      {
        android.os.Parcel _data = android.os.Parcel.obtain();
        try {
          _data.writeInterfaceToken(DESCRIPTOR);
          _data.writeInt(((isSuccess)?(1):(0)));
          boolean _status = mRemote.transact(Stub.TRANSACTION_onRunResult, _data, null, android.os.IBinder.FLAG_ONEWAY);
          if (!_status && getDefaultImpl() != null) {
            getDefaultImpl().onRunResult(isSuccess);
            return;
          }
        }
        finally {
          _data.recycle();
        }
      }
      @Override public void onReturnString(java.lang.String result) throws android.os.RemoteException
      {
        android.os.Parcel _data = android.os.Parcel.obtain();
        try {
          _data.writeInterfaceToken(DESCRIPTOR);
          _data.writeString(result);
          boolean _status = mRemote.transact(Stub.TRANSACTION_onReturnString, _data, null, android.os.IBinder.FLAG_ONEWAY);
          if (!_status && getDefaultImpl() != null) {
            getDefaultImpl().onReturnString(result);
            return;
          }
        }
        finally {
          _data.recycle();
        }
      }
      @Override public void onRaiseException(int code, java.lang.String msg) throws android.os.RemoteException
      {
        android.os.Parcel _data = android.os.Parcel.obtain();
        try {
          _data.writeInterfaceToken(DESCRIPTOR);
          _data.writeInt(code);
          _data.writeString(msg);
          boolean _status = mRemote.transact(Stub.TRANSACTION_onRaiseException, _data, null, android.os.IBinder.FLAG_ONEWAY);
          if (!_status && getDefaultImpl() != null) {
            getDefaultImpl().onRaiseException(code, msg);
            return;
          }
        }
        finally {
          _data.recycle();
        }
      }
      @Override public void onPrintResult(int code, java.lang.String msg) throws android.os.RemoteException
      {
        android.os.Parcel _data = android.os.Parcel.obtain();
        try {
          _data.writeInterfaceToken(DESCRIPTOR);
          _data.writeInt(code);
          _data.writeString(msg);
          boolean _status = mRemote.transact(Stub.TRANSACTION_onPrintResult, _data, null, android.os.IBinder.FLAG_ONEWAY);
          if (!_status && getDefaultImpl() != null) {
            getDefaultImpl().onPrintResult(code, msg);
            return;
          }
        }
        finally {
          _data.recycle();
        }
      }
      public static woyou.aidlservice.jiuiv5.ICallback sDefaultImpl;
    }
    static final int TRANSACTION_onRunResult = (android.os.IBinder.FIRST_CALL_TRANSACTION + 0);
    static final int TRANSACTION_onReturnString = (android.os.IBinder.FIRST_CALL_TRANSACTION + 1);
    static final int TRANSACTION_onRaiseException = (android.os.IBinder.FIRST_CALL_TRANSACTION + 2);
    static final int TRANSACTION_onPrintResult = (android.os.IBinder.FIRST_CALL_TRANSACTION + 3);
    public static boolean setDefaultImpl(woyou.aidlservice.jiuiv5.ICallback impl) {
      if (Stub.Proxy.sDefaultImpl == null && impl != null) {
        Stub.Proxy.sDefaultImpl = impl;
        return true;
      }
      return false;
    }
    public static woyou.aidlservice.jiuiv5.ICallback getDefaultImpl() {
      return Stub.Proxy.sDefaultImpl;
    }
  }
  public void onRunResult(boolean isSuccess) throws android.os.RemoteException;
  public void onReturnString(java.lang.String result) throws android.os.RemoteException;
  public void onRaiseException(int code, java.lang.String msg) throws android.os.RemoteException;
  public void onPrintResult(int code, java.lang.String msg) throws android.os.RemoteException;
}
