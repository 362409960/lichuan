package cloud.app.common;


import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;

import org.apache.mina.core.buffer.IoBuffer;

public class StringIoBufferByteUtils {


    /**  
    * 将byte[]转换成string    
    * @param butBuffer  
    */
    public static String byteToString(byte [] b)   
    {   
           StringBuffer stringBuffer = new StringBuffer();   
           for (int i = 0; i < b.length; i++)   
           {   
               stringBuffer.append((char) b [i]);   
           }   
           return stringBuffer.toString();   
    }   
     
    /**  
     * 将bytebuffer转换成string    
     * @param str  
      * @throws UnsupportedEncodingException 
     */  
    public static IoBuffer stringToIoBuffer(String str) throws Exception{   
        byte bt[] = str.getBytes();   
        
        IoBuffer iobuffer = IoBuffer.allocate(bt.length);
        iobuffer.put(bt, 0, bt.length);   
        iobuffer.flip();   
        return iobuffer; 
   }  
   
    /**  
    * 将IoBuffer转换成string    
    * @param str  
    */  
    public static IoBuffer byteToIoBuffer(byte [] bt,int length)   
    {   
      
           IoBuffer ioBuffer = IoBuffer.allocate(length);   
           ioBuffer.put(bt, 0, length);   
           ioBuffer.flip();   
           return ioBuffer;   
    }   
    /**  
    * 将IoBuffer转换成byte    
    * @param str  
    */  
    public static byte [] ioBufferToByte(Object message)   
    {   
          if (!(message instanceof IoBuffer))   
          {   
              return null;   
          }   
          IoBuffer ioBuffer = (IoBuffer)message;   
          byte[] b = new byte[ioBuffer.limit()];   
          ioBuffer.get(b);   
          return b;   
    }   

    /**  
    * 将IoBuffer转换成string    
    * @param butBuffer  
     * @throws IOException 
    */  
    public static String ioBufferToString(Object message) throws IOException   
    {   
          if (!(message instanceof IoBuffer))   
          {   
            return "";   
          }   
          IoBuffer ioBuffer = (IoBuffer) message;   
          
          InputStream is = ioBuffer.asInputStream();
          ByteArrayOutputStream baos = new ByteArrayOutputStream();
          int i=-1;
          while((i=is.read())!=-1){
              baos.write(i);
          } 

          return baos.toString();
    }  
  
    
    
}
