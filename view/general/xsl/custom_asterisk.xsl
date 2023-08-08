<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template name="asterisk">
    <xsl:param name="pos">1</xsl:param>
    <xsl:for-each select="//para[footnote]/footnote[@footnoteMark = 'sym']">
      <xsl:if test="position()&#60;=$pos">
        <xsl:value-of select="'*'"/>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>