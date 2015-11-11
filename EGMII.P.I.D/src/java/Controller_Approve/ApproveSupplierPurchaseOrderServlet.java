/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller_Approve;

import Controller_Base.BaseServlet;
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
public class ApproveSupplierPurchaseOrderServlet extends BaseServlet {

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    public void servletAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SupplierPurchaseOrderDAO PurchaseOrderDAO = new SupplierPurchaseOrderDAO();
        ArrayList<SupplierPurchaseOrderView> PurchaseOrderList = new ArrayList<>();

        PurchaseOrderList = PurchaseOrderDAO.GetAllSupplierPurchaseOrderForApproval();
        ServletContext context = getServletContext();
        RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/Procurement/SupplierApproval.jsp");
        request.setAttribute("data", "null");
        request.setAttribute("SupplierPurchaseOrderList", PurchaseOrderList);
        rd.forward(request, response);
    }
}
