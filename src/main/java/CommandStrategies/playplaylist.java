/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package CommandStrategies;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author umur
 */
public class playplaylist extends Players {
    static final String KEY_TYPE_PLAYLIST = "playlist";
    static final int PLAYLIST_DB = 3;

    @Override
    public StringBuilder search( String item, String token) {
        try {
            return handleSearch(item, token, KEY_TYPE_PLAYLIST, PLAYLIST_DB);
        } catch (IOException ex) {
            Logger.getLogger(playplaylist.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    @Override
    public StringBuilder execute( String item, String token) {
        return search(item, token);
    }



}
