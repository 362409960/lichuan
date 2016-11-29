package cloud.app.common;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class RandImageServlet
 */
public class RandImageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RandImageServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
	    res.setContentType("image/jpg");
	    try {
	      //int charCount = Integer.parseInt(getServletConfig().getInitParameter("charCount"));
	      //int lineCount = Integer.parseInt(getServletConfig().getInitParameter("lineCount"));

	      int charCount = 4;
	      int lineCount = 0;
	      
	      req.getSession().removeAttribute("rv");
	      String v = RandomGraphic.createInstance(charCount, lineCount).drawAlphaNumber(RandomGraphic.GRAPHIC_JPEG, res.getOutputStream());
          System.out.println("servlet value is :"+v);
	      req.getSession().setAttribute("rv", v);
	      
	    } catch (Exception e) {
	      e.printStackTrace();
	    }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
