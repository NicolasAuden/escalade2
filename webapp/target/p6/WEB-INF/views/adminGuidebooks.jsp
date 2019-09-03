<%--suppress ALL --%>
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

    <h1>Modifier ou supprimer un topo </h1>
    <br/>

    <h2>Étape 1: Saisie du code ISBN13</h2>

    <form method="get" action="${pageContext.request.contextPath}/escalade/admin/guidebooks/isbn">

        <div class="form-group">
            <label for="isbn13">Saisissez le numéro ISBN13 du topo</label>
            <input type="text" name="isbn13" class="form-control" id="isbn13" aria-describedby="helpIsbn"
                   pattern="\d{13}" required>
            <small id="helpIsbn" class="form-text text-muted">Combinaison de 13 chiffres, sans tirets</small>
            <small></small>
        </div>

        <button type="submit" class="btn btn-primary">Valider</button>
    </form>


    <c:if test="${message == 'guidebookDeleted' }">
        <p style="color: green"> Le topo a bien été supprimé.</p>
    </c:if>


    <c:if test="${message == 'notFound' }">
        <p style="color: red"> Ce numéro ISBN ne correspond à aucun topo référencé.</p>
    </c:if>


    <c:if test="${ step == 'guidebookSelected' }">

        <h2 id="step2">Étape 2: référencement du topo</h2>

        <h4>Modification des champs: </h4>

        <form method="post" action="${pageContext.request.contextPath}/escalade/admin/guidebooks/update">

            <div class="form-group">
                <label for="isbn"> Numéro ISBN13 du topo</label>
                <input type="number" name="isbn13" class="form-control" id="isbn"
                       value="<c:out value="${selectedGuidebook.isbn13}"/>"
                       readonly>
            </div>

            <div class="form-group">
                <label for="name">Titre de l'ouvrage</label>
                <input type="text" name="name" class="form-control" id="name"
                       value="<c:out value="${selectedGuidebook.name}"/>"
                       required>
            </div>

            <div class="form-group">
                <label for="firstnameAuthor">Prénom de l'auteur</label>
                <input type="text" name="firstnameAuthor" class="form-control" id="firstnameAuthor"
                       value="<c:out value="${selectedGuidebook.firstnameAuthor}"/>" required>
            </div>

            <div class="form-group">
                <label for="surnameAuthor">Nom de l'auteur</label>
                <input type="text" name="surnameAuthor" class="form-control" id="surnameAuthor"
                       value="<c:out value="${selectedGuidebook.surnameAuthor}"/>" required>
            </div>

            <div class="form-group">
                <label for="yearPublication">Année de publication</label>
                <input type="number" name="yearPublication" class="form-control" id="yearPublication"
                       value="<c:out value="${selectedGuidebook.yearPublication}"/>" max="${actualYear}" min="1900"
                       required>
            </div>

            <div class="form-group">
                <label for="publisher">Éditeur</label>
                <input type="text" name="publisher" class="form-control" id="publisher"
                       value="<c:out value="${selectedGuidebook.publisher}"/>" required>
            </div>

            <div class="form-group">
                <label for="language">Langue</label>
                <input type="text" name="language" class="form-control" id="language"
                       value="<c:out value="${selectedGuidebook.language}"/>" required>
            </div>

            <div>
                <label for="summary">Présentation de l'ouvrage:</label>
                <textarea class="form-control" rows="5" id="summary" name="summary" maxlength="1000"
                          required><c:out value="${selectedGuidebook.summary}"/></textarea>
            </div>

            <button type="submit" class="btn btn-primary">Modifier</button>
        </form>

        <c:if test="${message == 'guidebookUpdated' }">
            <p style="color: green"> Le topo a bien été modifié.</p>

        </c:if>


        <h4>Suppression du topo: </h4>

        <form method="post"
              action="${pageContext.request.contextPath}/escalade/admin/guidebooks/delete?isbn13=${selectedGuidebook.isbn13}">

            <div class="form-check">
                <input type="checkbox" name="deleteGuidebook" id="deleteGuidebook"
                       class="form-check-input">
                <label class="form-check-label" for="deleteGuidebook" style="color: red">
                    Supprimer le topo. Attention, cette action est irréversible!
                </label>
            </div>

            <button type="submit" class="btn btn-danger">Supprimer</button>


        </form>


        <br/>

        <h2 id="step3">Étape 3: Valider les sites couverts par le topo </h2>

        <script>
            $("html, body").animate({scrollTop: $('#etape3').offset().top}, 1000);
        </script>


        <h4>Ci-dessous la liste des sites actuellement associés au topo:</h4>

        <table class="table">
            <thead>
            <tr>
                <th scope="col">Nom du site</th>
                <th scope="col">Secteur</th>
                <th scope="col">Commune</th>
                <th scope="col">Département</th>
                <th scope="col">Supprimer</th>
            </tr>
            </thead>


            <tbody>
            <c:forEach items="${ selectedGuidebook.spots}" var="spot">
                <tr>
                    <th><c:out value="${spot.nameSpot}"/></th>
                    <th><c:out value="${spot.nameArea}"/></th>
                    <th><c:out value="${spot.location.cityName}"/></th>
                    <th><c:out value="${spot.location.departementName}"/> <c:out
                            value="(${spot.location.departementId})"/></th>
                    <td>
                        <a href="${pageContext.request.contextPath}/escalade/admin/guidebooks/deleteLinkGuidebookSpot?isbn13=${selectedGuidebook.isbn13}&spotId=${spot.id}">
                            <img src="${pageContext.request.contextPath}/resources/img/delete.png" alt="delete"/> </a>
                    </td>
                </tr>
            </c:forEach>

            </tbody>
        </table>

        <c:if test="${message == 'spotDeleted' }">
            <p style="color: green"> Le spot a bien été supprimé.</p>

        </c:if>

        <h4>Pour associer d'autres sites au topo: </h4>
        <a href="${pageContext.request.contextPath}/escalade/addcontent/guidebook/isbn?isbn13=${selectedGuidebook.isbn13}#step3">
            quitter la page de modération et rejoindre la partie publique du site</a>

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
