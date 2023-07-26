<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="identExtension">
    <xsl:value-of select="@extensionProducer"/>
    <xsl:value-of select="@extensionCode"/>
  </xsl:template>

</xsl:stylesheet>