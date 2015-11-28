/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller_Approve;

import Controller_Base.BaseServlet;
import DAO.SubconPurchaseOrderDAO;
import Model_View.SubconPurchaseOrderView;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Geraldine
 */
public class ApproveSubconPurchaseOrderServlet extends BaseServlet {

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    public void servletAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SubconPurchaseOrderDAO PurchaseOrderDAO = new SubconPurchaseOrderDAO();
        ArrayList<SubconPurchaseOrderView> PurchaseOrderList = new ArrayList<>();
        
        PurchaseOrderList = PurchaseOrderDAO.GetAllSubconPurchaseOrderForApproval();
        ServletContext context = getServletContext();
        RequestDispatcher rd = context.getRequestDispatcher("/WEB-INF/Procurement/SubconApproval.jsp");
        request.setAttribute("data", "null");
        request.setAttribute("PurchaseOrderList", PurchaseOrderList);
        rd.forward(request, response);
    }
}
