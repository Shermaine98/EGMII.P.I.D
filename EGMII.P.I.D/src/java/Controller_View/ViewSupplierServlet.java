package Controller_View;

import Controller_Base.BaseServlet;
import java.io.IOException;
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
 * @author Dimaandal
 *
 */
public class ViewSupplierServlet extends BaseServlet {

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    public void servletAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        
        if(action.equalsIgnoreCase("view")){
        
        request.setAttribute("View", "View");
        
        
        }
        
        
        
        ServletContext context = getServletContext();
        RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/Vendor/Suppliers.jsp");
        rd.forward(request, response);

    }
}
