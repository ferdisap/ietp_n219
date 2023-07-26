<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="behavior">
    <xsl:value-of select="@linkShow"/>
    <xsl:value-of select="@linkActuate"/>
  </xsl:template>

</xsl:stylesheet>