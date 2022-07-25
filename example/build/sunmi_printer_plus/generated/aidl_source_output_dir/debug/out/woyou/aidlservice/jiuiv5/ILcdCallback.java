/*
 * This file is auto-generated.  DO NOT MODIFY.
 */
package woyou.aidlservice.jiuiv5;
/**
 * 顾显反馈结果
 */
public interface ILcdCallback extends android.os.IInterface
{
  /** Default implementation for ILcdCallback. */
  public static class Default implements woyou.aidlservice.jiuiv5.ILcdCallback
  {
    /**
    	* 返回执行结果
    	* @param show:		  true 显示成功  false 显示失败
    	*/
    @Override public void onRunResult(boolean show) throws android.os.RemoteException
    {
    }
    @Override
    public android.os.IBinder asBinder() {
      return null;
    }
  }
  /** Local-side IPC implementation stub class. */
  public static abstract class Stub extends android.os.Binder implements woyou.aidlservice.jiuiv5.ILcdCallback
  {
    private static final java.lang.String DESCRIPTOR = "woyou.aidlservice.jiuiv5.ILcdCallback";
    /** Construct the stub at attach it to the interface. */
    public Stub()
    {
      this.attachInterface(this, DESCRIPTOR);
    }
    /**
     * Cast an IBinder object into an woyou.aidlservice.jiuiv5.ILcdCallback interface,
     * generating a proxy if needed.
     */
    public static woyou.aidlservice.jiuiv5.ILcdCallback asInterface(android.os.IBinder obj)
    {
      if ((obj==null)) {
        return null;
      }
      android.os.IInterface iin = obj.queryLocalInterface(DESCRIPTOR);
      if (((iin!=null)&&(iin instanceof woyou.aidlservice.jiuiv5.ILcdCallback))) {
        return ((woyou.aidlservice.jiuiv5.ILcdCallback)iin);
      }
      return new woyou.aidlservice.jiuiv5.ILcdCallback.Stub.Proxy(obj);
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
        default:
        {
          return super.onTransact(code, data, reply, flags);
        }
      }
    }
    private static class Proxy implements woyou.aidlservice.jiuiv5.ILcdCallback
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
      /**
      	* 返回执行结果
      	* @param show:		  true 显示成功  false 显示失败
      	*/
      @Override public void onRunResult(boolean show) throws android.os.RemoteException
      {
        android.os.Parcel _data = android.os.Parcel.obtain();
        try {
          _data.writeInterfaceToken(DESCRIPTOR);
          _data.writeInt(((show)?(1):(0)));
          boolean _status = mRemote.transact(Stub.TRANSACTION_onRunResult, _data, null, android.os.IBinder.FLAG_ONEWAY);
          if (!_status && getDefaultImpl() != null) {
            getDefaultImpl().onRunResult(show);
            return;
          }
        }
        finally {
          _data.recycle();
        }
      }
      public static woyou.aidlservice.jiuiv5.ILcdCallback sDefaultImpl;
    }
    static final int TRANSACTION_onRunResult = (android.os.IBinder.FIRST_CALL_TRANSACTION + 0);
    public static boolean setDefaultImpl(woyou.aidlservice.jiuiv5.ILcdCallback impl) {
      // Only one user of this interface can use this function
      // at a time. This is a heuristic to detect if two different
      // users in the same process use this function.
      if (Stub.Proxy.sDefaultImpl != null) {
        throw new IllegalStateException("setDefaultImpl() called twice");
      }
      if (impl != null) {
        Stub.Proxy.sDefaultImpl = impl;
        return true;
      }
      return false;
    }
    public static woyou.aidlservice.jiuiv5.ILcdCallback getDefaultImpl() {
      return Stub.Proxy.sDefaultImpl;
    }
  }
  /**
  	* 返回执行结果
  	* @param show:		  true 显示成功  false 显示失败
  	*/
  public void onRunResult(boolean show) throws android.os.RemoteException;
}
