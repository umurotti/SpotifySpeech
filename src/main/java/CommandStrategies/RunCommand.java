/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package CommandStrategies;




import static com.mycompany.spotifyspeech.SpotifyServices.cache;
import io.lettuce.core.RedisClient;
import io.lettuce.core.api.StatefulRedisConnection;
import io.lettuce.core.api.sync.RedisCommands;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

/**
 *
 * @author umur
 */
public abstract class RunCommand {
    static final String URL_QUERY = "q=";
    static final String URL_TYPE = "type=";
    static final String URL_MARKET = "market=";
    static final String URL_LIMIT = "limit=";
    static final String URL_OFFSET = "offset=";
    static final String SEARCH_URL = "https://api.spotify.com/v1/search?";

    static final String HEADER_ACCEPT = "application/json";
    static final String HEADER_CONTENT_TYPE = "application/json";
    static final String HEADER_AUTHORIZATION = "Bearer ";

    public abstract StringBuilder execute( String item, String token);

    public boolean searchFirstCache(StringBuilder result, String item) {
        String s = (String) cache.get(item);
        if (cache.get(item) != null) {
            result.append(cache.get(item));
            System.out.println("cache==>" + result.toString());
            return true;
        } else {
            return false;
        }
    }

    public boolean searchRedis(StringBuilder result, int db, String item) {
        RedisClient client = RedisClient.create("redis://redis");
        StatefulRedisConnection<String, String> connection = client.connect();
        RedisCommands<String, String> sync = connection.sync();
        sync.select(db);
        String s = sync.get(item);
        connection.close();
        client.shutdown();
        if (s == null) {
            return false;
        } else {
            cache.put(item, s);
            result.append(s);
            System.out.println("redis==>" + result.toString());
            return true;
        }
    }
    
    public void getSpotSearch(StringBuilder result, String token, String SearchUrl, String item, String keyType, String market, String limit, String offset) throws IOException {
        String url = SEARCH_URL;
        url += URL_QUERY + URLEncoder.encode(item, "UTF-8") + "&";
        url += URL_TYPE + URLEncoder.encode(keyType, "UTF-8") + "&";
        url += URL_MARKET + URLEncoder.encode(market, "UTF-8") + "&";
        url += URL_LIMIT + URLEncoder.encode(limit, "UTF-8") + "&";
        url += URL_OFFSET + URLEncoder.encode(offset, "UTF-8");
        URL spotReq = new URL(url);
        HttpURLConnection conn = (HttpURLConnection) spotReq.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Accept", HEADER_ACCEPT);
        conn.setRequestProperty("Content-Type", HEADER_CONTENT_TYPE);
        conn.setRequestProperty("Authorization", HEADER_AUTHORIZATION + token);

        try (BufferedReader rd = new BufferedReader(new InputStreamReader(conn.getInputStream()))) {
            String line;
            while ((line = rd.readLine()) != null) {
                result.append(line);
            }
            rd.close();
        }
        System.out.println("spot==>" + result.toString());
    }
}
