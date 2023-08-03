<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:include href="captionLine.xsl"/>

  <xsl:template match="caption">
    <xsl:apply-templates select="@color"/>
    <xsl:value-of select="@systemIdentCode"/>
    <xsl:value-of select="@alignCaption"/>
    <span>
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  
  <xsl:template match="@color">
    <xsl:choose>
      <xsl:when test=". = 'co00'"></xsl:when>
      <xsl:when test=". = 'co01'">green</xsl:when>
      <xsl:when test=". = 'co02'">amber</xsl:when>
      <xsl:when test=". = 'co03'">yellow</xsl:when>
      <xsl:when test=". = 'co04'">red</xsl:when>
      <xsl:when test=". = 'co07'">white</xsl:when>
      <xsl:when test=". = 'co08'">grey</xsl:when>
      <xsl:when test=". = 'co09'"></xsl:when>
      <xsl:when test=". = 'co10'">Black</xsl:when>
      <xsl:otherwise>
        <xsl:comment>ERROR: the attribute value <xsl:value-of select="."/>&#160; doesn't exist.</xsl:comment>
        <xsl:message>ERROR: the attribute value <xsl:value-of select="."/>&#160; doesn't exist.</xsl:message>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>