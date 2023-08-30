<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:include href="definitionList.xsl"/>
  <xsl:include href="custom_getPosition.xsl"/>

  <!-- sudah di tes di demo10.xml demo10.xsl -->
  <xsl:template match="figure">
    <xsl:variable name="figNumber"><xsl:number/></xsl:variable>
    <xsl:variable name="qtyGra">
      <xsl:value-of select="count((graphic))"/>
    </xsl:variable>

    <xsl:for-each select="graphic">
      <xsl:variable name="graNumber"><xsl:number/></xsl:variable>
      <div class="figure-container w-100 mb-3">
        <figure>
          <img src="{@infoEntityIdent}">
            <xsl:attribute name="style">
              <xsl:if test="reproductionWidth">
                width:<xsl:value-of select="@reproductionWidth"/>;
              </xsl:if>
              <xsl:if test="@reproductionHeight">
                height:<xsl:value-of select="@reproductionHeight"/>;
              </xsl:if>
              <xsl:if test="@reproductionScale">
                scale:<xsl:value-of select="@reproductionScale div 100"/>;
              </xsl:if>
            </xsl:attribute>
          </img>
          <br/><span><xsl:value-of select="@infoEntityIdent"/>FOO</span>
          <xsl:choose>
            <xsl:when test="$qtyGra > 1">
              <figCaption>
                Figure&#160;<xsl:value-of select="$figNumber"/>&#160;sheet&#160;<xsl:value-of select="$graNumber"/>&#160;-&#160;<xsl:value-of select="../title"/>
              </figCaption>
            </xsl:when>
            <xsl:otherwise>
              <figCaption>
                Figure&#160;<xsl:value-of select="$figNumber"/>&#160;-&#160;<xsl:value-of select="../title"/>
              </figCaption>
            </xsl:otherwise>
          </xsl:choose>
        </figure>
        <div class="legend-container">
          <xsl:apply-templates select="legend/definitionList"/>
        </div>
      </div>
    </xsl:for-each>
  </xsl:template>


  <!-- <xsl:template match="figure">
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
  </xsl:template> -->

</xsl:stylesheet>