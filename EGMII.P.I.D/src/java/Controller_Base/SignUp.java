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
public class SignUp extends BaseServlet {

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    public void servletAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {

            User newUser = new User();
            UserDAO userDAO = new UserDAO();

            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String birthDate = request.getParameter("birthDate");
            String email = request.getParameter("email");
            String password = request.getParameter("newPassword");
            String verification = request.getParameter("verCode");
            String entryDate = request.getParameter("entryDate");
            String position = request.getParameter("position");

            newUser.setEmployeeNumber(userDAO.getLastEmpNumber() + 1);
            newUser.setFirstName(firstName);
            newUser.setLastName(lastName);

           // if (verification.equals("8213")) {
             //   newUser.setPosition("generalmanager");
            //} else if (verification.equals("2344")) {
              newUser.setPosition("position");
            //}

            newUser.setBirthDate(birthDate);
            newUser.setUserName(email);
            newUser.setPassword(password);

            //ENTRY & LEFT DATE; temporary
             newUser.setEntryDate("entryDate");
             newUser.setLeftDate("9999-99-99");

            if (userDAO.register(newUser)) {

                ServletContext context = getServletContext();
                RequestDispatcher rd = context.getRequestDispatcher("/index.jsp");
                rd.forward(request, response);
            } else {
                ServletContext context = getServletContext();
                RequestDispatcher rd = context.getRequestDispatcher("/sign_up.jsp");
                rd.forward(request, response);

            }
        } catch (ParseException ex) {
            Logger.getLogger(SignUp.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
