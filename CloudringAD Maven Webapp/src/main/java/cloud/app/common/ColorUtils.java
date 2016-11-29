package cloud.app.common;

import java.awt.Color;

public class ColorUtils {
    //把字符串表达的颜色值转换成java.awt.Color
    public static Color parseToColor(final String c) {
        Color convertedColor = Color.ORANGE;
        try {
            convertedColor = new Color(Integer.parseInt(c, 16));
        } catch(NumberFormatException e) {
            // codes to deal with this exception
        }
        return convertedColor;
    }
    
    public static double[] RGBtoHSV(double r, double g, double b){

        double h, s, v;

        double min, max, delta;

        min = Math.min(Math.min(r, g), b);
        max = Math.max(Math.max(r, g), b);

        // V
        v = max;

         delta = max - min;

        // S
         if( max != 0 )
            s = delta / max;
         else {
            s = 0;
            h = -1;
            return new double[]{h,s,v};
         }

        // H
         if( r == max )
            h = ( g - b ) / delta; // between yellow & magenta
         else if( g == max )
            h = 2 + ( b - r ) / delta; // between cyan & yellow
         else
            h = 4 + ( r - g ) / delta; // between magenta & cyan

         h *= 60;    // degrees

        if( h < 0 )
            h += 360;

        return new double[]{h,s,v};
    }
}
