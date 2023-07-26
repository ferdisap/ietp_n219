<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="pubMedia">
    <xsl:value-of select="@pubMediaType"/>
    <xsl:value-of select="@pubMediaCode"/>
    <xsl:value-of select="@volumeNumber"/>
    <xsl:value-of select="@mediaLocation"/>
  </xsl:template>

</xsl:stylesheet>