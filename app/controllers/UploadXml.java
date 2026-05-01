/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.io.File;
import java.nio.file.Path;

import helpers.Helpers;
import models.Asset;
import models.TextReference;
import play.mvc.Controller;

/**
 *
 * 
 * Starting point for uploading of xml-files
 * 
 */
public class UploadXml extends Application {

    public static void testXsltTransformation() throws Exception {
        // inline to test xslt of simple file
        // xmlToHtml("/home/pe/gruntvig/xml/1826_433A_1_v1.xml");
        render();
    }

    public static void uploadForm() {
        render();
    }

    /**
     * Handle upload of xml-theFile
     * Check for theFile-type and create assets in database
     * 
     */
    public static void uploadFile(String filesname, String comment, File epub) {
        File theFile = epub;
        System.out.println("Starting upload of: " + filesname);
        Asset asset = null;
        String fileName = theFile.getName();
        if (fileName.equals("domestic.xml") ||
                fileName.equals("international.xml") ||
                fileName.equals("life.xml") ||
                fileName.equals("pub.xml") ||
                fileName.equals("unpub.xml")
                ) {
            Path tidslinjeDir = Helpers.getXmlDataDirPath( "tidslinje");
            Path filePath = tidslinjeDir.resolve(fileName);
            File theDir = tidslinjeDir.toFile();
            if (!theDir.exists()) {
              System.out.println("creating directory: " + tidslinjeDir);
              boolean result = theDir.mkdir();  
              if(result){    
                 System.out.println("DIR created");  
               }
            }
            try {
                helpers.Helpers.copyfile(theFile.getAbsolutePath(), filePath.toString());
            } catch (Exception e) {
                Controller.renderHtml("Something went wrong: " + e.getMessage());
            }
            Controller.renderHtml("Upload of file done: ");
        }
        
        if (fileName.endsWith(".jpg")) {
            if (fileName.contains("_medium") || fileName.contains("_low")) {
                Asset.uploadCountryImage(fileName, comment, theFile);
            } else {
                if (fileName.contains("_fax")) {
                    Asset.uploadFax(filesname, comment, theFile);
                } else {
                    Asset.uploadImgBinary(fileName, comment, theFile);
                }
            }
        } else if (fileName.endsWith(".pdf")) {
            Asset.uploadPdf(fileName, comment, theFile);
        } else if (fileName.endsWith(".html")) {
            Asset.uploadHtml(fileName, comment, theFile);
        } else if (fileName.endsWith(".xml")) {
            asset = Asset.uploadXmlFile(filesname, comment, theFile);
        } else { // everything else is just stored as an image
            Asset.uploadImgBinary(fileName, comment, theFile);
        }
        if (fileName.equals("place.xml")) {
            TextReference.uploadReferenceFilePlace(asset);
        } else if (fileName.equals(("bible.xml"))) {
            TextReference.uploadReferenceFileBible(asset);
        } else if (fileName.equals("myth.xml")
                || fileName.equals("pers.xml")
                || fileName.equals("title.xml")
                ) {
            // System.out.println("--- Upload ref-file: " + asset.fileName);
            TextReference.uploadReferenceFile(asset);
        } else if (fileName.replace(".xml", "").endsWith("_com")) {
            TextReference.uploadComments(asset);
        }       
        
        
        if (asset == null) {
            Controller.renderHtml("Upload of file done: ");
        } else {
            render(asset);
        }
    }
}
