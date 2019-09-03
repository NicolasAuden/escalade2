<%--suppress ALL --%>
<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 12/02/2019
  Time: 11:03
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
                    <a class="nav-item nav-link" href="${pageContext.request.contextPath}/#lesSpots">Les spots</a>
                </li>
                <li class="nav-item">
                    <a class="nav-item nav-link" href="${pageContext.request.contextPath}/#lesTopos">Les topos</a>
                </li>
                <li class="nav-item">
                    <a class="nav-item nav-link" href="${pageContext.request.contextPath}/#Contribuez">Contribuez</a>
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
                        <p>Bienvenue <c:out value=" ${user.nickname}"/></p>
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


    <p><strong>LISTE DES TOPOS CORRESPONDANT À LA LOCALISATION "${locationInputForTopo}" </strong></p>

    <c:if test="${ empty guidebookListWithoutDuplicates}">
        <p style="color: red">La recherche n'a donné aucun résultat. Essayer d'élargir vos critères de recherches.</p>
    </c:if>


    <c:forEach items="${guidebookListWithoutDuplicates }" var="guidebook">
        <p style="margin-top: 2em">
            <a href="${pageContext.request.contextPath}/escalade/spotsFromGuidebook?guidebookIdForSpots=${guidebook.id}">
                <img src="${pageContext.request.contextPath}/resources/img/mountain.png"
                     title="Afficher les sites correspondants" alt="Les sites">
            </a>

            <c:if test="${not empty guidebook.memberLibrairies }">
                <a href="${pageContext.request.contextPath}/escalade/memberArea/librairy/loan?guidebookId=${guidebook.id}">
                    <img src="${pageContext.request.contextPath}/resources/img/agenda.png"
                         title="Emprunter ce topo auprès d'un membre" alt="emprunter le topo">
                </a>
            </c:if>

            <span class="font-italic"> <strong><c:out value="${ guidebook.name }"/> <br/></strong> </span>
            <span> <c:out value="${ guidebook.firstnameAuthor }"/> <c:out
                    value="${ guidebook.surnameAuthor }"/> </span>
        </p>

        <p>
            <span> Nr. ISBN 13: <c:out value="${ guidebook.isbn13 }"/><br/></span>
            <span> Éditions: <c:out value="${ guidebook.publisher }"/><br/></span>
            <span> Langue: <c:out value="${ guidebook.language}"/><br/></span>
            <span> Année de publication: <c:out value="${ guidebook.yearPublication}"/></span>
        </p>

        <p>
            <c:out value="${ guidebook.summary }"/><br/>
        </p>

    </c:forEach>

</div>

<jsp:include page="../../resources/JspFragments/scriptsJS.jsp"></jsp:include>


</body>
</html>
