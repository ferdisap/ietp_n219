<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="externalPubIssueDate">
    <xsl:value-of select="@year"/>-
    <xsl:value-of select="@month"/>-
    <xsl:value-of select="@day"/>
  </xsl:template>

</xsl:stylesheet>