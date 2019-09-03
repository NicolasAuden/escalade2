package com.nicolas.ocp6.business;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;



public class Utils {

    private static final Logger logger = LogManager.getLogger();


    public static String firstLetterUpperCase(String input) {
        return input.substring(0, 1).toUpperCase() + input.substring(1);
    }

}


