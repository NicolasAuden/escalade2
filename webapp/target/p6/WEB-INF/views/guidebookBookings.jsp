<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 14/02/2019
  Time: 17:44
  To change this template use File | Settings | File Templates.
--%>

<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://sargue.net/jsptags/time" prefix="javatime" %>

<html>

<head>
    <meta charset="UTF-8"/>
    <title>High</title>
    <link href="${pageContext.request.contextPath}/webjars/bootstrap/4.2.1/css/bootstrap.min.css"
          rel="stylesheet"/>
</head>

<body>

<style type="text/css">
    body {
        padding-top: 70px;
    }

    h1 {
        padding-top: 50px;
    }
</style>


<div class="container">
    <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top ">
        <a class="navbar-brand" href="${pageContext.request.contextPath}">HOME</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavAltMarkup"
                aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
            <ul class="navbar-nav mr-auto">

                <li class="nav-item">
                    <a class="nav-item nav-link"
                       href="${pageContext.request.contextPath}/#lesSpots">Les spots</a>
                </li>
                <li class="nav-item">
                    <a class="nav-item nav-link"
                       href="${pageContext.request.contextPath}/#lesTopos">Les topos</a>
                </li>
                <li class="nav-item">
                    <a class="nav-item nav-link"
                       href="${pageContext.request.contextPath}/#Contribuez">Contribuez</a>
                </li>

                <c:if test="${user.email=='superadmin@admin.fr'}">
                    <li class="nav-item">
                        <a class="nav-item nav-link"
                           href="${pageContext.request.contextPath}/#Moderation">Moderation</a>
                    </li>
                </c:if>

            </ul>

            <ul class="navbar-nav">
                <c:if test="${empty user}">
                    <li class="nav-item">
                        <a class="nav-item nav-link"
                           href="${pageContext.request.contextPath}/escalade/login?afterLogin=redirect:/index.jsp">Login</a>
                    </li>
                </c:if>

                <c:if test="${not empty user}">
                    <li class="nav-item">
                        <p>Bienvenue <c:out value="${user.nickname}"/></p>
                    </li>
                    <li class="nav-item">
                        <a class="nav-item nav-link"
                           href="${pageContext.request.contextPath}/escalade/login/espaceMembre">Espace Membre</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-item nav-link" href="${pageContext.request.contextPath}/escalade/logout">Se
                            déconnecter</a>
                    </li>
                </c:if>
            </ul>
        </div>
    </nav>

    <h1>Gestion des réservations</h1>
    <p>
        <span class="font-italic"> <strong> <c:out value=" ${selectedGuidebook.name}"/> </strong>  <br/> </span>
        <span> <strong> <c:out value=" ${selectedGuidebook.firstnameAuthor}"/> <c:out
                value=" ${selectedGuidebook.surnameAuthor}"/> </strong>  </span>
    </p>


    <h3>Liste des réservations actuelles</h3>

    <c:if test="${message == 'bookingRemoved'}">
        <p style="color: green">La réservation a bien été supprimée. </p>
    </c:if>


    <table class="table">
        <thead>
        <tr>
            <th scope="col">Nom de l'emprunteur</th>
            <th scope="col">Du</th>
            <th scope="col">Au</th>
            <th scope="col">Email</th>
            <th scope="col">Téléphone</th>
            <th scope="col">Modifier</th>
            <th scope="col">Supprimer</th>

        </tr>
        </thead>

        <tbody>
        <c:forEach items="${privateGuidebook.bookings }" var="booking">
            <tr>
                <td><c:out value=" ${booking.bookedBy}"/></td>
                <td><javatime:format value="${booking.dateFrom}" pattern="dd/MM/uuuu"/></td>
                <td><javatime:format value="${booking.dateUntil}" pattern="dd/MM/uuuu"/></td>
                <td><c:out value=" ${booking.email}"/></td>
                <td><c:out value=" ${booking.phone}"/></td>


                <td>
                    <a href="${pageContext.request.contextPath}/escalade/memberArea/librairy/bookings/update?bookingId=${booking.id}">
                        <img src="${pageContext.request.contextPath}/resources/img/modify.png" alt="modifier"/> </a>
                </td>
                <td>
                    <a href="${pageContext.request.contextPath}/escalade/memberArea/librairy/bookings/delete?bookingId=${booking.id}">
                        <img src="${pageContext.request.contextPath}/resources/img/delete.png" alt="delete"/>
                    </a></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <c:if test="${action==null}">

        <c:if test="${message=='periodNotAvailable'}">
            <p style="color: red"> Attention, le topo n'est pas disponible pour cette période!</p>
        </c:if>

        <c:if test="${message=='dateWrong'}">
            <p style="color: red"> Attention, la date de fin ne peut pas être antérieure à la date de début!</p>
        </c:if>

        <h3>Ajouter une nouvelle réservation</h3>

        <form method="post" action="${pageContext.request.contextPath}/escalade/memberArea/librairy/bookings">

            <div class="form-group">
                <label for="booked_by">Emprunteur</label>
                <input type="text" name="booked_by" class="form-control" id="booked_by" required maxlength="100">
            </div>
            <div class="form-group">
                <label for="date_from">Date début</label>
                <input type="date" name="date_from" class="form-control" id="date_from" required>
            </div>
            <div class="form-group">
                <label for="date_until">Date fin</label>
                <input type="date" name="date_until" class="form-control" id="date_until" required>
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" name="email" class="form-control" id="email" maxlength="100">
            </div>
            <div class="form-group">
                <label for="phone">Phone</label>
                <input type="tel" name="phone" class="form-control" id="phone" maxlength="30">
            </div>

            <button type="submit" class="btn btn-primary">Valider la nouvelle réservation</button>

        </form>

    </c:if>

    <c:if test="${action=='modify'}">


        <h3>Modifier la réservation</h3>

        <form method="post" action="${pageContext.request.contextPath}/escalade/memberArea/librairy/bookings/update">

            <div class="form-group">
                <label for="booked_by2">Emprunteur</label>
                <input type="text" name="booked_by" class="form-control" id="booked_by2"
                       value="<c:out value=" ${selectedBooking.bookedBy}"/>" required>
            </div>
            <div class="form-group">
                <label for="date_from2">Date début</label>
                <input type="date" name="date_from" class="form-control" id="date_from2"
                       value="${selectedBooking.dateFrom}" required>
            </div>
            <div class="form-group">
                <label for="date_until2">Date fin</label>
                <input type="date" name="date_until" class="form-control" id="date_until2"
                       value="${selectedBooking.dateUntil}" required>
            </div>
            <div class="form-group">
                <label for="email2">Email</label>
                <input type="email" name="email" class="form-control" id="email2"
                       value="<c:out value=" ${selectedBooking.email}"/>">
            </div>
            <div class="form-group">
                <label for="phone2">Phone</label>
                <input type="tel" name="phone" class="form-control" id="phone2"
                       value="<c:out value=" ${selectedBooking.phone}"/>">
            </div>

            <button type="submit" class="btn btn-primary">Valider</button>

        </form>

    </c:if>

</div>

<jsp:include page="../../resources/JspFragments/scriptsJS.jsp"></jsp:include>


</body>

</html>
