<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:include href="dmRefIdent.xsl"/>
  <xsl:include href="dmRefAddressItems.xsl"/>
  <xsl:include href="behavior.xsl"/>

  <xsl:template match="dmRef">
  refer to&#160;<a href="#{@referredFragment}"><xsl:apply-templates/></a>
  </xsl:template>

</xsl:stylesheet>