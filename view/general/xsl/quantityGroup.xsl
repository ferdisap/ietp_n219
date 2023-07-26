<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="quantityValue.xsl"/>
<xsl:include href="quantityTolerance.xsl"/>

<xsl:template match="quantityGroup">
  <xsl:value-of select="@quantityGroupType"/>
  <xsl:value-of select="@quantityUnitOfMeasure"/>
  <xsl:apply-templates/>
</xsl:template>

</xsl:stylesheet>