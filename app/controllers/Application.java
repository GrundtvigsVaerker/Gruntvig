package controllers;

import models.Asset;
import play.mvc.*;

public class Application extends Controller {


    public static void index() {
        render();
    }

    public static void tidslinje() {
        render();
    }

    public static void kort() {
        Asset asset = Asset.find("fileName = :file").setParameter("file", "map_vej.xml").first();
        render(asset);
    }

    public static void viskort(String fileName) {
        Asset asset = Asset.find("fileName = :file").setParameter("file", fileName).first();
        render(asset);
    }

    public static void krono() {
        addAssetToTemplate();
        render();
    }

    public static void alfa() {
        addAssetToTemplate();
        render();
    }

    public static void genre() {
        addAssetToTemplate();
        render();
    }

    public static void salmer() {
        addAssetToTemplate();
        render();
    }


    // eksempel på en register/leksikon side
    public static void register_side() {
        render();
    }

    static void addAssetToTemplate() {
        renderArgs.put("rootAssets", Asset.find("type = :type order by name").setParameter("type", "root").fetch());
        /*
        try {
            List<Asset> sillySortedAssets = Asset.find("type = :type order by name").setParameter("type", "root").fetch();
            Collections.sort(sillySortedAssets, new SillyComparator());
            renderArgs.put("sortedAssets", sillySortedAssets);
        } catch (Exception e) {
            renderArgs.put("sortedAssets", Asset.find("type = :type order by name").setParameter("type", "root").fetch());
            System.out.println("Probably empty db or filenames without year, assets not sorted");
        }*/
    }

        /*
        private static String getYearFromFileName(String fileName) {
        String[] S = fileName.split("_");
        String year = S[0],
                sj = S[1],
                litra = "",
                res;
        if (sj.matches("[0-9]*[^0-9]+")) {
            litra = sj.substring(sj.length() - 1);
            sj = sj.substring(0, sj.length() - 1);
        }
        res = String.format("%4s%4s%s", year, sj, litra);
        //System.out.println( ">"+res );
        return res;
    }
    */

    /**
     * Sort txt-files in menu by order of year in filename :-)
     */
   /* private static class SillyComparator implements Comparator<Asset> {

        public int compare(Asset t, Asset t1) {
            return getYearFromFileName(t.fileName).compareTo(getYearFromFileName(t1.fileName));
        }
    }*/
}
