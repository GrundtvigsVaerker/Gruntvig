/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 *
 * Petter was here
 *
 */

package controllers;

import java.util.List;

import helpers.Helpers;
import models.Asset;
import models.Chapter;
import models.TextReference;
import org.apache.solr.client.solrj.SolrServer;
import play.mvc.Controller;

/**
 *
 *
 *
 * Admin-page to keep track of uploaded files
 * Based on play-crud
 *
 *
 */
public class Admin extends Controller {


    public static void uploadXmlFile() {
        render();
    }

    public static void listXmlFiles() {
        List<Asset> assets = Asset.find("SELECT a FROM Asset a ORDER BY a.name").fetch();
        System.out.println("Assets: " + assets.size());
        render(assets);
    }

    public static void removeXmlFile(long fileId) {
        Asset asset = Asset.findById(fileId);
        Chapter.delete("asset = ?1", asset);
        asset.delete();
        render();
    }

    public static void removeAllData() {
        Chapter.deleteAll();
        TextReference.deleteAll();
        Asset.deleteAll();
        Controller.renderHtml("All data removed");
    }

    public static void indexAll() {
        try {
            SolrServer server = Helpers.getSolrServer();
            server.deleteByQuery("id:*");
            server.commit();

            List<Asset> assets = Asset.findAll();
            for (Asset asset : assets) {
                asset.index();
                System.out.println(asset);
            }

            List<Chapter> chapters = Chapter.findAll();
            for (Chapter chapter : chapters) {
                chapter.index();
                System.out.println(chapter);
            }

            Application.renderText("Solr-data cleared and reindexed: " + server);
        } catch (Exception ex) {
            ex.printStackTrace();
            Application.renderText("Problems with solr, look in log");
        }
    }
}
