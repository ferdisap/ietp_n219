<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:include href="identExtension.xsl"/>
  <xsl:include href="dmCode.xsl"/>
  <xsl:include href="issueInfo.xsl"/>
  <xsl:include href="language.xsl"/>

  <xsl:template match="dmRefIdent">
    <span>
      <xsl:apply-templates/>
    </span>
  </xsl:template>

</xsl:stylesheet>