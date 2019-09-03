<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 14/08/2019
  Time: 17:44
  To change this template use File | Settings | File Templates.
--%>

<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>

<head>
    <meta charset="UTF-8"/>
    <title>OC CLIMBING</title>
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
                <%--<li class="nav-item">--%>
                <%--<a class="nav-item nav-link active" href="#leProjet">Home <span class="sr-only">(current)</span></a>--%>
                <%--</li>--%>
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
                <li class="nav-item active">
                    <a class="nav-item nav-link">Login</a>
                </li>
            </ul>


        </div>
    </nav>


    <h1>Rejoignez la communauté OC CLIMBING</h1>

    <form method="post" action="${pageContext.request.contextPath}/escalade/newMember?afterLogin=${jspAfterLogin}">

        <p>Les données collectées sont simplement destinées à votre identification. Par défaut seul votre pseudo sera
            visible par les autres membres.<br/>
            Si vous proposez des topos au prêt, les emprunteurs auront également accès à votre email et votre numéro de
            tel pour prendre contact avec vous.
        </p>


        <c:if test="${nickname==''}">
            <p style="color: red">Ce pseudo est déjà utilisé par un autre membre, merci d'en choisir un autre.</p>
        </c:if>

        <c:if test="${email==''}">
            <p style="color: red">Il existe déjà un compte membre avec cette adresse email!</p>
        </c:if>


        <div class="form-group">
            <label for="firstName">Prénom</label>
            <input type="text" name="firstName" class="form-control" id="firstName" maxlength="30"
                   value="<c:out value="${firstname}"/>" required>
        </div>

        <div class="form-group">
            <label for="surname">Nom</label>
            <input type="text" name="surname" class="form-control" id="surname" value="<c:out value="${surname}"/>"
                   required maxlength="50">
        </div>


        <div class="form-group">
            <label for="nickname">Pseudo</label>
            <input type="text" name="nickname" class="form-control" id="nickname" value="<c:out value="${nickname}"/>"
                   required maxlength="20">
        </div>

        <div class="form-group">
            <label for="password">Mot de passe</label>
            <input type="password" name="password" class="form-control" id="password"
                   value="<c:out value="${password}"/>" required minlength="6">
        </div>

        <div class="form-group">
            <label for="email">Email</label>
            <input type="email" name="email" class="form-control" id="email" value="<c:out value="${email}"/>" required
                   maxlength="100">
        </div>

        <div class="form-group">
            <label for="phone">Téléphone</label>
            <input type="tel" name="phone" class="form-control" id="phone" value="<c:out value="${phone}"/>" required
                   maxlength="30">
        </div>

        <button type="submit" class="btn btn-primary">Valider</button>
    </form>

</div>


<jsp:include page="../../resources/JspFragments/scriptsJS.jsp"></jsp:include>

<script>
    $('.navbar-nav>li>a').on('click', function () {
        $('.navbar-collapse').collapse('hide');
    });
</script>


</body>
</html>
