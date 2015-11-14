package Controller_Json;

import Controller_Base.BaseServlet;
import Controller_View.ViewConsumptionReportServlet;
import DAO.ConsumptionReportDAO;
import DAO.InventoryDAO;
import DAO.SubconPurchaseOrderDAO;
import Model_View.ConsumptionReportView;
import Model_View.RawMaterialsInventoryView;
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
 * @author Dimaandal
 *
 */
public class SetSubconPOSpecificSerlvet extends BaseServlet {

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    public void servletAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SubconPurchaseOrderDAO SubconPurchaseOrderDAO = new SubconPurchaseOrderDAO();
        ConsumptionReportDAO DAO = new ConsumptionReportDAO();
        InventoryDAO invDAO = new InventoryDAO();
        ArrayList<ConsumptionReportView> ConsumptionReportView = new ArrayList<>();
        int poNumber = 0;
        ConsumptionReportDAO ConsumptionReportDAO = new ConsumptionReportDAO();
        String productionNumber = request.getParameter("hiddenValue");

        try {
            ConsumptionReportView = ConsumptionReportDAO.GetAllConsumptionReportGroupBy();
        } catch (ParseException ex) {
            Logger.getLogger(SetSubconPOSpecificSerlvet.class.getName()).log(Level.SEVERE, null, ex);
        }
        ArrayList<ConsumptionReportView> ConsumptionSpecific = new ArrayList<>();

        try {
            ConsumptionSpecific = ConsumptionReportDAO.GetAllConsumptionReportSpecific(Integer.parseInt(productionNumber));

        } catch (ParseException ex) {
            Logger.getLogger(SetSupplierSpecificReceivingServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        try {
            poNumber = SubconPurchaseOrderDAO.getSubconPurchaseOrderNumber();
        } catch (SQLException ex) {
            Logger.getLogger(SetSubconPOSpecificSerlvet.class.getName()).log(Level.SEVERE, null, ex);
        }

        ServletContext context = getServletContext();
        RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/Procurement/SubconPurchaseOrder.jsp");

        ArrayList<ConsumptionReportView> crListSpecific = new ArrayList();
        ArrayList<ConsumptionReportView> CRforFabric = new ArrayList();
        ArrayList<ConsumptionReportView> CRforSizes = new ArrayList();

        try {
            crListSpecific = DAO.GetAllConsumptionReportSpecific(Integer.parseInt(productionNumber));
            CRforFabric = DAO.GetCRforFabric(Integer.parseInt(productionNumber));
            CRforSizes = DAO.GetCRForSizes(Integer.parseInt(productionNumber));
        } catch (ParseException ex) {
            Logger.getLogger(ViewConsumptionReportServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        ArrayList<RawMaterialsInventoryView> rmwInventory = new ArrayList<RawMaterialsInventoryView>();
        try {
            rmwInventory = invDAO.checkRMInventory(Integer.parseInt(productionNumber));
        } catch (ParseException ex) {
            Logger.getLogger(SetSubconPOSpecificSerlvet.class.getName()).log(Level.SEVERE, null, ex);
        }

        request.setAttribute("rmwInventory", rmwInventory);
        request.setAttribute("crListSpecific", crListSpecific);
        request.setAttribute("CRforFabric", CRforFabric);
        request.setAttribute("CRforSizes", CRforSizes);
        request.setAttribute("poNumber", poNumber);
        request.setAttribute("ConsumptionList", ConsumptionReportView);
        request.setAttribute("subconData", "consumption");
        request.setAttribute("ConsumptionSpecific", ConsumptionSpecific);

        rd.forward(request, response);

    }

}
