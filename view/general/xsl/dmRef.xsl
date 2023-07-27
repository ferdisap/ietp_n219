<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:include href="dmRefIdent.xsl"/>
  <xsl:include href="dmRefAddressItems.xsl"/>
  <xsl:include href="behavior.xsl"/>

  <xsl:template match="dmRef">
    <xsl:value-of select="@referredFragment"/>
    <span>
      <xsl:apply-templates/>
    </span>
  </xsl:template>

</xsl:stylesheet>