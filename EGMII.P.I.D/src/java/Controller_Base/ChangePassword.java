package Controller_Base;

import DAO.UserDAO;
import Model.User;
import java.io.IOException;
import java.text.ParseException;
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
public class ChangePassword extends BaseServlet {

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    public void servletAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String username = request.getParameter("email");
        String currentP = request.getParameter("current");
        String newP = request.getParameter("changepass");

        UserDAO dao = new UserDAO();
        User user = new User();
        try {
            user = dao.getUser(username, currentP);
        } catch (ParseException ex) {
            Logger.getLogger(ChangePassword.class.getName()).log(Level.SEVERE, null, ex);
        }

        if (dao.authenticate(user)) {
            if (dao.changePassword(user, newP)) {
                ServletContext context = getServletContext();
                RequestDispatcher rd = context.getRequestDispatcher("/Accounts/ViewAccount.jsp");
                rd.forward(request, response);
            } else {
                ServletContext context = getServletContext();
                RequestDispatcher rd = context.getRequestDispatcher("/Accounts/Homepage.jsp");
                rd.forward(request, response);
            }
        }
    }

}
