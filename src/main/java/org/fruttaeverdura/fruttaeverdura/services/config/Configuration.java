package org.fruttaeverdura.fruttaeverdura.services.config;

import java.util.Calendar;
import java.util.logging.Level;

import org.fruttaeverdura.fruttaeverdura.model.dao.DAOFactory;
public class Configuration {
    /* Database Configuration */
    public static final String DAO_IMPL=DAOFactory.SQLSERVERJDBCIMPL;
    public static final String DATABASE_DRIVER="com.microsoft.sqlserver.jdbc.SQLServerDriver";
    public static final String SERVER_TIMEZONE=Calendar.getInstance().getTimeZone().getID();
    public static final String DATABASE_URL="jdbc:sqlserver://DBF&V:1433;databaseName=ecommerce;user=sa;password=Password123!;encrypt=true;trustServerCertificate=true;";

    /* Session Configuration */
    public static final String COOKIE_IMPL=DAOFactory.COOKIEIMPL;

    /* Logger Configuration */
    public static final String GLOBAL_LOGGER_NAME="frutta";
    public static final String GLOBAL_LOGGER_FILE="/Users/francescozanovello/Desktop/FruttaeVerdura/sito_log.0.0.txt";
    public static final Level GLOBAL_LOGGER_LEVEL=Level.ALL;
}
