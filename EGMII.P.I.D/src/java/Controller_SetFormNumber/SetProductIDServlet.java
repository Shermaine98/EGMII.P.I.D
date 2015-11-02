package Controller_SetFormNumber;

import Controller_Base.BaseServlet;
import DAO.ProductDAO;
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
public class SetProductIDServlet extends BaseServlet {

    @Override
    public void servletAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

       ProductDAO DAO = new ProductDAO();
        Integer productnumber=0;
        try {
            productnumber = DAO.getProductNumber();
        } catch (SQLException ex) {
            Logger.getLogger(SetProductIDServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        ServletContext context = getServletContext();
        RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/ProductCreation/Product.jsp");
        request.setAttribute("ProductNumber", productnumber);
        rd.forward(request, response);

    }
}
