package Controller_Encode;

import Controller_Base.BaseServlet;
import DAO.ConsumptionReportDAO;
import DAO.DeliveryInvoiceDAO;
import DAO.ProductDAO;
import Model.ConsumptionReport;
import Model.ConsumptionReportDetails;
import Model.DeliveryInvoice;
import Model.DeliveryInvoiceDetails;
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
public class EncodeDeliveryInvoiceServlet extends BaseServlet {

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    public void servletAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
       
        boolean x = false;
        DeliveryInvoiceDAO DeliveryInvoiceDAO = new DeliveryInvoiceDAO();
        DeliveryInvoice DeliveryInvoice = new DeliveryInvoice();
        String locationID = request.getParameter("location");
        String madeBy = request.getParameter("madeBy");
        String deliveryDate = request.getParameter("deliveryDate");
        
        String[] itemCode = request.getParameterValues("itemCode");
        String[] qty = request.getParameterValues("qty");
        

        Integer dirNUmber = 0;
        try {
            dirNUmber = DeliveryInvoiceDAO.getDirNumber();
        } catch (SQLException ex) {
            Logger.getLogger(EncodeReplenishmentRequestServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        //header
        DeliveryInvoice.setDiNumber(dirNUmber);
        DeliveryInvoice.setLocation(Integer.parseInt(locationID));
        DeliveryInvoice.setMadeBy(Integer.parseInt(madeBy));
        try {
            DeliveryInvoice.setDateMade();
             DeliveryInvoice.setDeliveryDate(deliveryDate);
        } catch (ParseException ex) {
            Logger.getLogger(EncodeDeliveryInvoiceServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        if(DeliveryInvoiceDAO.EncodeDeliveryInvoice(DeliveryInvoice)){
            x = true;
        }else{
                x = false;
                        }
        
        //detail
        if(x){
        for(int i=0; i< itemCode.length; i++){
            DeliveryInvoiceDetails DeliveryInvoiceDetails = new DeliveryInvoiceDetails();
            DeliveryInvoiceDetails.setDiNumber(dirNUmber);
            DeliveryInvoiceDetails.setItemCode(Integer.parseInt(itemCode[i]));
            DeliveryInvoiceDetails.setQty(Double.parseDouble(qty[i]));
            
            if(DeliveryInvoiceDAO.EncodeDeliveryInvoiceDetails(DeliveryInvoiceDetails)){
            
                x= true;
            
            }else{
                x = false;
                        }
        }
        }

        if (x) {
            ServletContext context = getServletContext();
            RequestDispatcher rd = context.getRequestDispatcher("/index.jsp");
            request.setAttribute("", "");
            rd.forward(request, response);
        } else {
            ServletContext context = getServletContext();
            RequestDispatcher rd = context.getRequestDispatcher("/Accounts/Homepage.jsp");
            rd.forward(request, response);
        }

    }

}
