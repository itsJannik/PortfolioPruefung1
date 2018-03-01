<%-- 
    Copyright © 2018 Dennis Schulmeister-Zimolong

    E-Mail: dhbw@windows3.de
    Webseite: https://www.wpvs.de/

    Dieser Quellcode ist lizenziert unter einer
    Creative Commons Namensnennung 4.0 International Lizenz.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@taglib tagdir="/WEB-INF/tags/templates" prefix="template"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<template:base>
    <jsp:attribute name="title">
        <c:choose>
            <c:when test="${edit}">
                Angebot bearbeiten
            </c:when>
            <c:otherwise>
                Aufgabe anlegen
            </c:otherwise>
        </c:choose>
    </jsp:attribute>

    <jsp:attribute name="head">
        <link rel="stylesheet" href="<c:url value="/css/task_edit.css"/>" />
    </jsp:attribute>

    <jsp:attribute name="menu">
        <div class="menuitem">
            <a href="<c:url value="/app/tasks/"/>">Übersicht</a>
        </div>
    </jsp:attribute>

    <jsp:attribute name="content">
        <form method="post" class="stacked">
            <div class="column">
                <%-- CSRF-Token --%>
                <input type="hidden" name="csrf_token" value="${csrf_token}">

                <%-- Eingabefelder --%>

                <label for="task_category">Kategorie:</label>
                <div class="side-by-side">
                    <select ${readonly ? 'disabled="disabled"' : ''} name="task_category">
                        <option value="">Keine Kategorie</option>

                        <c:forEach items="${categories}" var="category">
                            <option value="${category.id}" ${task_form.values["task_category"][0] == category.id ? 'selected' : ''}>
                                <c:out value="${category.name}" />
                            </option>
                        </c:forEach>
                    </select>
                </div>
                
                <label for="task_art">Art des Angebots</label>
                <div class="side-by-side">
                    <select ${readonly ? 'disabled="disabled"' : ''} name="task_art">
                        <option value="BIETE">Biete</option>
                        <option value="SUCHE">Suche</option>
                    </select>
                </div>
                
                <label for="task_short_text">
                    Bezeichnung:
                    <span class="required">*</span>
                </label>
                <div class="side-by-side">
                    <input ${readonly ? 'readonly="readonly"' : ''} type="text" name="task_short_text" value="${task_form.values["task_short_text"][0]}">
                </div>
                
                <label for="task_long_text">
                    Beschreibung:
                </label>
                <div class="side-by-side">
                    <textarea ${readonly ? 'readonly="readonly"' : ''} name="task_long_text"><c:out value="${task_form.values['task_long_text'][0]}"/></textarea>
                </div>
                
                <label for="task_Preis">
                    Preis:
                </label>
                <div class="side-by-side">
                    <select ${readonly ? 'disabled="disabled"' : ''} name="task_preisart">
                        <option value="FESTPREIS">Festpreis</option>
                        <option value="VERHANDLUNGSBASIS">Verhandlungsbasis</option>
                    </select>
                    <input ${readonly ? 'readonly="readonly"' : ''} type="text" name="task_preis" value="${task_form.values["task_preis"][0]}">
                </div>

                <%-- Button zum Abschicken --%>
                <div class="side-by-side">
                    <button ${readonly ? 'disabled="true"' : ''} class="icon-pencil" type="submit" name="action" value="save">
                        Sichern
                    </button>

                    <c:if test="${edit}">
                        <button ${readonly ? 'disabled="true"' : ''} class="icon-trash" type="submit" name="action" value="delete">
                            Löschen
                        </button>
                    </c:if>
                </div>
            </div>

                <h6>Angelegt am</h6>
                <label>${angelegt_am}</label>
                
                <h6>Anbieter</h6>
                <label>${user.name}</label>
                <label>${user.anschrift}</label>
                <label>${user.plz} ${user.ort}</label>
                <label>${user.email}</label>
                <label>${user.telefon}</label>
                
            <%-- Fehlermeldungen --%>
            <c:if test="${!empty task_form.errors}">
                <ul class="errors">
                    <c:forEach items="${task_form.errors}" var="error">
                        <li>${error}</li>
                    </c:forEach>
                </ul>
            </c:if>
        </form>
    </jsp:attribute>
</template:base>