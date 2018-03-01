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

<c:set var="base_url" value="<%=request.getContextPath()%>" />

<template:base>
    <jsp:attribute name="title">
        Benutzer bearbeiten
    </jsp:attribute>

    <jsp:attribute name="head">
        <link rel="stylesheet" href="<c:url value="/css/login.css"/>" />
    </jsp:attribute>

    <jsp:attribute name="menu">
        <div class="menuitem">
            <a href="<c:url value="/app/tasks/"/>">Übersicht</a>
        </div>
        
    </jsp:attribute>

    <jsp:attribute name="content">
        <div class="container">
            <form method="post" class="stacked">
                <div class="column">
                    <%-- CSRF-Token --%>
                    <input type="hidden" name="csrf_token" value="${csrf_token}">

                    <h3>Passwort ändern</h3>
                    
                    <%-- Eingabefelder --%>
                    <label for="signup_username">
                        Benutzername:
                    </label>
                    <div class="side-by-side">
                        <input type="text" name="signup_username" value="${user_name}">
                    </div>

                    <label for="signup_password">
                        Altes Passwort:
                        <span class="required">*</span>
                    </label>
                    <div class="side-by-side">
                        <input type="password" name="signup_password" value="">
                    </div>

                    <label for="signup_password1">
                        Neues Passwort:
                        <span class="required">*</span>
                    </label>
                    <div class="side-by-side">
                        <input type="password" name="signup_password1" value="">
                    </div>
                    
                    <label for="signup_password2">
                        Neues Passwort (wdh.):
                        <span class="required">*</span>
                    </label>
                    <div class="side-by-side">
                        <input type="password" name="signup_password2" value="">
                    </div>
                    
                    <h3>Anschrift</h3>
                    
                    <label for="signup_vnnn">
                        Vor- und Nachname:
                        <span class="required">*</span>
                    </label>
                    <div class="side-by-side">
                        <input type="text" name="signup_vnnn" value="${vnnn}">
                    </div>
                    
                    <label for="signup_str_hn">
                        Straße und Hausnummer:
                        <span class="required">*</span>
                    </label>
                    <div class="side-by-side">
                        <input type="text" name="signup_str_hn" value="${strhn}">
                    </div>
                    
                    <label for="signup_plz">
                        Postleitzahl und Ort
                        <span class="required">*</span>
                    </label>
                    <div class="side-by-side">
                        <input type="text" name="signup_plz" value="${plz}">
                        <input type="text" name="signup_ort" value="${ort}">

                    </div>
                        
                        <h3>Kontaktdaten</h3>
                        
                    <label for="signup_email">
                        E-Mail
                        <span class="required">*</span>
                    </label>
                    <div class="side-by-side">
                        <input type="text" name="signup_email" value="${email}">
                    </div>
                    
                    <label for="signup_telefon">
                        Telefon
                        <span class="required">*</span>
                    </label>
                    <div class="side-by-side">
                        <input type="text" name="signup_telefon" value="${tel}">
                    </div>
                        
                    
                        
                        
                    <!--
                    <div class="side-by-side">
                        <input type="text" name="signup_username" value="${signup_form.values["signup_username"][0]}">
                    </div>-->
                    

                    <%-- Button zum Abschicken --%>
                    <div class="side-by-side">
                        <button class="icon-pencil" type="submit">
                            Daten verändern
                        </button>
                    </div>
                </div>

                <%-- Fehlermeldungen --%>
                <c:if test="${!empty signup_form.errors}">
                    <ul class="errors">
                        <c:forEach items="${signup_form.errors}" var="error">
                            <li>${error}</li>
                            </c:forEach>
                    </ul>
                </c:if>
            </form>
        </div>
    </jsp:attribute>
</template:base>