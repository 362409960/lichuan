package cloud.app.common;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Random;

import javax.imageio.ImageIO;

import org.apache.commons.lang3.RandomStringUtils;


@SuppressWarnings("unused")
public class RandomGraphic {
  private int wordHeight = 8;
  private int wordWidth = 15;

  private int fontSize = 18;

private static final int MAX_CHARCOUNT = 16;
  private final int initypos = 5;

  private int charCount = 4;
  private int lineCount = 0;

  private static final Color[] CHAR_COLOR = { Color.BLUE };

  private Random r = new Random();

  public static String GRAPHIC_JPEG = "JPEG";

  public static String GRAPHIC_PNG = "PNG";

  protected RandomGraphic(int charCount){
    this.charCount = charCount;
  }

  protected RandomGraphic(int charCount, int lineCount){
    this.charCount = charCount;
    this.lineCount = lineCount;
  }

  public static RandomGraphic createInstance(int charCount) throws Exception{
    if ((charCount < 1) || (charCount > 16)) {
      throw new Exception("Invalid parameter charCount,charCount should between in 1 and 16");
    }
    return new RandomGraphic(charCount);
  }

  public static RandomGraphic createInstance(int charCount, int lineCount) throws Exception{
    return new RandomGraphic(charCount, lineCount);
  }

  public String drawNumber(String graphicFormat, OutputStream out) throws IOException{
    String charValue = "";
    charValue = randNumber();
    return draw(charValue, graphicFormat, out);
  }

  public String drawAlpha(String graphicFormat, OutputStream out) throws IOException {
    String charValue = "";
    charValue = randAlpha();
    return draw(charValue, graphicFormat, out);
  }

  public String drawAlphaNumber(String graphicFormat, OutputStream out) throws IOException {
    String charValue = "";
    charValue = randAlphaNumber();
    return draw(charValue, graphicFormat, out);
  }

  protected String draw(String charValue, String graphicFormat, OutputStream out) throws IOException {
    int w = (this.charCount + 2) * this.wordWidth;
    int h = this.wordHeight * 3;

    BufferedImage bi = new BufferedImage(w, h, 5);
    Graphics2D g = bi.createGraphics();

    Color backColor = Color.WHITE;
    g.setBackground(backColor);
    g.fillRect(0, 0, w, h);

    Random random = new Random();
    for (int i = 0; i < this.lineCount; i++) {
      int x = random.nextInt(w);
      int y = random.nextInt(h);
      int xl = random.nextInt(3);
      int yl = random.nextInt(3);
      Color color = CHAR_COLOR[randomInt(0, CHAR_COLOR.length)];
      g.setColor(color);
      g.drawLine(x, y, x + xl, y + yl);
    }

    g.setFont(new Font("Tahoma", 1, this.fontSize));

    for (int i = 0; i < this.charCount; i++) {
      String c = charValue.substring(i, i + 1);
      Color color = CHAR_COLOR[randomInt(0, CHAR_COLOR.length)];
      g.setColor(color);
      int xpos = (i + 1) * this.wordWidth;

      int ypos = randomInt(5 + this.wordHeight, 5 + this.wordHeight * 2);
      g.drawString(c, xpos, ypos);
    }

    g.dispose();
    bi.flush();

    ImageIO.write(bi, graphicFormat, out);

    return charValue;
  }

  protected String randNumber() {
    String charValue = "";

    for (int i = 0; i < this.charCount; i++) {
      charValue = charValue + String.valueOf(randomInt(0, 10));
    }
    return charValue;
  }

  private String randAlpha() {
    String charValue = "";

    for (int i = 0; i < this.charCount; i++) {
      char c = (char)(randomInt(0, 26) + 65);
      charValue = charValue + String.valueOf(c);
    }
    return charValue;
  }

  private String randAlphaNumber()
  {
    return RandomStringUtils.randomAlphanumeric(this.charCount).toUpperCase();
  }

  protected int randomInt(int from, int to)
  {
    return from + this.r.nextInt(to - from);
  }

  public Color getRandColor(int fc, int bc)
  {
    Random random = new Random();
    if (fc > 255) {
      fc = 255;
    }
    if (bc > 255) {
      bc = 255;
    }
    int r = fc + random.nextInt(bc - fc);
    int g = fc + random.nextInt(bc - fc);
    int b = fc + random.nextInt(bc - fc);
    return new Color(r, g, b);
  }

  public static void main(String[] args)
    throws Exception
  {
    System.out.println(createInstance(4).drawAlpha(GRAPHIC_JPEG, new FileOutputStream("c:/myimg.png")));
  }
}