package Controller_SetFormNumber;

import Controller_Base.BaseServlet;
import DAO.SubconPurchaseOrderDAO;
import java.io.IOException;
import java.sql.SQLException;
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
public class SetSubconNumberServlet extends BaseServlet {

    @Override
    public void servletAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      
        SubconPurchaseOrderDAO DAO = new SubconPurchaseOrderDAO();
        Integer subconPurchaseNumber=0;
        try {
            subconPurchaseNumber = DAO.getSubconPurchaseOrderNumber();
            
        } catch (SQLException ex) {
            Logger.getLogger(SetSubconNumberServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
            
        ServletContext context = getServletContext();

        RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/Procurement/SubconPurchaseOrder.jsp");
        request.setAttribute("SubPONumber",subconPurchaseNumber );
    
        rd.forward(request, response);

    }
}
