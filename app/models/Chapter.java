/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import controllers.DoSearch;
import helpers.Helpers;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.io.StringWriter;
import javax.persistence.*;
import javax.persistence.Entity;
import play.db.jpa.GenericModel;
import play.data.validation.Required;
import org.w3c.dom.*;
import javax.xml.xpath.*;
import javax.xml.parsers.*;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import play.db.jpa.JPABase;
import play.modules.search.Field;
import play.modules.search.Indexed;

/**
 *
 * @author pe
 */
@Indexed
@Entity
public class Chapter extends GenericModel {

    @Id
    @SequenceGenerator(name = "chapter_id_seq_gen", sequenceName = "chapter_id_seq")
    @GeneratedValue(generator = "chapter_id_seq_gen")
    public long id;
    @Lob
    public String name;
    @Lob
    public String html;
    @Field
    @Lob
    public String htmlAsText;
    @Required
    @ManyToOne
    public Asset asset;
    public int num;

    public Chapter(String name, int num, Asset asset, String html) {
        this.name = name;
        this.num = num;
        this.asset = asset;
        this.html = html;
    }


    @Override
    public <T extends JPABase> T save() {
        this.htmlAsText = Helpers.stripHtml(html);
        // remove empty div's
        html = html.replaceAll("<div class='[^']+'/>", "").replaceAll("<div class=\"[^\"]+\"/>", "");
        return super.save();
    }

    public String getTeaser(String lookfor) {
        return DoSearch.createTeaser(htmlAsText, lookfor);
    }


    private static void deleteOldChapters(Asset asset) {
        // System.out.println("**** Chapters on this asset: " + TextReference.find("asset", asset).fetch().size());
        for (Object o : Chapter.all().fetch()) {
            Chapter c = (Chapter) o;
            System.out.println("Chapter id: " + c.asset);
        }
        Query query = TextReference.em().createQuery("delete from Chapter c where c.asset = :asset");
        query.setParameter("asset", asset);
        int deleted = query.executeUpdate();
        System.out.println("Deleted " + deleted + " old chapters");
        System.out.println("Asset id: " + asset.id);
    }

    private static String nodeToString(Node node) {
        StringWriter sw = new StringWriter();
        try {
            Transformer t = TransformerFactory.newInstance().newTransformer();
            t.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "yes");
            t.transform(new DOMSource(node), new StreamResult(sw));
        } catch (TransformerException te) {
            System.out.println("nodeToString Transformer Exception");
        }
        return sw.toString();
    }

    /*
     * Divide a xml-file into chapters, chapters are divided by div-tags, attribute name is name of chapter
     */
    public static void createChaptersFromAsset(Asset asset) {
        System.out.println("Creating chapters from asset: " + asset.fileName + " , id: " + asset.id);
        deleteOldChapters(asset);
        try {
            DocumentBuilderFactory domFactory = DocumentBuilderFactory.newInstance();
            domFactory.setNamespaceAware(true);
            DocumentBuilder builder = domFactory.newDocumentBuilder();
            InputStream in = new ByteArrayInputStream(asset.html.getBytes("UTF-8"));
            Document doc = builder.parse(in);

            XPath xpath = XPathFactory.newInstance().newXPath();
            XPathExpression expr = xpath.compile("//div[@class='chapter']|//div[@class='kolofonBlad']|//div[@class='titlePage']");

            Object result = expr.evaluate(doc, XPathConstants.NODESET);
            NodeList nodes = (NodeList) result;
            System.out.println("Number of chapters: " + nodes.getLength());
            // System.out.println("Txt-content: " + asset.html);
            if (nodes.getLength() > 0) {
                // System.out.println("xhtml: " + asset.html);
                for (int i = 0; i < nodes.getLength(); i++) {
                    Node node = nodes.item(i);
                    String name = "- Afsnit - " + (i + 1);
                    if (node.getAttributes().getNamedItem("name") != null) {
                        name = node.getAttributes().getNamedItem("name").getNodeValue();
                        System.out.println("Chapter id found: " + name);
                    }
                    Chapter chapter = new Chapter(name, i, asset, nodeToString(node));
                    chapter.save();
                }
            } else {
                System.out.println("No chapters found, using hole file as chapter 1");
                Chapter chapter = new Chapter("Afsnit 1", 0, asset, nodeToString(doc.getDocumentElement()));
                chapter.save();
            }
            System.out.println("Total chapters: " + Chapter.count());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
