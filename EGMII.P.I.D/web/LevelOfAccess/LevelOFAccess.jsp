<%@page import="Model.User"%>
<%
    
        User user = (User) session.getAttribute("login");
        String position = user.getPosition().toLowerCase().trim();
        if(session.getAttribute("login")==null){
             response.sendRedirect("index.jsp");
        } else if (position.equalsIgnoreCase("promoter")) {
%>         <jsp:include page ="/NavBar/nPromoNavBar.jsp" />
<%
} else if (position.equalsIgnoreCase("receipt handler")) {
%>          <jsp:include page ="/NavBar/nReceiptHandlerNavBar.jsp" />
<%          } else if (position.equalsIgnoreCase("delivery manager")) {

%>          <jsp:include page ="/NavBar/nDeliveryManagerNavBar.jsp" />
<%} else if (position.equalsIgnoreCase("general manager")) {
%>          <jsp:include page ="/NavBar/nGeneralManagerNavBar.jsp" />
<%          } else if (position.equalsIgnoreCase("production manager")) {
%>          <jsp:include page ="/NavBar/nProductionManagerNavBar.jsp" />
<%          } else if (position.equalsIgnoreCase("assistant production manager")) {
%>          <jsp:include page ="/NavBar/nAssistantProductionManagerNavBar.jsp" />
<%          } else if (position.equalsIgnoreCase("cutting master")) {
%>          <jsp:include page="/NavBar/nCuttingMasterNavBar.jsp"/>
<%          } else if (position.equalsIgnoreCase("promoter supervisor")) {
%>          <jsp:include page="/NavBar/nPromoSupervisorNavBar.jsp"/>
<%          } else if (position.equalsIgnoreCase("warehouse manager")) {
%>          <jsp:include page="/NavBar/nWarehouseManagerNavBar.jsp"/>
<%          } else if (position.equalsIgnoreCase("administrator")) {
%>          <jsp:include page="/NavBar/nadministratorNavBar.jsp"/>
<%          } else if (position.equalsIgnoreCase("delivery man") || position.equalsIgnoreCase("employee")) {
%>          <jsp:include page="/NavBar/nemployeeNavBar.jsp"/>
<%          } else {
            response.sendRedirect("index.jsp");
        }
    

%> 
