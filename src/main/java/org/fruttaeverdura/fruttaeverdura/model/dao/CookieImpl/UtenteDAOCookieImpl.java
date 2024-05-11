package org.fruttaeverdura.fruttaeverdura.model.dao.CookieImpl;

import org.fruttaeverdura.fruttaeverdura.model.dao.UtenteDAO;
import org.fruttaeverdura.fruttaeverdura.model.mo.Utente;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.util.List;


public class UtenteDAOCookieImpl implements UtenteDAO{
    HttpServletRequest request;
    HttpServletResponse response;

    public UtenteDAOCookieImpl(HttpServletRequest request, HttpServletResponse response) {
        this.request = request;
        this.response = response;
    }

    @Override
    public Utente create(
            Long id_utente,
            String username,
            String email,
            String password,
            String nome,
            String cognome,
            String indirizzo,
            String stato,
            String citta,
            Long cap,
            String admin,
            String blocked,
            String card_n,
            Long cvc,
            String exp_date
            //boolean deleted
    ) {

        Utente loggedUser = new Utente();
        loggedUser.setid_utente(id_utente);
        loggedUser.setNome(nome);
        loggedUser.setCognome(cognome);
        loggedUser.setAdmin(admin);

        Cookie cookie;
        cookie = new Cookie("loggedUser", encode(loggedUser));
        cookie.setPath("/");
        response.addCookie(cookie);

        return loggedUser;

    }

    @Override
    public void update(Utente loggedUser) {

        Cookie cookie;
        cookie = new Cookie("loggedUser", encode(loggedUser));
        cookie.setPath("/");
        response.addCookie(cookie);

    }

    @Override
    public void delete(Utente loggedUser) {

        Cookie cookie;
        cookie = new Cookie("loggedUser", "");
        cookie.setMaxAge(0);
        cookie.setPath("/");
        response.addCookie(cookie);

    }
    @Override
    public Utente findLoggedUser() {

        Cookie[] cookies = request.getCookies();
        Utente loggedUser = null;

        if (cookies != null) {
            for (int i = 0; i < cookies.length && loggedUser == null; i++) {
                if (cookies[i].getName().equals("loggedUser")) {
                    loggedUser = decode(cookies[i].getValue());
                }
            }
        }

        return loggedUser;

    }
    @Override
    public Utente findByUserId(Long user_id) {
        throw new UnsupportedOperationException("Not supported yet.");
    }
    @Override
    public List<Utente> searchByUsername(String username) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public void setAdminStatusOn(Utente user) { throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public void setAdminStatusOff(Utente user) { throw new UnsupportedOperationException("Not supported yet.");
    }
    @Override
    public Utente findByUsername(String username) {
        throw new UnsupportedOperationException("Not supported yet.");
    }
    private String encode(Utente loggedUser) {
        String name = loggedUser.getNome().replace(" ","%fv");  // sostituisco lo spazio con %fv
        String surname = loggedUser.getCognome().replace(" ","%fv");    // sostituisco lo spazio
        String encodedLoggedUser;
        encodedLoggedUser = loggedUser.getid_utente() + "#" + name + "#" + surname + "#" + loggedUser.getAdmin();
        return encodedLoggedUser;
    }
    private Utente decode(String encodedLoggedUser) {

        Utente loggedUser = new Utente();

        String[] values = encodedLoggedUser.split("#");
        String nameD = values[1].replace("%fv", " ");   // riporto ad originale
        String surnameD = values[2].replace("%fv", " ");   // riporto ad originale

        loggedUser.setid_utente(Long.parseLong(values[0]));
        loggedUser.setNome(nameD);
        loggedUser.setCognome(surnameD);
        loggedUser.setAdmin((values[3]));

        return loggedUser;
    }
    @Override
    public List<Utente> findAll() {
        throw new UnsupportedOperationException("Not supported yet.");
    }
    @Override
    public void deleteSpedizione(Utente user) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public void deleteCarta(Utente user) {
        throw new UnsupportedOperationException("Not supported yet.");
    }
}
