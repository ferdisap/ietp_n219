<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:include href="captionLine.xsl"/>

  <xsl:template match="caption">
    <span>
      <xsl:attribute name="class">
        d-inline-flex&#32;justify-content-center&#32;align-items-center&#32;<xsl:apply-templates select="@color"/>
      </xsl:attribute>

      <xsl:attribute name="style">
        <xsl:if test="@captionWidth">width:<xsl:value-of select="@captionWidth"/>;</xsl:if>
        <xsl:if test="@captionHeight">height:<xsl:value-of select="@captionHeight"/>;</xsl:if>
      </xsl:attribute>

      <xsl:apply-templates/>
    </span>
  </xsl:template>
  
  <xsl:template match="@color">
    <xsl:choose>
      <xsl:when test=". = 'co00'"></xsl:when>
      <xsl:when test=". = 'co01'">bg-green&#32;</xsl:when>
      <xsl:when test=". = 'co02'">bg-amber&#32;</xsl:when>
      <xsl:when test=". = 'co03'">bg-yellow&#32;</xsl:when>
      <xsl:when test=". = 'co04'">bg-red&#32;</xsl:when>
      <xsl:when test=". = 'co07'">bg-white&#32;</xsl:when>
      <xsl:when test=". = 'co08'">bg-grey&#32;</xsl:when>
      <xsl:when test=". = 'co09'"></xsl:when>
      <xsl:when test=". = 'co10'">bg-black&#32;</xsl:when>
      <xsl:when test=". = 'co61'">bg-yellow-txt-black&#32;</xsl:when>
      <xsl:when test=". = 'co66'">bg-red-txt-black&#32;</xsl:when>
      <xsl:when test=". = 'co67'">bg-red-txt-white&#32;</xsl:when>
      <xsl:when test=". = 'co81'">bg-black-txt-yellow&#32;</xsl:when>
      <xsl:when test=". = 'co82'">bg-black-txt-white&#32;</xsl:when>
      <xsl:when test=". = 'co83'">bg-black-txt-red&#32;</xsl:when>
      <xsl:when test=". = 'co84'">bg-black-txt-green&#32;</xsl:when>
      <xsl:when test=". = 'co84'">bg-black-txt-amber&#32;</xsl:when>
      <xsl:otherwise>
        <xsl:comment>ERROR: the attribute value <xsl:value-of select="."/>&#160; doesn't exist.</xsl:comment>
        <xsl:message>ERROR: the attribute value <xsl:value-of select="."/>&#160; doesn't exist.</xsl:message>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>