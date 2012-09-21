<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:TEI="http://www.tei-c.org/ns/1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0"
    exclude-result-prefixes="#all"
    >

<!-- KSR: 2011.10.21 -->

    <xsl:template match="TEI:TEI">
        
            <div id="theVarList">
                
                <div class="test">
                    <xsl:text>Variantoversigt for</xsl:text>
                </div>
                
                <div class="title">
                    <xsl:if test="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='main']">                    
                    <br/>
                        <i><xsl:apply-templates select="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='main']"/></i>
                    </xsl:if>                    
                    <xsl:if test="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='part']">
                    <br/>
                         <xsl:text>&#x201C;</xsl:text><xsl:apply-templates select="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title[@rend='part']"/><xsl:text>&#x201D;</xsl:text>
                     </xsl:if>
                </div>
                
                <div class="test">
                    <xsl:text>Variantoversigt ved</xsl:text>
                </div>
                
                <div class="philologist">
                    <i>
                        <xsl:for-each select="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:author">
                            <xsl:value-of select="."/>
                            <xsl:if test="following-sibling::TEI:author">
                                <xsl:choose>
                                    <xsl:when test="following-sibling::TEI:author[position()!=last()]">
                                       <xsl:call-template name="delimiterComma"/>
                                   </xsl:when>
                                   <xsl:otherwise>
                                       <xsl:text> og </xsl:text>
                                   </xsl:otherwise>
                               </xsl:choose>
                           </xsl:if>
                       </xsl:for-each>
                    </i>
                </div>
                
                <div class="test">
                    <xsl:text>Variantoversigt redigeret af</xsl:text>
                </div>
                
                <div class="editor">
                    <i>
                        <xsl:for-each select="TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:editor[@role='editor']">
                            <xsl:value-of select="."/>
                            <xsl:if test="following-sibling::TEI:editor[@role='editor']">
                                <xsl:choose>
                                    <xsl:when test="following-sibling::TEI:editor[@role='editor'][position()!=last()]">
                                        <xsl:call-template name="delimiterComma"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:text> og </xsl:text>
                                    </xsl:otherwise>
                                </xsl:choose>
                           </xsl:if>
                       </xsl:for-each>
                    </i>
                </div>
                
                <hr/>
                <xsl:apply-templates select="TEI:text"/>
                
        </div>
        
    </xsl:template>
    
    <xsl:template name="delimiterComma">
        <xsl:if test="following-sibling::TEI:author">
            <xsl:text>, </xsl:text>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="TEI:div[@type='preFace']">
        <div class="preFace">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:p">
        <div class="p">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI:div[@type='varList']">
        <table class="table">
            <xsl:apply-templates/>
        </table>
    </xsl:template>
    
    <xsl:template match="TEI:div[@type='regList']">
        <table class="table">
            <xsl:apply-templates/>
        </table>
    </xsl:template>
    
    <xsl:template match="TEI:table">
        <table>
            <xsl:apply-templates/>
        </table>
    </xsl:template>
    
    <xsl:template match="TEI:row">
        <tr>
            <xsl:apply-templates/>
        </tr>
    </xsl:template>
    
    <xsl:template match="TEI:cell">
        <xsl:choose>
            <xsl:when test="@rows">
                <td rowspan="{@rows}">
                    <xsl:apply-templates/>
                </td>
            </xsl:when>
            <xsl:when test="@cols">
                <td colspan="{@cols}">
                    <xsl:apply-templates/>
                </td>
            </xsl:when>
            <xsl:otherwise>
                <td>
                    <xsl:apply-templates/>
                </td>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI:head">
        <div class="{@rend}">
            <xsl:apply-templates/>
        </div>     
    </xsl:template>
    <!--
    <xsl:template match="TEI:row">
        <tr class="row">
            <xsl:apply-templates/>
        </tr>
    </xsl:template>
    
    <xsl:template match="TEI:cell">
        <td class="simple">
            <a href="{@corresp}" target="_blank" class="reg">
                <xsl:apply-templates/>
            </a>
        </td>
    </xsl:template>
    
    <xsl:template match="TEI:cell[@rend='regList']">
        <td>
            <a> 
                <xsl:attribute name="href">
                    <xsl:value-of select="text()" />
                </xsl:attribute>
                <xsl:apply-templates/>
            </a>
        </td>
    </xsl:template>
    -->
    <xsl:template match="TEI:hi">
        <span class="{@rend}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI:note"/>
    
</xsl:stylesheet>