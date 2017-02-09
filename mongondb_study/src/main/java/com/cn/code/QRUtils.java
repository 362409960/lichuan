package com.cn.code;

import java.awt.Color;

public class QRUtils {

	// logo默认边框颜色
	public static final Color DEFAULT_BORDERCOLOR = Color.WHITE;
	// logo默认边框宽度
	public static final int DEFAULT_BORDER = 2;
	// logo大小默认为照片的1/5
	public static final int DEFAULT_LOGOPART = 5;

	private final int border = DEFAULT_BORDER;
	private final Color borderColor;
	private final int logoPart;

	public QRUtils() {
			this(DEFAULT_BORDERCOLOR, DEFAULT_LOGOPART);
		}

	public QRUtils(Color borderColor, int logoPart) {
			this.borderColor = borderColor;
			this.logoPart = logoPart;
		}

	public Color getBorderColor() {
		return borderColor;
	}

	public int getBorder() {
		return border;
	}

	public int getLogoPart() {
		return logoPart;
	}

}