<%--suppress ALL --%>
<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 14/02/2019
  Time: 17:44
  To change this template use File | Settings | File Templates.
--%>

<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="javatime" uri="http://sargue.net/jsptags/time" %>
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
                        <p>Bienvenue <c:out value=" ${user.nickname}"/></p>
                    </li>
                    <li class="nav-item">
                        <a class="nav-item nav-link active">Espace Membre</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-item nav-link" href="${pageContext.request.contextPath}/escalade/logout">Se
                            déconnecter</a>
                    </li>
                </c:if>
            </ul>


        </div>
    </nav>


    <h1>ESPACE MEMBRE</h1>

    <br/>

    <div>
        <h2>Coordonnées</h2>

        <p>
            <span> <c:out value="${user.firstName}"/> <c:out value="${user.surname}"/></span> <br/>
            <span> Membre depuis le <javatime:format value="${user.dateMembership}" pattern="dd/MM/uuuu"/></span> <br/>
            <span> Pseudo: <c:out value="${user.nickname}"/> </span> <br/>
            <span> Email: <c:out value="${user.email}"/> / Télephone: <c:out value="${user.phone}"/></span>

        </p>

        <p>
        <p>
            <a href="${pageContext.request.contextPath}/escalade/login/resetPassword">
                <img src="${pageContext.request.contextPath}/resources/img/lock.png" title="Changer le mot de passe"
                     alt="logo cadenas">
            </a>
        </p>
        <c:if test="${message=='password2different'}">
            <p style="color: red">Erreur de saisie, les mots de passe ne sont pas identiques!</p>
        </c:if>

        <c:if test="${message=='ok'}">
            <p style="color: green">Le mot de passe a bien été changé. </p>
        </c:if>


        <c:if test="${action=='resetPassword'}">


            <br/>

            <form method="post" action="${pageContext.request.contextPath}/escalade/login/resetPassword">

                <div class="form-group">
                    <label for="password1">Choisissez un nouveau mot de passe</label>
                    <input type="password" name="password1" class="form-control" id="password1" onfocus="this.value=''"
                           autofocus>
                </div>

                <div class="form-group">
                    <label for="password2">Saisissez à nouveau le mot de passe</label>
                    <input type="password" name="password2" class="form-control" id="password2">
                </div>

                <button type="submit" class="btn btn-primary">Changer le mot de passe</button>
            </form>

        </c:if>

    </div>


    <div>
        <h2 id="librairy" style="margin-top: 2em">Ma bibliothèque </h2>

        <p>
        <h4>Liste des topos que je propose au prêt:</h4>

        <table class="table">
            <thead>
            <tr>
                <th scope="col">Titre</th>
                <th scope="col">Auteur</th>
                <th scope="col">Date publication</th>
                <th scope="col">Gérer les réservations</th>
                <th scope="col">Supprimer de la bibliothèque</th>

            </tr>
            </thead>

            <tbody>
            <c:forEach items="${guidebooksForLoan }" var="guidebook">
                <tr>
                    <td><c:out value="${guidebook.name}"/> (ISBN <c:out value="${guidebook.isbn13}"/>)</td>
                    <td><c:out value="${guidebook.firstnameAuthor}"/> <c:out value="${guidebook.surnameAuthor}"/></td>
                    <td><c:out value="${guidebook.yearPublication}"/></td>
                    <td>
                        <a href="${pageContext.request.contextPath}/escalade/memberArea/librairy/goToBookings?guidebookId=${guidebook.id}">
                            <img src="${pageContext.request.contextPath}/resources/img/logoGestionResa.png"
                                 alt="réservation"/> </a></td>
                    <td>
                        <a href="${pageContext.request.contextPath}/escalade/memberArea/librairy/delete?guidebookId=${guidebook.id}">
                            <img src="${pageContext.request.contextPath}/resources/img/delete.png" alt="delete"/>
                        </a></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <c:if test="${message == 'guidebookRemoved'}">
            <p style="color: green"> Le topo a bien été supprimé de la liste.</p>
        </c:if>

        <p>
        <h4>Ajouter un topo référencé à la liste</h4>

        <c:if test="${message == 'guidebookAdded'}">
            <p style="color: green">Le topo a bien été ajouté à la liste.</p>
        </c:if>

        <c:if test="${message == 'notFound'}">
            <p style="color: red"> Ce topo n'est pas encore référencé. <a
                    href="${pageContext.request.contextPath}/escalade/addcontent/guidebook">Vous pouvez le faire en
                cliquant
                ici.</a></p>
        </c:if>

        <c:if test="${message == 'alreadyListed'}">
            <p style="color: green"> Le topo est déjà présent dans votre bibliothèque.</p>
        </c:if>

        <form method="post" action="${pageContext.request.contextPath}/escalade/memberArea/librairy/isbn">

            <div class="form-group">
                <label for="isbn13">Saisissez le numéro ISBN13 du topo</label>
                <input type="text" name="isbn13" class="form-control" id="isbn13" aria-describedby="helpIsbn"
                       pattern="\d{13}" required>
                <small id="helpIsbn" class="form-text text-muted">Combinaison de 13 chiffres, sans tirets</small>
            </div>

            <button type="submit" class="btn btn-primary">Ajouter</button>
        </form>

    </div>

    <div>
        <h2 style="margin-top: 2em">Supprimer mon compte </h2>

        <form method="post" action="${pageContext.request.contextPath}/escalade/admin/delete/memberAccount">

            <div class="form-check">
                <input type="checkbox" name="deleteMemberAccount" id="deleteMemberAccount"
                       class="form-check-input">
                <label class="form-check-label" for="deleteMemberAccount">
                    Je souhaite supprimer mon compte. Attention, cette action est irréversible!
                </label>
                <input type="hidden" name="userId" value="${user.id}">
            </div>

            <c:if test="${message == 'checkboxNotChecked'}">
                <p style="color: red">Pour supprimer le compte, veuillez cocher la case. </p>
            </c:if>

            <button type="submit" class="btn btn-danger">Supprimer</button>

        </form>
    </div>

</div>


<jsp:include page="../../resources/JspFragments/scriptsJS.jsp"></jsp:include>


</body>

</html>
