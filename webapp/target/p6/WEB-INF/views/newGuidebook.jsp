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

    <h1>Ajouter un nouveau topo à la base de donnée <br/> ou améliorer le référencement d'un topo existant</h1>
    <br/>


    <h2>Étape 1: Saisie du code ISBN13</h2>


    <form method="post" action="${pageContext.request.contextPath}/escalade/addcontent/guidebook/isbn">

        <div class="form-group">
            <label for="isbn13">Saisissez le numéro ISBN13 du topo</label>
            <input type="text" name="isbn13" class="form-control" id="isbn13" aria-describedby="helpIsbn"
                   pattern="\d{13}" required>
            <small id="helpIsbn" class="form-text text-muted">Combinaison de 13 chiffres, sans tirets</small>
            <small></small>
        </div>

        <button type="submit" class="btn btn-primary">Valider</button>
    </form>

    <br/>


    <c:if test="${(step == 'step2' || step == 'step3') }">
        <h2>Étape 2: référencement du topo </h2>

        <c:if test="${selectedGuidebook.id == '-1' }">

            <form method="post" action="${pageContext.request.contextPath}/escalade/addcontent/guidebook">

                <div class="form-group">
                    <label for="isbn">Saisissez le numéro ISBN13 du topo</label>
                    <input type="number" name="isbn13" class="form-control" id="isbn" value="${isbn13}" readonly>
                </div>

                <div class="form-group">
                    <label for="name">Titre de l'ouvrage</label>
                    <input type="text" name="name" class="form-control" id="name" required>
                </div>

                <div class="form-group">
                    <label for="firstnameAuthor">Prénom de l'auteur</label>
                    <input type="text" name="firstnameAuthor" class="form-control" id="firstnameAuthor" required
                           maxlength="30">
                </div>

                <div class="form-group">
                    <label for="surnameAuthor">Nom de l'auteur</label>
                    <input type="text" name="surnameAuthor" class="form-control" id="surnameAuthor" required
                           maxlength="50">
                </div>

                <div class="form-group">
                    <label for="yearPublication">Année de publication</label>
                    <input type="number" name="yearPublication" class="form-control" id="yearPublication"
                           max="${actualYear}" min="1900" required>
                </div>

                <div class="form-group">
                    <label for="publisher">Éditeur</label>
                    <input type="text" name="publisher" class="form-control" id="publisher" required maxlength="50">
                </div>

                <div class="form-group">
                    <label for="language">Langue</label>
                    <input type="text" name="language" class="form-control" id="language" required maxlength="50">
                </div>

                <div>
                    <label for="summary">Présentation de l'ouvrage:</label>
                    <textarea class="form-control" rows="5" id="summary" name="summary" maxlength="1000"
                              required></textarea>
                </div>

                <button type="submit" class="btn btn-primary">Valider</button>
            </form>
        </c:if>

        <c:if test="${selectedGuidebook.id != '-1' }">
            <p>
            <p style="color: green"> Le topo avec le numéro ISBN ${selectedGuidebook.isbn13} est référencé dans la base
                de donnée </p>
            <p><strong>Titre de l'ouvrage:</strong> ${selectedGuidebook.name}
                <br/><strong>Auteur:</strong> ${selectedGuidebook.firstnameAuthor} ${selectedGuidebook.surnameAuthor}
            </p>
        </c:if>
    </c:if>

    <br/>
    <c:if test="${step == 'step3'}">

        <h2 id="step3">Étape 3: Valider les sites couverts par le topo </h2>

        <script>
            $("html, body").animate({scrollTop: $('#etape3').offset().top}, 1000);
        </script>


        <p>Afin que les topos référencés soient visibles pour les utilisateurs, il est <strong>indispensable</strong>
            d'indiquer quels sont les sites qu'ils couvrent.</p>

        <h4>Ci-dessous la liste des sites actuellement associés au topo:</h4>

        <table class="table">
            <thead>
            <tr>
                <th scope="col">Nom du site</th>
                <th scope="col">Secteur</th>
                <th scope="col">Commune</th>
                <th scope="col">Département</th>
            </tr>
            </thead>


            <tbody>
            <c:forEach items="${ selectedGuidebook.spots}" var="spot">
                <tr>
                    <td><c:out value="${spot.nameSpot}"/></td>
                    <td><c:out value="${spot.nameArea}"/></td>
                    <td>${ spot.location.cityName } </td>
                    <td>${ spot.location.departementName} (${spot.location.departementId})</td>
                </tr>
            </c:forEach>

            </tbody>
        </table>


        <h4>Compléter la liste</h4>

        <p> Pour cela vous devez d'abord vous assurer que les sites que vous souhaitez associer au topo sont référencés
            dans la base de
            données et si ce n'est pas le cas, <a
                    href=${pageContext.request.contextPath}/escalade/addcontent/spot
                    target="_blank">les ajouter.</a>
            Ensuite il suffit de saisir une localité et de sélectionner les sites à associer parmi la liste des
            propositions. </p>

        <form method="get" action="${pageContext.request.contextPath}/escalade/spotsForGuidebook">

            <div class="form-group">
                <input type="text" name="locationSpotsForGuidebook" class="form-control" id="locationSpotsForGuidebook"
                       placeholder="Région, département, commune dans lesquels se situent les sites à ajouter"
                       aria-describedby="inputLocationHelp">
                <small id="inputLocationHelp" class="form-text text-muted">Les lieux disponibles s'affichent
                    automatiquement lors de la saisie du texte
                </small>

            </div>

            <button type="submit" class="btn btn-primary">Valider</button>
        </form>

        <c:if test="${alert=='notFound'}">
            <p style="color: red"> Attention, la localisation doit être choisie parmi la liste des propositions
            </p>
        </c:if>

        <c:if test="${alert=='noSpot'}">
            <p style="color: red">La recherche n'a donné aucun résultat</p>
        </c:if>

        <c:if test="${alert=='ok'}">

            <form method="post" action="${pageContext.request.contextPath}/escalade/spotsForGuidebook">

                <table class="table">
                    <thead>
                    <tr>
                        <th scope="col">Sélection</th>
                        <th scope="col">Nom du site</th>
                        <th scope="col">Secteur</th>
                        <th scope="col">Commune</th>
                        <th scope="col">Département</th>
                    </tr>
                    </thead>


                    <tbody>
                    <c:forEach items="${ listMatchingLocations}" var="location">

                        <c:if test="${empty location.spots}" var="noSpots" scope="session"/>

                        <c:forEach items="${ location.spots }" var="spot">
                            <tr>
                                <td scope="col">
                                    <div class="checkbox">
                                        <input type="checkbox" name="selectedSpots" value="${spot.id}">
                                    </div>
                                </td>
                                <td><c:out value="${spot.nameSpot}"/></td>
                                <td><c:out value="${spot.nameArea}"/></td>
                                <td>${ location.cityName } </td>
                                <td>${ location.departementName} (${location.departementId})</td>
                            </tr>
                        </c:forEach>
                    </c:forEach>

                    </tbody>
                </table>
                <button type="submit" class="btn btn-primary">Associer les sites sélectionnés au topo</button>
            </form>
        </c:if>

        <c:if test="${user.email=='superadmin@admin.fr'}">
            <h2>Supprimer ou effectuer des modifications sur ce topo?</h2>
            <div>
                <a href="${pageContext.request.contextPath}/escalade/admin/guidebooks/isbn?isbn13=${selectedGuidebook.isbn13}#step2">
                    Afficher la page de modération</a>
            </div>
        </c:if>


    </c:if>


</div>


<jsp:include page="../../resources/JspFragments/scriptsJS.jsp"></jsp:include>

<script>

    $(function () {
        $("#locationSpotsForGuidebook").autocomplete({
            minLength: 2,
            source: '${pageContext.request.contextPath}/escalade/get_location_list',

            change: function (event, ui) {
                if (!ui.item) {
                    this.value = '';
                }
            }

        });
    });


</script>


</body>
</html>
