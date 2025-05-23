<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE stylesheet [
<!ENTITY month "          januar    februar   marts     april     maj       juni      juli      august    september oktober   november  december">
]>
<xsl:stylesheet 
    xmlns:TEI="http://www.tei-c.org/ns/1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0"
    exclude-result-prefixes="#all"
    >

<!-- 
    Kim Steen Ravn:
    2011.10.12: rend att på title i teiHeader
    2011.06.27: sic and supp in note element 
    2012.06.20: templates til <l> og <lg>
    KK:
    2013-09-26: Midlertidig visning af epitekst
-->
    <xsl:include href="popups.xsl"/>

    <xsl:template match="TEI:TEI">
      <xsl:choose>
       <xsl:when test="//TEI:note[@type='minusCom']">
           <div class="theComments">
               <div class="head about">
                   <div class="minusCom">
                       <xsl:text>GV forsyner ikke dette værk med verbalkommentarer.</xsl:text>
                   </div>
                   
               </div>
           </div>   
       </xsl:when>
       <xsl:otherwise>
        <div class="theComments">
            
            <div class="head about">
                <xsl:if test="//TEI:title[@rend='main' and not(@rendition) and not(@next) and not(@prev)]">
                    <div>
                        <xsl:text>Punktkommentarer til</xsl:text>
                    </div>
                    <!--<i><xsl:apply-templates select="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='main' and not(@type='supp')]"/></i>-->
                    <xsl:call-template name="title"/>
                    <div class="author">
                        <xsl:text>ved </xsl:text>
                        <xsl:for-each select="//TEI:author">
                            <xsl:value-of select="."/>
                            <xsl:if test="following-sibling::TEI:author">
                                <xsl:choose>
                                    <xsl:when test="following-sibling::TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:author[position()!=last()]">
                                        <xsl:text>, </xsl:text>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:text> og </xsl:text>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:if>
                        </xsl:for-each>
                    </div>
                </xsl:if>
                <xsl:if test="//TEI:title[@rend='main' and @rendition='supp']">                        
                    <div>
                        <xsl:text>Punktkommentarer til</xsl:text>
                    </div>
                    <!--&#x201C;<xsl:apply-templates select="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='part' and not(@type='supp')]"/>&#x201D;-->
                    <xsl:call-template name="title"/>
                    <div class="author">
                        <xsl:text>ved </xsl:text>
                        <xsl:for-each select="//TEI:author">
                            <xsl:value-of select="."/>
                            <xsl:if test="following-sibling::TEI:author">
                                <xsl:choose>
                                    <xsl:when test="following-sibling::TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:author[position()!=last()]">
                                        <xsl:text>, </xsl:text>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:text> og </xsl:text>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:if>
                        </xsl:for-each>
                    </div>
                    </xsl:if>
                </div>
                <div class="head about">
                    <xsl:if test="//TEI:title[@rend='main' and not(@rendition) and not(@next) and (@prev='Anmeldelse af' or @prev='Subskriptionsindbydelse til')]">
                        <div><xsl:text>Punktkommentarer til</xsl:text></div>
                        <!--[<i><xsl:apply-templates select="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='main' and @type='supp']"/></i>]-->
                        <xsl:call-template name="title"/>
                        <div class="author">
                            <xsl:text>ved </xsl:text>
                            <xsl:for-each select="//TEI:author">
                                <xsl:value-of select="."/>
                                <xsl:if test="following-sibling::TEI:author">
                                    <xsl:choose>
                                        <xsl:when test="following-sibling::TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:author[position()!=last()]">
                                            <xsl:text>, </xsl:text>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:text> og </xsl:text>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:if>
                            </xsl:for-each>
                        </div>
                    </xsl:if>                    
                    <xsl:if test="//TEI:title[@rend='main' and not(@rendition) and @next and not(@prev)]">
                        <div>
                            <xsl:text>Punktkommentarer til</xsl:text>
                        </div>
                        <!--[&#x201C;<xsl:apply-templates select="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='part' and @type='supp']"/>&#x201D;]-->
                        <xsl:call-template name="title"/>
                        <div class="author">
                            <xsl:text>ved </xsl:text>
                            <xsl:for-each select="//TEI:author">
                                <xsl:value-of select="."/>
                                <xsl:if test="following-sibling::TEI:author">
                                    <xsl:choose>
                                        <xsl:when test="following-sibling::TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:author[position()!=last()]">
                                            <xsl:text>, </xsl:text>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:text> og </xsl:text>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:if>
                            </xsl:for-each>
                        </div>
                    </xsl:if>                    
                    <xsl:if test="//TEI:title[@rend='part' and not(@rendition) and not(@next) and not(@prev)]">
                        <div>
                            <xsl:text>Punktkommentarer til</xsl:text>
                        </div>
                        <!--<i><xsl:apply-templates select="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='main' and not(@type='supp')]"/></i>-->
                        <xsl:call-template name="title"/>
                        <div class="author">
                            <xsl:text>ved </xsl:text>
                            <xsl:for-each select="//TEI:author">
                                <xsl:value-of select="."/>
                                <xsl:if test="following-sibling::TEI:author">
                                    <xsl:choose>
                                        <xsl:when test="following-sibling::TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:author[position()!=last()]">
                                            <xsl:text>, </xsl:text>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:text> og </xsl:text>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:if>
                            </xsl:for-each>
                        </div>
                    </xsl:if>
                    <xsl:if test="//TEI:title[@rend='part' and @rendition='supp']">                        
                        <div>
                            <xsl:text>Punktkommentarer til</xsl:text>
                        </div>
                        <!--&#x201C;<xsl:apply-templates select="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='part' and not(@type='supp')]"/>&#x201D;-->
                        <xsl:call-template name="title"/>
                        <div class="author">
                            <xsl:text>ved </xsl:text>
                            <xsl:for-each select="//TEI:author">
                                <xsl:value-of select="."/>
                                <xsl:if test="following-sibling::TEI:author">
                                    <xsl:choose>
                                        <xsl:when test="following-sibling::TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:author[position()!=last()]">
                                            <xsl:text>, </xsl:text>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:text> og </xsl:text>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:if>
                            </xsl:for-each>
                        </div>
                    </xsl:if>
                </div>
            <div class="head about">
                <xsl:if test="//TEI:title[@rend='part' and not(@rendition) and not(@next) and (@prev='Anmeldelse af' or @prev='Subskriptionsindbydelse til')]">
                    <div><xsl:text>Punktkommentarer til</xsl:text></div>
                    <!--[<i><xsl:apply-templates select="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='main' and @type='supp']"/></i>]-->
                    <xsl:call-template name="title"/>
                    <div class="author">
                        <xsl:text>ved </xsl:text>
                        <xsl:for-each select="//TEI:author">
                            <xsl:value-of select="."/>
                            <xsl:if test="following-sibling::TEI:author">
                                <xsl:choose>
                                    <xsl:when test="following-sibling::TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:author[position()!=last()]">
                                        <xsl:text>, </xsl:text>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:text> og </xsl:text>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:if>
                        </xsl:for-each>
                    </div>
                </xsl:if>                    
                <xsl:if test="//TEI:title[@rend='part' and not(@rendition) and @next and not(@prev)]">
                    <div>
                        <xsl:text>Punktkommentarer til</xsl:text>
                    </div>
                    <!--[&#x201C;<xsl:apply-templates select="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='part' and @type='supp']"/>&#x201D;]-->
                    <xsl:call-template name="title"/>
                    <div class="author">
                        <xsl:text>ved </xsl:text>
                        <xsl:for-each select="//TEI:author">
                            <xsl:value-of select="."/>
                            <xsl:if test="following-sibling::TEI:author">
                                <xsl:choose>
                                    <xsl:when test="following-sibling::TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:author[position()!=last()]">
                                        <xsl:text>, </xsl:text>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:text> og </xsl:text>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:if>
                        </xsl:for-each>
                    </div>
                </xsl:if>
                </div>
                <xsl:choose>
                    <xsl:when test="document(//TEI:note[@type='txt']/@target)//TEI:TEI/TEI:teiHeader/TEI:fileDesc/TEI:notesStmt/TEI:note[@type='noCom']">
                        <div class="head about">
                            <xsl:text>er under udarbejdelse</xsl:text>
                        </div>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates select="TEI:text"/>
                    </xsl:otherwise>
                </xsl:choose>
        </div>
       </xsl:otherwise>
      </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI:num[@rendition='fraction']">
        <num>
            <xsl:variable name="rendValue" select="@rend"/>
            <xsl:variable name="numerator" select="substring-before($rendValue, '-')"/>
            <xsl:variable name="denominator" select="substring-after($rendValue, '-')"/>
            <xsl:value-of select="concat($numerator, '&#x2044;', $denominator)"/>
        </num>
    </xsl:template>
    
    <xsl:template name="title">
        <xsl:choose>
            <xsl:when test="//TEI:titleStmt/TEI:author">
                <xsl:choose>
                    <xsl:when test="//TEI:title[@rend='main' and not(@rendition) and not(@next) and not(@prev)]">
                        <i><xsl:apply-templates select="//TEI:title[@rend='main']"/></i>
                    </xsl:when>
                    <xsl:when test="//TEI:title[@rend='main' and @rendition='supp']">
                        <i>[<xsl:apply-templates select="//TEI:title[@rend='main']"/>]</i>
                    </xsl:when>
                    <xsl:when test="//TEI:title[@rend='main' and not(@rendition) and not(@next) and @prev='Anmeldelse af']">
                        <xsl:text>[Anmeldelse af] </xsl:text><i><xsl:apply-templates select="//TEI:title[@rend='main']"/></i>
                    </xsl:when>
                    <xsl:when test="//TEI:title[@rend='main' and not(@rendition) and not(@next) and @prev='Subskriptionsindbydelse til']">
                        <xsl:text>[Subskriptionsindbydelse til] </xsl:text><i><xsl:apply-templates select="//TEI:title[@rend='main']"/></i>
                    </xsl:when>
                    <xsl:when test="//TEI:title[@rend='main' and not(@rendition) and @next and not(@prev)]">
                        <i><xsl:apply-templates select="//TEI:title[@rend='main']"/></i><xsl:text> [</xsl:text><xsl:value-of select="//TEI:title[@rend='main']/@next"/><xsl:text>]</xsl:text>
                    </xsl:when>
                    
                    <xsl:when test="//TEI:title[@rend='part' and not(@rendition='supp') and not(@next) and not(@prev)]">
                        &#x201C;<xsl:apply-templates select="//TEI:title[@rend='part']"/>&#x201D;
                    </xsl:when>
                    <xsl:when test="//TEI:title[@rend='part' and @rendition='supp']">
                        &#x201C;[<xsl:apply-templates select="//TEI:title[@rend='part']"/>]&#x201D;
                    </xsl:when>
                    <xsl:when test="//TEI:title[@rend='part' and not(@rendition='supp') and not(@next) and @prev='Anmeldelse af']">
                        <xsl:text>&#x201C;[Anmeldelse af] </xsl:text><xsl:apply-templates select="//TEI:title[@rend='part']"/>&#x201D;
                    </xsl:when>
                    <xsl:when test="//TEI:title[@rend='part' and not(@rendition='supp') and not(@next) and @prev='Subskriptionsindbydelse til']">
                        <xsl:text>&#x201C;[Subskriptionsindbydelse til] </xsl:text><xsl:apply-templates select="//TEI:title[@rend='part']"/>&#x201D;
                    </xsl:when>
                    <xsl:when test="//TEI:title[@rend='part' and not(@rendition='supp') and @next and not(@prev)]">
                        &#x201C;<xsl:apply-templates select="//TEI:title[@rend='part']"/><xsl:text> [</xsl:text><xsl:value-of select="//TEI:title[@rend='part']/@next"/><xsl:text>]</xsl:text>&#x201D;
                    </xsl:when>
                </xsl:choose>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <!--
    <xsl:template match="TEI:ref[@select or @target]">
        <span class="web">
            <a href="{@target}" target="_blank">
                <xsl:apply-templates/>
            </a>
        </span>
    </xsl:template>
    --> 
    
    <xsl:template match="TEI:figure">
        <xsl:choose>
            <xsl:when test="@type='shortLine'">
                <div class="head about">
                    <hr align="center" width="8%" margin="2em 0em 0em 2em"/>
                </div>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="stripNull">
        <xsl:param name="n"/>
        <xsl:choose>
            <xsl:when test="starts-with($n,'0')">
                <xsl:call-template name="stripNull">
                    <xsl:with-param name="n" select="substring-after($n,'0')"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$n"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI:pb">
        <xsl:variable name="newTarget">
            <xsl:value-of select="substring-before(@target,'fax')"/>
            <xsl:call-template name="stripNull">
                <xsl:with-param name="n" select="substring-after(@target,'fax')"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="@type='image'">
                <a href="img/{$newTarget}">
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="TEI:ref[@type]">
        <xsl:variable name="newTarget">
            <xsl:value-of select="substring-before(@target,'fax')"/>
            <xsl:call-template name="stripNull">
                <xsl:with-param name="n" select="substring-after(@target,'fax')"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:choose>
            
            <xsl:when test="@type='docIn'">
                <span class="docIn">
                    <xsl:attribute name="name">
                        <xsl:value-of select="replace(base-uri(), '.*?([0-9].*)_com.xml$', 'scrollTarget_$1')" />
                        <xsl:text>_</xsl:text>
                        <xsl:text>com.xml</xsl:text>
                        <xsl:value-of select="@target"/>
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            
            <!--xsl:when test="@type='docIn'">
                <span class="docIn">
                    <a hrel="{@id}" class="docIn txrmenu"/>
                    <a href="{@xml:id}" class="docIn txrmenu">
                        <xsl:apply-templates/>
                     </a>
                </span>
            </xsl:when-->
            
            <xsl:when test="@type='docOut' and starts-with(@target, 'bookInventory1805.xml')">
                <span name="bookinvent" class="docOut">                            
                    <xsl:apply-templates/>         
                </span>
            </xsl:when>
            <xsl:when test="@type='docOut' and starts-with(@target, 'bookInventory1839.xml')">
                <span name="bookinvent" class="docOut">                            
                    <xsl:apply-templates/>         
                </span>
            </xsl:when>
            <xsl:when test="@type='docOut' and contains(@target, 'biblDesc.xml')">
                <a href="biblio/{@target}" onclick="return blank('biblDesc',this.href)">
                    <xsl:apply-templates/>
                </a>
            </xsl:when>              
            <xsl:when test="@type='docOut'">
                <a class="docOut">
                    <xsl:attribute name="name">
                        <xsl:value-of select="@target"/>
                    </xsl:attribute>           
                    <xsl:apply-templates/>         
                </a>
            </xsl:when>
            <xsl:when test="@type='image'">
                <a href="img/{$newTarget}">
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
            <xsl:when test="@type='litListWeb'">
                <a href="{@target}" target="_blank">
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
            <xsl:when test="@type='web'">
                <a href="{@target}" target="_blank">
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
            <xsl:when test="@type='epiText'">
                <a class="pdf"
                    href="img/{@target}"
                    onclick="return blank('epi',this.href)">
                    <xsl:apply-templates/>
                </a>       
            </xsl:when>
        </xsl:choose>   
    </xsl:template>
    
    <xsl:template match="TEI:editor">
        <div>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:l">
        <div>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:lg">
        <div>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:hi">        
        <span class="{@rend}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:title[@rend='part' or @rend='main']/TEI:hi[@rend and @rendition]">
        <span class="{@rendition}Title">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:note[@type='sic']">
        <span class="sic">
            <xsl:apply-templates/>
            <xsl:text>
                [sic]
            </xsl:text>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:note[@type='supp']">
        <span class="supp">
            <xsl:text>[</xsl:text>
            <xsl:apply-templates/>
            <xsl:text>]</xsl:text>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:p">
        <div class="p">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:p[@rend='edit']"/>
    
    <xsl:template match="TEI:note[@type='aboutLit']">
        <div class="aboutLit">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:note[@xml:id]">
        <div class="note" id="{@xml:id}">
            <xsl:apply-templates select="TEI:p[@rend='quote' or @rend='centerQuote' or @rend='firstQuote' or not(@rend)]"/>
            <!--<a href="" class="greenarrow_comments"> →</a>-->
        </div>
    </xsl:template>
   
    <xsl:template match="TEI:note[@xml:id]/TEI:p[@rend='quote' or @rend='centerQuote' or @rend='firstQuote' or not(@rend)]">
       <div class="p">
           <xsl:apply-templates/>
           <xsl:choose>
               <xsl:when test="following-sibling::*[local-name()='note' and @type='readMore' and position()=1]">
                   <span class="app">
                       <!--  onclick="showhide(this,'more{../@xml:id}')" slette af span for at undgå dob.klik på readMore -->
                       <span id="plus{../@xml:id}" class="plus"> Læs mere</span>
                       <div id="more{../@xml:id}" class="appInvisible">
                           <xsl:apply-templates select="following-sibling::TEI:note[@type='readMore']"/>
                       </div>
                   </span>
               </xsl:when>
           </xsl:choose>
       </div>
   </xsl:template>
   
   <xsl:template name="next-lemma-part">
        <xsl:param name="n"/>
        <xsl:param name="node"/>
        <xsl:param name="i"/>
        <xsl:if test="name($node[$i]) != 'seg' or $node[$i]/@type != 'comEnd' or $node[$i]/@n != $n">
            <xsl:if test="not(name($node[$i]))"> <!--text or comment node-->
                <xsl:apply-templates select="$node[$i]" mode="in-lemma"/>
            </xsl:if>
            <xsl:call-template name="next-lemma-part">
                <xsl:with-param name="n" select="$n"/>
                <xsl:with-param name="node" select="$node"/>
                <xsl:with-param name="i" select="$i+1"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="TEI:head">
        <div class="head">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    
    <xsl:template match="TEI:persName">
        <xsl:choose>
            <xsl:when test="//TEI:notesStmt/TEI:note[@type='noPersName']">
                <span>
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <a class="persName" href="ajax/getReference/{@key}" rel="ajax/getReference/{@key}">
                    <xsl:apply-templates/>
                </a>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI:placeName">
        <xsl:choose>
            <xsl:when test="//TEI:notesStmt/TEI:note[@type='noPlaceName']">
                <span>
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <a class="placeName" href="ajax/getReference/{@key}" rel="ajax/getReference/{@key}">
                    <xsl:apply-templates/>
                </a>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI:rs[@type='bible']">
        <span class="bible rs_bible">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <!--xsl:template match="TEI:rs[@type='bible']">
        <xsl:choose>
            <xsl:when test="//TEI:notesStmt/TEI:note[@type='noBible']">
                <span>
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <span class="bible rs_bible">
                    <xsl:apply-templates/>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template-->
    
    <xsl:template match="TEI:rs[@type='myth']">
        <xsl:choose>
            <xsl:when test="//TEI:notesStmt/TEI:note[@type='noMyth']">
                <span>
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <a class="myth rs_myth" href="ajax/getReference/{@key}" rel="ajax/getReference/{@key}">
                    <xsl:apply-templates/>
                </a>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI:rs[@type='title']">
        <span>
            <xsl:apply-templates/>
        </span>
        <!--a class="rs_title" href="ajax/getReference/{@key}" rel="ajax/getReference/{@key}">
            <xsl:apply-templates/>
        </a-->
    </xsl:template>    
    
    <xsl:template match="TEI:div[@type='litList' or @type='webList']">
        <div class="litList">
            <xsl:choose>
                <xsl:when test="@type='litList'">
                    <xsl:apply-templates/>
                </xsl:when>
                <xsl:when test="@type='webList'">
                    <xsl:apply-templates/>
                </xsl:when>
            </xsl:choose>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:list">
        <ul class="ul">
            <xsl:apply-templates/>
        </ul>        
    </xsl:template>
    
    <xsl:template match="TEI:item[not(@n)]">
        <li class="webList">
            <xsl:apply-templates/>
        </li>
    </xsl:template>
    
    <xsl:template match="TEI:list[@type='litList']/TEI:item[not(@n)]">
        <li class="webList">
            <xsl:apply-templates/>
            <xsl:text>.</xsl:text>
        </li>
    </xsl:template>
    
    <xsl:template match="TEI:item[@n]">
        <li class="liOrdered">
            <a href="{@target}" target="_blank">                
                <xsl:apply-templates/>                
            </a>
            <xsl:text> (</xsl:text>
            <xsl:number value="substring(@n, 9,2)" format="1"/>
            <xsl:text>. </xsl:text>
            <xsl:value-of select="substring('&month;',substring(@n,6,2)*10+1,9)"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="substring(@n, 1,4)"/>
            <xsl:text>).</xsl:text>
        </li>
    </xsl:template>
    
    
    <xsl:template name="getFileNameOfXML">      
      <xsl:variable name="tokenized">
          <xsl:value-of select="tokenize(base-uri(), '/')[last()]"/>
      </xsl:variable>
      <xsl:value-of select="$tokenized"/>
    </xsl:template>
    
</xsl:stylesheet>