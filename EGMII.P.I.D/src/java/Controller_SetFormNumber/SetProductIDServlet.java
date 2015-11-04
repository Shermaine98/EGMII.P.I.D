package Controller_SetFormNumber;

import Controller_Base.BaseServlet;
import DAO.ProductDAO;
import DAO.RefColorDAO;
import Model.RefColor;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Atayan
 * @author Lapidario
 * @author Sy
 * @author Nunez
 *
 */


public class SetProductIDServlet extends BaseServlet {
/**
 * This Servlet returns the ProductNumber and Color
 * @param request
 * @param response
 * @throws ServletException
 * @throws IOException 
 */
    @Override
    public void servletAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

       ArrayList<RefColor> refColorList = new ArrayList<RefColor>();
       RefColorDAO refColorDAO = new RefColorDAO();
        try {
            refColorList = refColorDAO.GetAllColor();
        } catch (ParseException ex) {
            Logger.getLogger(SetProductIDServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        ServletContext context = getServletContext();
        RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/ProductCreation/Product.jsp");
        request.setAttribute("ColorList", refColorList);
        rd.forward(request, response);

    }
}
