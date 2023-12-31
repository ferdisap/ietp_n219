<?xml version = "1.0" encoding = "UTF-8"?>   
<xsl:stylesheet version = "1.0" xmlns:xsl = "http://www.w3.org/1999/XSL/Transform">     
   <xsl:template match = "/">   
       <div><xsl:apply-templates select="//dmStatus/security"/></div>
   </xsl:template>

   <xsl:template match="security">
    <xsl:message>Need bootstrap.css</xsl:message>
    <xsl:comment>Need bootstrap.css</xsl:comment>
    <div id="securityClassification" class="sticky-bottom">
      <h1>foo<xsl:value-of select="@securityClassification"/></h1>
    </div>      
  </xsl:template>
  
</xsl:stylesheet>  