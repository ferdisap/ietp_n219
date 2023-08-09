<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:str="http://exslt.org/strings">

  <xsl:template match="/">
    <div>
      <!-- <xsl:apply-templates/> -->
      <!-- <xsl:call-template name="str:split"/> -->
      <xsl:value-of select="translate('2.1.    1', ' ', '')"/>
      
      <!-- <xsl:if test="matches('2.1.1', '.')">
        true
      </xsl:if> -->
    </div>
  </xsl:template>

  <xsl:template match="description">
    <!-- <xsl:param name="tok">
      <xsl:copy-of select="."/>
    </xsl:param> -->

    <!-- <xsl:variable name="doc" select="document($tok)"/> -->
    <!-- <xsl:copy-of select="$tok"/> -->
    <!-- <xsl:copy-of select="$tok"/> -->
    <!-- foo -->
    <!-- <xsl:for-each select="$tok">
      <xsl:value-of select="'foo'"/>
    </xsl:for-each> -->
  </xsl:template>

  <xsl:template name="str:split">
	<xsl:param name="string" select="'2.1. 1'" />
  <xsl:param name="pattern" select="'\s'" />
  <xsl:choose>
    <xsl:when test="not($string)" />
    <xsl:when test="not($pattern)">
      <xsl:call-template name="str:_split-characters">
        <xsl:with-param name="string" select="$string" />
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="str:_split-pattern">
        <xsl:with-param name="string" select="$string" />
        <xsl:with-param name="pattern" select="$pattern" />
      </xsl:call-template>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="str:_split-characters">
  <xsl:param name="string" />
  <xsl:if test="$string">
    <token><xsl:value-of select="substring($string, 1, 1)" /></token>
    <xsl:call-template name="str:_split-characters">
      <xsl:with-param name="string" select="substring($string, 2)" />
    </xsl:call-template>
  </xsl:if>
</xsl:template>

<xsl:template name="str:_split-pattern">
  <xsl:param name="string" />
  <xsl:param name="pattern" />
  <xsl:choose>
    <xsl:when test="contains($string, $pattern)">
      <xsl:if test="not(starts-with($string, $pattern))">
        <token><xsl:value-of select="substring-before($string, $pattern)" /></token>
      </xsl:if>
      <xsl:call-template name="str:_split-pattern">
        <xsl:with-param name="string" select="substring-after($string, $pattern)" />
        <xsl:with-param name="pattern" select="$pattern" />
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <token><xsl:value-of select="$string" /></token>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>
