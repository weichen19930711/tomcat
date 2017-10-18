package com.perficient.training.utils;

import java.io.File;

import org.apache.catalina.LifecycleException;
import org.apache.catalina.startup.Tomcat;

public class MainUtils {

    public static final String BASE_DIR = "C:/app/tomcat/apache-tomcat-7.0.70/";

    public static final Integer SERVER_PORT = 8000;

    public static void main(String[] args) {
        Tomcat tomcat = new Tomcat();
        tomcat.setPort(SERVER_PORT);
        File appDir = new File(BASE_DIR, "webapps/examples");
        tomcat.addWebapp(null, "/examples", appDir.getAbsolutePath());
        try {
            tomcat.start();
        } catch (LifecycleException e) {
            e.printStackTrace();
        }
        String res = HttpUtils
            .doGet("http://localhost:" + SERVER_PORT + "/examples/servlets/chat/index.jsp");
        System.out.println(res);

    }

}
