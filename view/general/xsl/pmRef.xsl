<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:include href="pmRefIdent.xsl"/>
  <xsl:include href="pmRefAddressItems.xsl"/>
  <xsl:include href="behavior.xsl"/>

  <xsl:template match="pmRef">
    Refer to&#160;<a>
      <xsl:attribute name="href">#</xsl:attribute>
      <xsl:apply-templates/>
    </a>
  </xsl:template>

</xsl:stylesheet>