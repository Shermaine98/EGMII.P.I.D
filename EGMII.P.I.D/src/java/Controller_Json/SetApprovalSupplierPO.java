/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller_Json;

import Controller_Base.BaseServlet;
import DAO.SupplierPurchaseOrderDAO;
import Model.PurchaseOrder;
import Model_View.SupplierPurchaseOrderView;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.logging.Level;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author shermainesy
 */
public class SetApprovalSupplierPO extends BaseServlet {

    @Override
    public void servletAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        ArrayList<SupplierPurchaseOrderView> SupplierPurchaseOrderList = new ArrayList<>();
        SupplierPurchaseOrderDAO SupplierPurchaseOrderDAO = new SupplierPurchaseOrderDAO();

        String poNumber = request.getParameter("hiddenValue");
        SupplierPurchaseOrderList = SupplierPurchaseOrderDAO.getSupplierPurchaseNumber(Integer.parseInt(poNumber));
        ArrayList<SupplierPurchaseOrderView> PurchaseOrderList = new ArrayList<>();

        PurchaseOrderList = SupplierPurchaseOrderDAO.GetAllSupplierPurchaseOrderForApproval();
        ServletContext context = getServletContext();
        RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/Procurement/SupplierApproval.jsp");
        request.setAttribute("SupplierPurchaseOrderList", PurchaseOrderList);
        request.setAttribute("data", "supplier");
        request.setAttribute("SupplierPurchaseOrderSpecific", SupplierPurchaseOrderList);
        rd.forward(request, response);

    }

}
