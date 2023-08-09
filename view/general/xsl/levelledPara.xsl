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
    <xsl:variable name="numberedPar">
      <xsl:call-template name="checkParent"/>
      <xsl:number/>
    </xsl:variable>
  
    <xsl:variable name="error">
      <xsl:if test="substring($numberedPar,1,1) >= 6">
        <xsl:comment>ERROR: the levelledPara only five levels allowed</xsl:comment>
        <xsl:message>ERROR: the levelledPara only five levels allowed</xsl:message>
      </xsl:if>
    </xsl:variable>
    
    <xsl:variable name="strLength">
      <xsl:value-of select="string-length(translate($numberedPar, '.', ''))"/>
    </xsl:variable>
    <xsl:variable name="h">
      <xsl:choose>
        <xsl:when test="$strLength = 1">h2</xsl:when>
        <xsl:when test="$strLength = 2">h3</xsl:when>
        <xsl:when test="$strLength = 3">h4</xsl:when>
        <xsl:when test="$strLength = 4">h5</xsl:when>
        <xsl:when test="$strLength = 5">h6</xsl:when>
        <xsl:otherwise>p</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
  
    <xsl:element name="{$h}">
      <xsl:copy-of select="$error"/>
      <xsl:copy-of select="$numberedPar"/><xsl:value-of select="' '"/><xsl:apply-templates select="title"/>
    </xsl:element>
  </xsl:template>

</xsl:stylesheet>