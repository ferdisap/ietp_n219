<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="verbatimText">
    <xsl:message>Need general.css</xsl:message>
    <xsl:comment>Need general.css</xsl:comment>
    
    <xsl:choose>
      <!-- Filename -->
      <xsl:when test="@verbatimStyle = 'vs02'">
        <span class="font-monospace"><xsl:apply-templates/></span>
      </xsl:when>

      <!-- XML/SGML element name -->
      <xsl:when test="@verbatimStyle = 'vs12'">
        <code class="xml-elementName">&#60;<xsl:apply-templates/>&#62;</code>
      </xsl:when>

      <!-- XML/SGML attribute name -->
      <xsl:when test="@verbatimStyle = 'vs13'">
        <code class="xml-attributeName"><xsl:apply-templates/></code>
      </xsl:when>

      <!-- XML/SGML attribute value -->
      <xsl:when test="@verbatimStyle = 'vs14'">
        <code class="xml-attributeValue"><xsl:apply-templates/></code>
      </xsl:when>

      <!-- class name -->
      <xsl:when test="@verbatimStyle = 'vs28'">
        <span class="fs-05">Class</span> <code><xsl:apply-templates/></code>
      </xsl:when>

      <!-- method name-->
      <xsl:when test="@verbatimStyle = 'vs30'">
        <span class="font-monospace">@</span><code><xsl:apply-templates/></code>
      </xsl:when>

      <!-- ERROR comment/message -->
      <xsl:otherwise>
        <xsl:comment>ERROR: the attribute <xsl:value-of select="@verbatimStyle"/>&#160; doesn't exist.</xsl:comment>
        <xsl:message>ERROR: the attribute <xsl:value-of select="@verbatimStyle"/>&#160; doesn't exist.</xsl:message>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


</xsl:stylesheet>