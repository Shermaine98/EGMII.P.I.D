<%@page import="Model.User"%>
<%
   User user = (User) session.getAttribute("login");
   String position = user.getPosition().toLowerCase().trim();
    if (position.equalsIgnoreCase("promo")) {
%>         <jsp:include page ="/NavBar/nPromoNavBar.jsp" />
<%
} else if (position.equalsIgnoreCase("receipthandler")) {
%>          <jsp:include page ="/NavBar/nReceiptHandlerNavBar.jsp" />
<%          } else if (position.equalsIgnoreCase("deliverymanager")) {

%>          <jsp:include page ="/NavBar/nDeliveryManagerNavBar.jsp" />
<%} else if (position.equalsIgnoreCase("generalmanager")) {
%>          <jsp:include page ="/NavBar/nGeneralManagerNavBar.jsp" />
<%          } else if (position.equalsIgnoreCase("productionmanager")) {
%>          <jsp:include page ="/NavBar/nProductionManagerNavBar.jsp" />
<%          } else if (position.equalsIgnoreCase("assistantproductionmanager")) {
%>          <jsp:include page ="/NavBar/nAssistantProductionManagerNavBar.jsp" />
<%          } else if (position.equalsIgnoreCase("cuttingmaster")) {
%>          <jsp:include page="/NavBar/nCuttingMasterNavBar.jsp"/>
<%          } else if (position.equalsIgnoreCase("promotersupervisor")) {
%>          <jsp:include page="/NavBar/nPromoterSupervisorNavBar.jsp"/>
<%          } else if (position.equalsIgnoreCase("warehousemanager")) {
%>          <jsp:include page="/NavBar/nWarehouseManagerNavBar.jsp"/>
<%          } else if (position.equalsIgnoreCase("administrator")) {
%>          <jsp:include page="/NavBar/nadministratorNavBar.jsp"/>
<%          } else if (position.equalsIgnoreCase("deliveryman")||position.equalsIgnoreCase("employee")) {
%>          <jsp:include page="/NavBar/nemployeeNavBar.jsp"/>
<%          } else {
        response.sendRedirect("redirect.jsp");
    }

%> 
