/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spotifyspeech;

import CommandStrategies.RunCommand;
import com.mycompany.cache.cachesrc.Cache;
import com.mycompany.cache.cachesrc.LRUCache;
import com.mycompany.googleapi.SpeechConverter;
import static com.mycompany.spotifyspeech.SpotifyServices.cache;
import io.swagger.annotations.Api;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import javax.ws.rs.Consumes;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;

/**
 *
 * @author umur
 */
@Api("Spotify Services")
@Path("SpotifyServices")
public class SpotifyServices {

    public static Cache cache = new LRUCache(2);
    static final String PACKAGE_NAME = "CommandStrategies";

    @POST
    @Produces("application/json")
    @Path("query")
    public String Search(
            @FormParam("token") String token,
            @FormParam("service") String service,
            @FormParam("keyType") String keyType,
            @FormParam("item") String item
    ) throws ClassNotFoundException, InstantiationException, IllegalAccessException {
        return exec(PACKAGE_NAME, service, keyType, item, token).toString();
    }

    @POST
    @Produces("application/json")
    @Consumes(MediaType.APPLICATION_FORM_URLENCODED)
    @Path("query64")
    public String Search64(
            @FormParam("token") String token,
            @FormParam("base64") String base64
    ) throws ClassNotFoundException, InstantiationException, IllegalAccessException, IOException {
        SpeechConverter converter = new SpeechConverter();
        converter.addPhrase("play");
        converter.addPhrase("track");
        converter.addPhrase("artist");
        converter.addPhrase("playlist");
        converter.build("command_and_search", base64);
        
        Map<String, String> cmds = new HashMap<>();
        Map<String, String> keytyps = new HashMap<>();
        cmds.put("play", "play");
        
        keytyps.put("track", "track");
        keytyps.put("artist", "artist");
        keytyps.put("playlist", "playlist");

        Map<String, String> parseResults = converter.parseResult(cmds, keytyps);
        return exec(PACKAGE_NAME, parseResults.get("command"), parseResults.get("keyType"), parseResults.get("item"), token).toString();
    }

    private StringBuilder exec(String packageName, String service, String keyType, String item, String token) throws ClassNotFoundException, InstantiationException, IllegalAccessException {
        String className = packageName + "." + service.toLowerCase() + keyType.toLowerCase();
        Class cls = Class.forName(className);
        RunCommand cmd = (RunCommand) cls.newInstance();
        return cmd.execute(item, token);
    }
}
