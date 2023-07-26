<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:include href="captionLine.xsl"/>

  <xsl:template match="caption">
    <xsl:value-of select="@color"/>
    <xsl:value-of select="@systemIdentCode"/>
    <xsl:value-of select="@alignCaption"/>
    <span>
      <xsl:apply-templates/>
    </span>
  </xsl:template>

</xsl:stylesheet>