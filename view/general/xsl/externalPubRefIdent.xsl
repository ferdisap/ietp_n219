<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="externalPubCode.xsl"/>
<xsl:include href="externalPubTitle.xsl"/>
<xsl:include href="externalPubIssueInfo.xsl"/>

  <xsl:template match="externalPubRefIdent">
    <xsl:value-of select="@applicRefId"/>
    <span>
      <xsl:apply-templates/>
    </span>
  </xsl:template>

</xsl:stylesheet>