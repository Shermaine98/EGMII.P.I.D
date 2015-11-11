/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller_Json;

import Controller_Base.BaseServlet;
import DAO.SupplierDeliveryReceiptDAO;
import DAO.SupplierPurchaseOrderDAO;
import Model.PurchaseOrder;
import Model_View.SupplierPurchaseOrderView;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Geraldine
 */
public class SetSubconPOReceivingServlet extends BaseServlet {

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    public void servletAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SupplierDeliveryReceiptDAO SupplierDeliveryReceiptDAO = new SupplierDeliveryReceiptDAO();
        ArrayList<SupplierPurchaseOrderView> SupplierPurchaseOrderView = new ArrayList<>();

//        try {
//          //  SupplierPurchaseOrderView = SupplierDeliveryReceiptDAO.GetPurchaseOrderForReceiving();
//        } catch (ParseException ex) {
//            Logger.getLogger(SetSupplierReceivingServlet.class.getName()).log(Level.SEVERE, null, ex);
//        }
        ServletContext context = getServletContext();
        RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/Procurement/SubconReceiving.jsp");
        request.setAttribute("receivingData", "null");
        request.setAttribute("","");
        rd.forward(request, response);
    }
}
