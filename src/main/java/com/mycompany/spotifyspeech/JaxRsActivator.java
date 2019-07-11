/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spotifyspeech;

import io.swagger.jaxrs.config.BeanConfig;
import javax.ws.rs.ApplicationPath;
import javax.ws.rs.core.Application;
 
/**
 *
 * @author ferhat
 */
@ApplicationPath("/api")
public class JaxRsActivator extends Application {

    public JaxRsActivator() {
          BeanConfig beanConfig = new BeanConfig();
          beanConfig.setVersion("1.0.0");
          beanConfig.setSchemes(new String[]{"http"});
          beanConfig.setHost("ec2-18-184-251-229.eu-central-1.compute.amazonaws.com:8080");
          beanConfig.setBasePath("/SpotifySpeech-1.0-SNAPSHOT/api");
          beanConfig.setResourcePackage(SpotifyServices.class.getPackage().getName());
          beanConfig.setTitle("Domain services RESTful API");
          beanConfig.setDescription("Powered by: RESTEasy, Swagger and Swagger UI");
          beanConfig.setScan(true);        
    }
}