package org.fruttaeverdura.fruttaeverdura.services.logservice;

import org.fruttaeverdura.fruttaeverdura.services.config.Configuration;

import java.io.IOException;
import java.util.logging.*;

public class LogService {
    private static Logger applicationLogger;

    private LogService() {
    }

    public static Logger getApplicationLogger() {

        SimpleFormatter formatterTxt;
        Handler fileHandler;

        try {

            if (applicationLogger == null) {

                applicationLogger = Logger.getLogger(Configuration.GLOBAL_LOGGER_NAME);
                fileHandler = new FileHandler(Configuration.GLOBAL_LOGGER_FILE, true);
                formatterTxt = new SimpleFormatter();
                fileHandler.setFormatter(formatterTxt);
                applicationLogger.addHandler(fileHandler);
                applicationLogger.setLevel(Configuration.GLOBAL_LOGGER_LEVEL);
                applicationLogger.setUseParentHandlers(false);
                applicationLogger.log(Level.CONFIG, "Logger: {0} created.", applicationLogger.getName());

            }

        } catch (IOException e) {
            applicationLogger.log(Level.SEVERE, "Error occured in Logger creation", e);
            throw new RuntimeException(e);
        }
        return applicationLogger;

    }
}
