<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:msxsl="urn:schemas-microsoft-com:xslt"
  xmlns:user="http://mycompany.com/mynamespace">


  <!-- <xsl:param name="isShowDmCode" select="'FOOBAR'"/> -->
  <xsl:template match="dmRef">
    <!-- <xsl:param name="isShowDmCode"/> -->
    <!-- <xsl:value-of select="$isShowDmCode"/> -->
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="dmRefIdent">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="dmRefAddressItems">
    <xsl:apply-templates />
  </xsl:template>  
  
  
  <xsl:include href="dmCode.xsl" />
  <!-- <xsl:include href="dmCode.xsl">
    <xsl:with-param name="isShowDmCode">YES</xsl:with-param>
  </xsl:include> -->
  <xsl:include href="dmTitle.xsl" />

</xsl:stylesheet>