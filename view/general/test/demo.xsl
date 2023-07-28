<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html"/>

 <xsl:template match="/">
    <link rel="stylesheet" href="bootstrap_5.2.0.min.css"/>
    <div>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="verbatimText">
    <xsl:choose>
      <xsl:when test="@verbatimStyle = 'vs12'">
        <code>&#60;<xsl:apply-templates/>&#62;</code>
      </xsl:when>
      <xsl:when test="@verbatimStyle = 'vs13'">
        <code>@<xsl:apply-templates/></code>
      </xsl:when>
      <xsl:when test="@verbatimStyle = 'vs14'">
        <span style="font-size:0.5rem">value</span> <code><xsl:apply-templates/></code>
      </xsl:when>
      <xsl:otherwise>
        <span><xsl:apply-templates/></span>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>