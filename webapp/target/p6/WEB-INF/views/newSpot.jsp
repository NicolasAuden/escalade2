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

    <h1>Ajouter un site ou une voie à la base de donnée</h1>
    <br/>

    <h2>Étape 1: choix de la localisation</h2>


    <form method="post" action="${pageContext.request.contextPath}/escalade/addcontent/spot/checkCityInput">
        <button type="submit" disabled style="display: none" aria-hidden="true"></button>

        <div class="form-group">
            <label for="cityNameInput">Indiquez la commune dans laquelle se trouve le site à ajouter ou
                compléter</label>
            <input type="text" name="cityNameInput" class="form-control" id="cityNameInput"
                   aria-describedby="cityNameHelp"
                   placeholder="Chamonix-Mont-Blanc..." required>
            <small id="cityNameHelp" class="form-text text-muted">Saisissez les premières lettres de la ville et
                choisissez parmi les propositions affichées.
            </small>
            <input type="hidden" name="region" class="form-control" id="region">
            <input type="hidden" name="departementName" class="form-control" id="departementName">
            <input type="hidden" name="departementId" class="form-control" id="departementId">
        </div>

        <div class="form-group">
            <label for="codePostal">Code postal</label>
            <input type="text" name="codePostal" class="form-control" id="codePostal" pattern="\d{5}"
                   aria-describedby="codePostalHelp" required>
            <small id="codePostalHelp" class="form-text text-muted">Le code postal s'affiche automatiquement.
                Dans le cas de communes disposant de plusieurs codes postaux, il peut être nécessaire de le corriger.
            </small>
        </div>

        <button type="submit" class="btn btn-primary">Valider la localisation</button>
    </form>

    <br/>

    <c:if test="${step == 'step2' || step == 'step3'}">
        <h2>Étape 2: ajouter sites et/ou voies</h2>

        <div>
            <strong>Localisation:</strong><br/>
            <c:out value="Région: ${ selectedLocation.region}, département: ${ selectedLocation.departementName}"/>
            <br/>
            <c:out value="${ selectedLocation.zipCode }"/> <c:out value="${ selectedLocation.cityName }"/>
        </div>

        <br/>

        <h4 class="font-italic">Référencer un nouveau site/secteur</h4>

        <form method="post" action="${pageContext.request.contextPath}/escalade/addcontent/addNewSpot">
            <div class="form-group">
                <label for="nameSpot">Nom du site</label>
                <input type="text" name="nameSpot" class="form-control" id="nameSpot" required maxlength="50">
            </div>

            <div class="form-group">
                <label for="nameArea">Nom du secteur (facultatif)</label>
                <input type="text" name="nameArea" class="form-control" id="nameArea" maxlength="50">
            </div>

            <div class="form-group">
                <label for="spotAccess">Accès au site</label>
                <textarea class="form-control" name="spotAccess" id="spotAccess" required></textarea>
            </div>

            <div class="form-group">
                <label for="comment">Commentaire:</label>
                <textarea class="form-control" rows="5" id="comment" name="comment"></textarea>
            </div>

            <button type="submit" class="btn btn-primary">Ajouter un site/secteur</button>
        </form>

        <br/>

        <c:if test="${not empty selectedLocation.spots}">

            <h4 class="font-italic">et/ou ajouter une voie à un site déjà référencé</h4>
            <form method="post" action="${pageContext.request.contextPath}/escalade/addcontent/formNewRoute">

                <div class="form-group">
                    <label for="selectedSpot">Choisissez un site/secteur</label>
                    <select name="selectedSpot" class="form-control" id="selectedSpot">
                        <c:forEach items="${selectedLocation.spots}" var="spot">
                            <option value=${spot.id}>
                                Site: <c:out value="${spot.nameSpot}"/> / secteur: <c:out value="${spot.nameArea}"/>
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <button type="submit" class="btn btn-primary">Ajouter une voie à ce site/secteur</button>
            </form>
        </c:if>

    </c:if>

    <br/>


    <c:if test="${step == 'step3'}">

        <h2>Étape 3: ajouter une nouvelle voie ou longueur pour ce site/secteur</h2>

        <mark><strong>Site: </strong> <c:out value="${ selectedSpot.nameSpot } "/> <strong>secteur:
        </strong><c:out value="${ selectedSpot.nameArea } "/></mark>

        <c:if test="${not empty selectedSpot.routes }">
            <p>Voie(s) déjà répertoriée(s):</p>
        </c:if>

        <table class="table">
            <thead>
            <tr>
                <th scope="col">Nom de la voie</th>
                <th scope="col">Cotation</th>
                <th scope="col">Longueur</th>
                <th scope="col">Nb points d'ancrage</th>
            </tr>
            </thead>

            <tbody>
            <c:forEach items="${selectedSpot.routes}" var="route">
                <tr>
                    <td><c:out value="${route.name}"/></td>
                    <td><c:out value="${route.rating}"/></td>
                    <td><c:out value="${route.indexPitch}"/>/<c:out value="${route.nbPitch}"/></td>
                    <td><c:out value="${route.nbAnchor}"/></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>


        <br/>

        <c:if test="${message == 'ok'}">
            <p style="color: green"> La voie a bien été ajoutée!</p> <br/>
        </c:if>

        <form method="post" action="${pageContext.request.contextPath}/escalade/addcontent/newRoute">

            <div class="form-group">
                <label for="newRoute">Nom de la voie:</label>
                <input type="text" name="name" class="form-control" id="newRoute" required maxlength="100">
            </div>

            <div class="form-group">
                <label for="nbPitch">Nombre de longueurs: </label>
                <input type="number" name="nbPitch" class="form-control" id="nbPitch" required>
            </div>

            <div class="form-group">
                <label for="indexPitch">Indiquez l'index de la longueur actuellement référencée:</label>
                <input type="number" name="indexPitch" class="form-control" id="indexPitch" required>
            </div>

            <div class="form-group">
                <label for="rating">Cotation:</label>
                <input type="text" name="rating" class="form-control" id="rating" required maxlength="4">
            </div>

            <div class="form-group">
                <label for="nbAnchor">Nombre de points d'ancrage: </label>
                <input type="number" name="nbAnchor" class="form-control" id="nbAnchor" aria-describedby="nbAnchorHelp"
                       min="0" max="1000" required>
                <small id="nbAnchorHelp" class="form-text text-muted">0 si la voie n'est pas équipée.
                </small>
            </div>

            <button type="submit" class="btn btn-primary">Ajouter une voie à ce site/secteur</button>
        </form>


    </c:if>


</div>

<jsp:include page="../../resources/JspFragments/scriptsJS.jsp"></jsp:include>


<script>


    $(function () {
        $("#cityNameInput").autocomplete({
            source: function (request, response) {
                $.ajax({
                    url: "https://geo.api.gouv.fr/communes?nom=" + request.term + "&fields=codesPostaux,departement,region",
                    dataType: "json",
                    data: {},

                    success: function (data) {
                        response($.map(data, function (item) {
                            return {
                                label: (item.nom + ' (' + item.departement.nom + ')'),
                                value: item.nom,
                                departementName: item.departement.nom,
                                departementId: item.departement.code,
                                region: item.region.nom,
                                codesPostal: item.codesPostaux[0]
                            }
                        }));
                    }
                });
            },

            minLength: 3,
            focus: function (event, ui) {
                $("#cityNameInput").val(ui.item.value);
                return false;
            },


            select: function (event, ui) {
                $("#cityNameInput").val(ui.item.value);
                $("#region").val(ui.item.region);
                $("#departementName").val(ui.item.departementName);
                $("#departementId").val(ui.item.departementId);
                $("#codePostal").val(ui.item.codesPostal);
                return false;
            },


            change: function (event, ui) {
                if (!ui.item) {
                    this.value = '';
                }
            }
        })
    });

</script>


</body>
</html>
