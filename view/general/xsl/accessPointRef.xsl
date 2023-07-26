<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="name.xsl"/>
<xsl:include href="shortName.xsl"/>
<xsl:include href="refs.xsl"/>

  <xsl:template match="accessPointRef">
    <xsl:value-of select="@accessPointNumber"/>
    <xsl:value-of select="@accessPointTypeValue"/>
    <span>
      <xsl:apply-templates/>
    </span>
  </xsl:template>

</xsl:stylesheet>