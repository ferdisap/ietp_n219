<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:include href="internalRef.xsl"/>
  <xsl:include href="indexFlag.xsl"/>
  <xsl:include href="changeInline.xsl"/>
  <xsl:include href="emphasis.xsl"/>
  <xsl:include href="subScript.xsl"/>
  <xsl:include href="superScript.xsl"/>
  <xsl:include href="dmRef.xsl"/>
  <xsl:include href="pmRef.xsl"/>
  <xsl:include href="externalPubRef.xsl"/>
  <xsl:include href="acronym.xsl"/>
  <xsl:include href="acronymTerm.xsl"/>

  <xsl:template match="captionText">
    <xsl:apply-templates/>
  </xsl:template>

</xsl:stylesheet>
