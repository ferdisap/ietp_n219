<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="title.xsl"/>
<xsl:include href="caption.xsl"/>
<xsl:include href="proceduralStepAlts.xsl"/>
<xsl:include href="warning.xsl"/>
<xsl:include href="caution.xsl"/>
<xsl:include href="note.xsl"/>
<!-- <xsl:include href="circuitBreakerDescrGroup.xsl"/> -->
<xsl:include href="para.xsl"/>
<xsl:include href="figure.xsl"/>
<xsl:include href="figureAlts.xsl"/>
<xsl:include href="multimedia.xsl"/>
<xsl:include href="multimediaAlts.xsl"/>
<!-- <xsl:include href="foldout.xsl"/> -->
<xsl:include href="table.xsl"/>

<xsl:include href="custom_getPosition.xsl"/>

<!-- nyontek punya levelledPara -->
<xsl:template match="proceduralStep">
  <xsl:variable name="numberredPar">
    <xsl:call-template name="checkParent"/>
    <xsl:number/>
  </xsl:variable>

  <xsl:variable name="error">
    <xsl:if test="substring($numberredPar,1,1) >= 6">
      <xsl:comment>ERROR: the levelledPara only five levels allowed</xsl:comment>
      <xsl:message>ERROR: the levelledPara only five levels allowed</xsl:message>
    </xsl:if>
  </xsl:variable>

  <xsl:variable name="strLength">
    <xsl:value-of select="string-length(translate($numberredPar, '.', ''))"/>
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

    <xsl:element name="{$h}">
      <xsl:attribute name="class">proceduralStep</xsl:attribute>
      <xsl:copy-of select="$error"/>
      <xsl:copy-of select="$numberredPar"/><xsl:value-of select="' '"/><xsl:apply-templates select="title"/>
    </xsl:element>
    <xsl:apply-templates select="para"/>
  </xsl:variable>
    
</xsl:template>

</xsl:stylesheet>