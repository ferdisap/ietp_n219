<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:include href="levelledParaAlts.xsl"/>
  <xsl:include href="tilte.xsl"/>
  <xsl:include href="captionGroup.xsl"/>
  <xsl:include href="caption.xsl"/>
  <xsl:include href="warning.xsl"/>
  <xsl:include href="caution.xsl"/>
  <xsl:include href="note.xsl"/>
  <!-- <xsl:include href="circuitBreakerDescrGroup.xsl"/> -->
  <xsl:include href="note.xsl"/>
  <xsl:include href="figure.xsl"/>
  <xsl:include href="figureAlts.xsl"/>
  <xsl:include href="multimedia.xsl"/>
  <xsl:include href="multimediaAlts.xsl"/>
  <!-- <xsl:include href="foldout.xsl"/> -->
  <xsl:include href="table.xsl"/>
  <xsl:include href="custom_getPosition.xsl"/>
  
  <!-- BERHASIL, cek di demo5 04. -->
  <xsl:template match="levelledPara">
    <xsl:variable name="titlePar">
      <xsl:call-template name="getPosition">
        <xsl:with-param name="xpath" select="//levelledPara"/>
        <xsl:with-param name="idCompared" select="$refId"/>
        <xsl:with-param name="includedParent" select="'yes'"/>
        <xsl:with-param name="parentName" select="'levelledPara'"/>
      </xsl:call-template>&#160;<xsl:apply-templates select="title"/>
    </xsl:variable>
  
    <xsl:variable name="error">
      <xsl:if test="substring($titlePar,1,1) >= 6">
        <xsl:comment>ERROR: the levelledPara only five levels allowed</xsl:comment>
        <xsl:message>ERROR: the levelledPara only five levels allowed</xsl:message>
      </xsl:if>
    </xsl:variable>
  
    <xsl:variable name="h">
      <xsl:choose>
        <xsl:when test="substring($titlePar,1,1) = 1">h2</xsl:when>
        <xsl:when test="substring($titlePar,1,1) = 2">h3</xsl:when>
        <xsl:when test="substring($titlePar,1,1) = 3">h4</xsl:when>
        <xsl:when test="substring($titlePar,1,1) = 4">h5</xsl:when>
        <xsl:when test="substring($titlePar,1,1) = 5">h6</xsl:when>
        <xsl:otherwise>p</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
  
    <xsl:element name="{$h}">
      <xsl:copy-of select="$error"/>
      <xsl:copy-of select="$titlePar"/>
    </xsl:element>
  </xsl:template>

</xsl:stylesheet>