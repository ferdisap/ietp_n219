<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
<div>
  <xsl:apply-templates/>
</div>
</xsl:template>

<!-- 01. BERHASIL -->
<!-- Bisa generate footnote dan footnoteRef by asterisk dan number -->
<xsl:template match="para">
  <xsl:choose>
    <xsl:when test="name(parent::*) = 'listItem'">
      <span>
        <xsl:apply-templates/>
      </span> 
    </xsl:when>
    <xsl:when test="name(child::*) = 'randomList'">
      <p class="mb-0">
        <xsl:apply-templates/>
      </p>
    </xsl:when>
    <xsl:when test="child::footnote">
      <!-- <xsl:apply-templates select="footnote"/> -->
      <xsl:call-template name="footnote"></xsl:call-template>
    </xsl:when>
    <xsl:when test="parent::footnote">
      <xsl:apply-templates/>
    </xsl:when>
    <xsl:otherwise>
      <p>
        <xsl:apply-templates/>
      </p>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="footnote">
  <div class="footnote-container">
    <xsl:if test="footnote[@footnoteMark = 'sym']">
      <xsl:for-each select="//footnote[@footnoteMark = 'sym']">
        <span style="font-size:8pt">
            <xsl:call-template name="asterisk">
              <xsl:with-param name="pos"><xsl:value-of select="position()"/></xsl:with-param>
            </xsl:call-template>
          &#32;<xsl:apply-templates/>
        </span><br/>
      </xsl:for-each>
    </xsl:if>

    <xsl:if test="footnote[@footnoteMark != 'sym'] and footnote[@footnoteMark != 'alpha']">
      <xsl:for-each select="//footnote[not(@footnoteMark)] | //footnote[@footnoteMark = 'num']">
        <span style="font-size:8pt">
          <xsl:value-of select="position()"/>&#32;<xsl:apply-templates/>
        </span><br/>
      </xsl:for-each>      
    </xsl:if>
  </div>
</xsl:template>

<xsl:template match="footnoteRef">
  <xsl:param name="internalRefId"><xsl:value-of select="@internalRefId"/></xsl:param>
  <xsl:variable name="footnoteMark"><xsl:value-of select="//footnote[@id = $internalRefId]/@footnoteMark"/></xsl:variable>
  <sup>
    <xsl:for-each select="//footnote[@footnoteMark = $footnoteMark]">
      <xsl:if test="@id = $internalRefId">
        <xsl:call-template name="asterisk">
          <xsl:with-param name="pos"><xsl:value-of select="position()"/></xsl:with-param>
        </xsl:call-template>
      </xsl:if>
    </xsl:for-each>
  </sup>
</xsl:template>

<xsl:template name="asterisk">
  <xsl:param name="pos">1</xsl:param>
  <xsl:for-each select="//para[footnote]/footnote[@footnoteMark = 'sym']">
    <xsl:if test="position()&#60;=$pos">
      <xsl:value-of select="'*'"/>
    </xsl:if>
  </xsl:for-each>
</xsl:template>

</xsl:stylesheet>