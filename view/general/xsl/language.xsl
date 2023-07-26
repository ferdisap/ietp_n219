<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="language">
    <xsl:value-of select="@languageIsoCode"/>
    <xsl:value-of select="@countryIsoCode"/>
  </xsl:template>

</xsl:stylesheet>