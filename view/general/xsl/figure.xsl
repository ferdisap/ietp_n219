<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:include href="custom_getPosition.xsl"/>

  <!-- sudah di tes di demo10.xml demo10.xsl -->
  <xsl:template match="figure">
    <xsl:variable name="figNumber"><xsl:number/></xsl:variable>
    <xsl:for-each select="graphic">
      <xsl:variable name="graNumber"><xsl:number/></xsl:variable>
      <div class="figure-container w-100 mb-3">
        <figure>
          <img src="{@infoEntityIdent}"/>
          <xsl:attribute name="style">
            <xsl:if test="reproductionWidth">
              width:<xsl:value-of select="@reproductionWidth"/>
            </xsl:if>
            <xsl:if test="@reproductionHeight">
              height:<xsl:value-of select="@reproductionHeight"/>
            </xsl:if>
            <xsl:if test="@reproductionScale">
              scale:<xsl:value-of select="@reproductionScale div 100"/>
            </xsl:if>
          </xsl:attribute>
          <figCaption>
            Figure&#160;<xsl:value-of select="$figNumber"/>&#160;sheet&#160;<xsl:value-of select="$graNumber"/>
          </figCaption>
        </figure>
      </div>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>