<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="externalPubRefIdent.xsl"/>
<xsl:include href="externalPubRefAddressItems.xsl"/>
<xsl:include href="behavior.xsl"/>

  <xsl:template match="externalPubRef">
    <xsl:value-of select="@applicRefId"/>
    <span>
      <xsl:apply-templates/>
    </span>
  </xsl:template>

</xsl:stylesheet>