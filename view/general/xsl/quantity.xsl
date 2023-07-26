<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="quantityGroup.xsl"/>

<xsl:template match="quantity">
  <xsl:value-of select="@quantityType"/>
  <xsl:apply-templates/>
</xsl:template>

</xsl:stylesheet>