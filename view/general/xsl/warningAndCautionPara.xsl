<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:include href="attentionRandomList.xsl"/> 
  <xsl:include href="functionalItemRef.xsl"/> 
  <xsl:include href="circuitBreakerRef.xsl"/> 
  <xsl:include href="controlIndicatorRef.xsl"/> 
  <xsl:include href="inlineSignificantData.xsl"/> 
  <xsl:include href="quantity.xsl"/> 
  <xsl:include href="zoneRef.xsl"/> 
  <xsl:include href="accessPointRef.xsl"/> 
  <xsl:include href="identNumber.xsl"/> 
  <xsl:include href="internalRef.xsl"/> 
  <xsl:include href="changeInline.xsl"/> 
  <xsl:include href="emphasis.xsl"/> 
  <xsl:include href="symbol.xsl"/> 
  <xsl:include href="subScript.xsl"/> 
  <xsl:include href="superScript.xsl"/> 
  <xsl:include href="dmRef.xsl"/> 
  <xsl:include href="pmRef.xsl"/> 
  <xsl:include href="externalPubRef.xsl"/> 
  <xsl:include href="acronym.xsl"/> 
  <xsl:include href="acronymTerm.xsl"/> 
  <xsl:include href="caption.xsl"/> 
  <xsl:include href="verbatimText.xsl"/> 
  <xsl:include href="brDecisionRef.xsl"/> 
  <xsl:include href="brDecisionPointRef.xsl"/> 
  <xsl:include href="sourceDocRef.xsl"/> 

  <!-- cek demo11 -->
  <xsl:template match="notePara">
    <p><xsl:apply-templates/></p>
  </xsl:template>

</xsl:stylesheet>