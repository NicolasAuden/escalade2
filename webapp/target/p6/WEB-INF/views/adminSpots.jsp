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
                       href="${pageContext.request.contextPath}/#esSpots">Les spots</a>
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

    <h1>Modifier/supprimer un site ou une voie</h1>
    <br/>

    <h2>Étape 1: choix de la localisation</h2>


    <form method="post" action="${pageContext.request.contextPath}/escalade/admin/spots/locationInput">

        <div class="form-group">
            <label for="locationInput">Indiquez la commune dans laquelle se trouve le site à supprimer/modifier</label>
            <input type="text" name="locationInput" class="form-control" id="locationInput"
                   aria-describedby="locationInputHelp"
                   placeholder="Chamonix-Mont-Blanc..." required>
            <input type="hidden" name="step" value="step1">
            <small id="locationInputHelp" class="form-text text-muted">Les lieux disponibles s'affichent automatiquement
                lors de la saisie du texte. Choisissez parmi les propositions.
            </small>
        </div>

        <button type="submit" class="btn btn-primary">Valider la localisation</button>
    </form>

    <br/>

    <c:if test="${step == 'step2' || step == 'step3'}">
        <h2>Étape 2: choix d'un site</h2>

        <div>
            <strong>Localisation:</strong><br/>
            <c:out value="${locationInput}"/>
        </div>

        <br/>


        <c:forEach items="${selectedLocations }" var="location">
            <c:forEach items="${location.spots }" var="spot">
                <form method="post" action="${pageContext.request.contextPath}/escalade/admin/spots/update">
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <input type="text" class="form-control" id="nameSpot"
                                   name="nameSpot"
                                   value="<c:out value="${spot.nameSpot}"/>"
                                   aria-describedby="nameSpotHelp" required>
                            <small id="nameSpotHelp" class="form-text text-muted">Nom du site</small>
                            <input type="hidden" class="form-control" id="spotId" name="spotId"
                                   value="<c:out value="${spot.id}"/>">
                        </div>
                        <div class="form-group col-md-6">
                            <input type="text" class="form-control" id="nameArea" name="nameArea"
                                   aria-describedby="nameAreaHelp"
                                   value="<c:out value="${spot.nameArea}"/>">
                            <small id="nameAreaHelp" class="form-text text-muted">Nom du secteur (facultatif)
                            </small>
                        </div>
                    </div>

                    <div class="form-row">

                        <div class="form-group col-md-12">
                            <textarea class="form-control" name="spotAccess"
                                      aria-describedby="accessHelp"><c:out value="${spot.access}"/> </textarea>
                            <small id="accessHelp" class="form-text text-muted">Accès au site</small>
                        </div>

                    </div>

                    <div class="form-row">
                        <div class="form-group col-md-4">
                            <button type="submit" class="btn btn-primary">Modifier</button>
                            <button type="submit" class="btn btn-success"
                                    formaction="${pageContext.request.contextPath}/escalade/admin/spots/accessRoute">Les
                                voies
                            </button>
                            <button type="submit" class="btn btn-danger"
                                    formaction="${pageContext.request.contextPath}/escalade/admin/spots/delete">
                                Supprimer
                            </button>
                        </div>
                    </div>
                </form>

            </c:forEach>
        </c:forEach>

    </c:if>

    <br/>


    <c:if test="${step =='step3'}">

        <h2>Étape 3: choix d'une voie</h2>

        <div>
            <strong>Site:</strong><br/>
            <c:out value="${selectedSpot.nameSpot} (secteur ${selectedSpot.nameArea})"/>
        </div>

        <br/>

        <c:forEach items="${selectedSpot.routes }" var="route">

            <form method="post" action="${pageContext.request.contextPath}/escalade/admin/routes/update">

                <div class="form-row">

                    <div class="form-group col-md-4">
                        <input type="text" class="form-control" value="<c:out value="${route.name}"/>" name="name"
                               aria-describedby="nameHelp" required>
                        <small id="nameHelp" class="form-text text-muted">Nom de la voie</small>
                        <input type="hidden" class="form-control" value="<c:out value="${route.id}"/>" name="id">
                    </div>

                    <div class="form-group col-md-2">
                        <input type="text" class="form-control" value="<c:out value="${route.nbPitch}"/>" name="nbPitch"
                               aria-describedby="nbPitchHelp" required>
                        <small id="nbPitchHelp" class="form-text text-muted">Nb de longueurs</small>
                    </div>

                    <div class="form-group col-md-2">
                        <input type="text" class="form-control" value="<c:out value="${route.indexPitch}"/>"
                               name="indexPitch"
                               aria-describedby="indexPitch" required>
                        <small id="indexPitch" class="form-text text-muted">Index de cette longueur</small>
                    </div>

                    <div class="form-group col-md-2">
                        <input type="text" class="form-control" value="<c:out value="${route.rating}"/>" name="rating"
                               aria-describedby="rating" required>
                        <small id="rating" class="form-text text-muted">Cotation</small>
                    </div>

                    <div class="form-group col-md-2">

                        <div class="form-group">
                            <input type="number" name="nbAnchor" class="form-control" id="nbAnchor"
                                   value="<c:out value="${route.nbAnchor}"/>"
                                   aria-describedby="nbAnchorHelp" min="0" max="1000" required>
                            <small id="nbAnchorHelp" class="form-text text-muted">Nb points ancrage</small>
                        </div>

                    </div>


                </div>


                <div class="form-row">
                    <div class="form-group col-md-4">
                        <button type="submit" class="btn btn-primary">Modifier</button>
                        <button type="submit" class="btn btn-danger"
                                formaction="${pageContext.request.contextPath}/escalade/admin/routes/delete">
                            Supprimer
                        </button>
                    </div>

                </div>

            </form>

        </c:forEach>

    </c:if>


</div>


<jsp:include page="../../resources/JspFragments/scriptsJS.jsp"></jsp:include>


<script>

    $(function () {
        $("#locationInput, #locationInputForTopo").autocomplete({
            minLength: 2,
            source: '${pageContext.request.contextPath}/escalade/autocomplete/citiesForUpdateSpots',

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



