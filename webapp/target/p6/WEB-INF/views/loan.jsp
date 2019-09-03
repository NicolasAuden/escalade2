<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 04/02/2019
  Time: 16:39
  To change this template use File | Settings | File Templates.
--%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>High</title>
    <link href="${pageContext.request.contextPath}/webjars/bootstrap/4.2.1/css/bootstrap.min.css"
          rel="stylesheet"/>
    <link href="https://code.jquery.com/ui/1.10.4/themes/ui-lightness/jquery-ui.css"
          rel="stylesheet">

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


    <h1>Emprunter un topo</h1>

    <p><strong> <span class="font-italic"> ${selectedGuidebook.name} </span>
        <br/> <span> ${selectedGuidebook.firstnameAuthor} ${selectedGuidebook.surnameAuthor} </span> </strong></p>

    <form method="post" action="${pageContext.request.contextPath}/escalade/memberArea/librairy/loan/checkDates">

        <h3>Entrez ci-dessous les dates souhaitées de la réservation</h3>

        <c:if test="${message=='dateWrong'}">
            <p style="color: red"> Attention, la date de fin ne peut pas être antérieure à la date de début!</p>
        </c:if>


        <div class="form-group">
            <label for="date_from">Date début</label>
            <input type="date" name="date_from" class="form-control" id="date_from" min="" required>
        </div>
        <div class="form-group">
            <label for="date_until">Date fin</label>
            <input type="date" name="date_until" class="form-control" id="date_until" required>
        </div>

        <button type="submit" class="btn btn-primary">Valider</button>
    </form>

    <br/>

    <c:if test="${privateGuidebooks!=null}">
        <h3>Pour la période indiquée, ce topo est disponible auprès des membres suivants</h3>
        <br/>
        <p>Veuillez prendre contact avec l'un d'entre-eux</p>

        <c:forEach items="${ privateGuidebooks }" var="ownerGuidebook">
            <ul>
                <li> <span> ${ownerGuidebook.member.firstName} ${ownerGuidebook.member.surname} /
             ${ownerGuidebook.member.email} / Tel: ${ownerGuidebook.member.phone} </span></li>
            </ul>
        </c:forEach>

    </c:if>

    <c:if test="${empty privateGuidebooks && privateGuidebooks!=null}">
        <p style="color: red"> Le topo n'est malheureusement pas disponible sur la période indiquée. </p>
    </c:if>


</div>


<jsp:include page="../../resources/JspFragments/scriptsJS.jsp"></jsp:include>


<script>
    $(function () {
        $("#locationSpotsForGuidebook").autocomplete({
            minLength: 2,
            source: '${pageContext.request.contextPath}/escalade/get_location_list'
        });
    });

</script>


</body>
</html>
