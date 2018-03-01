/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dhbwka.wwi.vertsys.javaee.jtodo.web;

import dhbwka.wwi.vertsys.javaee.jtodo.ejb.UserBean;
import dhbwka.wwi.vertsys.javaee.jtodo.ejb.ValidationBean;
import dhbwka.wwi.vertsys.javaee.jtodo.jpa.User;
import java.io.IOException;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author LucasWalter
 */
@WebServlet(urlPatterns = "/app/editUser/*")
public class EditUserServlet extends HttpServlet{
    
    @EJB
    private UserBean userBean;
    
    @EJB
    private ValidationBean validationBean;
    
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        User user = userBean.getCurrentUser();
        
        HttpSession session = request.getSession();
        
        session.setAttribute("user_name", user.getUsername());
        session.setAttribute("vnnn", user.getName());
        session.setAttribute("strhn", user.getAnschrift());
        session.setAttribute("plz", user.getPlz());
        session.setAttribute("ort", user.getOrt());
        session.setAttribute("email", user.getEmail());
        session.setAttribute("tel", user.getTelefon());
        
        
        request.getRequestDispatcher("/WEB-INF/app/editUser.jsp").forward(request, response);

    }
    
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Formulareingaben auslesen
        request.setCharacterEncoding("utf-8");
        
        String username = request.getParameter("signup_username");
        String password = request.getParameter("signup_password");
        String password1 = request.getParameter("signup_password1");
        String password2 = request.getParameter("signup_password2");
        
        String name = request.getParameter("signup_vnnn");
        String anschrift = request.getParameter("signup_str_hn");
        String plz = request.getParameter("signup_plz");
        String ort = request.getParameter("singup_ort");
        String email = request.getParameter("signup_email");
        String telefon = request.getParameter("signup_telefon");
        
        // Eingaben prüfen
        User user = new User(username, password);
        user.setAnschrift(anschrift);
        user.setEmail(email);
        user.setName(name);
        user.setPlz(plz);
        user.setTelefon(telefon);
        user.setOrt(ort);
        List<String> errors = this.validationBean.validate(user);
        this.validationBean.validate(user.getPassword(), errors);
        
        if (password1 != null && password2 != null && !password1.equals(password2)) {
            errors.add("Die beiden Passwörter stimmen nicht überein.");
        }
        
        System.out.println(user.getPassword().password);
        System.out.println(password);
        
        if(!password.equals(user.getPassword().password)) {
            errors.add("Altes Passwort ungültig");
        }
        
        // Neuen Benutzer anlegen
        if (errors.isEmpty()) {
            this.userBean.update(user);
        }
        
        // Weiter zur nächsten Seite
        if (errors.isEmpty()) {
            // Keine Fehler: Startseite aufrufen
            //request.login(username, password1);
            response.sendRedirect(WebUtils.appUrl(request, "/app/tasks/"));
        } else {
            // Fehler: Formuler erneut anzeigen
            FormValues formValues = new FormValues();
            formValues.setErrors(errors);
            
            HttpSession session = request.getSession();
            
            session.setAttribute("user_name", user.getUsername());
            session.setAttribute("vnnn", user.getName());
            session.setAttribute("strhn", user.getAnschrift());
            session.setAttribute("plz", user.getPlz());
            session.setAttribute("ort", user.getOrt());
            session.setAttribute("email", user.getEmail());
            session.setAttribute("tel", user.getTelefon());
            
            session.setAttribute("signup_form", formValues);
            
            response.sendRedirect(request.getRequestURI());
        }
    }
    
}
