package Controller_View;

import Controller_Base.BaseServlet;
import DAO.InventoryRetailDAO;
import Model_View.RetailInventoryView;
import java.io.IOException;
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
 * @author Dimaandal
 *
 */
public class ViewBoutiqueInventoryServlet extends BaseServlet {

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    public void servletAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        InventoryRetailDAO InventoryDAO = new InventoryRetailDAO();
        ArrayList<RetailInventoryView> RBIList = new ArrayList<>();
        try {
            RBIList = InventoryDAO.GetRIforView();
        } catch (ParseException ex) {
            Logger.getLogger(ViewWarehouseInventoryServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        ServletContext context = getServletContext();

        RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/Inventory/BoutiqueInventory.jsp");
        request.setAttribute("RBIList", RBIList);
        rd.forward(request, response);
    }

}
