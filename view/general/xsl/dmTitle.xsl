<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:include href="techName.xsl"/>
  <xsl:include href="infoName.xsl"/>
  <xsl:include href="infoNameVariant.xsl"/>

  <xsl:template match="dmTitle">
    <span>
      <xsl:apply-templates/>
    </span>
  </xsl:template>

</xsl:stylesheet>