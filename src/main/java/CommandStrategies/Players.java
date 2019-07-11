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
import java.io.IOException;

/**
 *
 * @author umur
 */
public abstract class Players extends RunCommand {

    static final String SEARCH_MARKET = "US";
    static final String SEARCH_LIMIT = "10";
    static final String SEARCH_OFFSET = "0";

    public abstract StringBuilder search( String item, String token);

    public StringBuilder handleSearch(String item, String token, String keyType, int db) throws IOException {
        StringBuilder result = new StringBuilder();
        
        if (searchFirstCache(result, item)) {
            // send song from cache
            result.toString();
            return result;
        }

        if (!searchRedis(result, db, item)) {
            // ask spotify
            getSpotSearch(result, token, SEARCH_URL, item, keyType, SEARCH_MARKET, SEARCH_LIMIT, SEARCH_OFFSET);
            //handle cache
            RedisClient client = RedisClient.create("redis://redis");
            StatefulRedisConnection<String, String> connection = client.connect();
            RedisCommands<String, String> sync = connection.sync();
            sync.select(db);
            sync.set(item, result.toString());
            cache.put(item, result.toString());
            connection.close();
            client.shutdown();
        }
        return result;
    }
}
