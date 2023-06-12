<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:msxsl="urn:schemas-microsoft-com:xslt"
  xmlns:user="http://mycompany.com/mynamespace">

  <!-- <xsl:param name="isShowDmCode" select="'no'"/> -->
  <xsl:template match="dmCode">
    <xsl:param name="isShowDmCode"/>
    <xsl:value-of select="$isShowDmCode"/>
    <xsl:choose>
      <xsl:when test="$isShowDmCode = 'yes'">
        <xsl:value-of select="@modelIdentCode"/>-<xsl:value-of select="@systemDiffCode"/>-<xsl:value-of select="@systemCode"/>-<xsl:value-of select="@subSystemCode"/><xsl:value-of select="@subSubSystemCode"/>-<xsl:value-of select="@assyCode"/>-<xsl:value-of select="@disassyCode"/><xsl:value-of select="@disassyCodeVariant"/>-<xsl:value-of select="@infoCode"/><xsl:value-of select="@infoCodeVariant"/>-<xsl:value-of select="@itemLocationCode"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="@systemCode"/>.<xsl:value-of select="@subSubSystemCode"/>.<xsl:value-of select="@assyCode"/>.
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
</xsl:stylesheet>