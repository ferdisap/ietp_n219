<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="security">
    <xsl:message>Need bootstrap.css</xsl:message>
    <xsl:comment>Need bootstrap.css</xsl:comment>
    
    <div id="securityClassification" class="sticky-bottom">
      <xsl:choose>
        <xsl:when test="@securityClassification = '01'">
          <h1>Unclassified</h1>
        </xsl:when>
        <xsl:when test="@securityClassification = '02'">
          <h1>Restricted</h1>
        </xsl:when>
        <xsl:when test="@securityClassification = '03'">
          <h1>Confidential</h1>
        </xsl:when>
        <xsl:when test="@securityClassification = '04'">
          <h1>Secreet</h1>
        </xsl:when>
        <xsl:when test="@securityClassification = '05'">
          <h1>Top Secret</h1>
        </xsl:when>
        <xsl:otherwise>
          <xsl:comment>ERROR: the attribute <xsl:value-of select="@securityClassification"/>&#160; doesn't exist.</xsl:comment>
          <xsl:message>ERROR: the attribute <xsl:value-of select="@securityClassification"/>&#160; doesn't exist.</xsl:message>
        </xsl:otherwise>
      </xsl:choose>
    </div>      
  </xsl:template>

</xsl:stylesheet>