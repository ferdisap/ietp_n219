<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="dmCode">
    <xsl:value-of select="@modelIdentCode"/>-<xsl:value-of select="@systemDiffCode"/>-<xsl:value-of select="@systemCode"/>-<xsl:value-of select="@subSystemCode"/>-<xsl:value-of select="@subSubSystemCode"/>-<xsl:value-of select="@assyCode"/>-<xsl:value-of select="@disassyCode"/>-<xsl:value-of select="@disassyCodeVariant"/>-<xsl:value-of select="@infoCode"/>-<xsl:value-of select="@infoCodeVariant"/>-<xsl:value-of select="@itemLocationCode"/>
  </xsl:template>

</xsl:stylesheet>