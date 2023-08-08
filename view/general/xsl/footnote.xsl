<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:include href="para.xsl"/>
  <xsl:include href="custom_asterisk.xsl"/>


  <!-- BERHASIL. Cek di demo8.xsl -->
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

    <!-- tambahkan if untuk yang footnoteMark - 'alpha' -->

    <xsl:if test="footnote[@footnoteMark != 'sym'] and footnote[@footnoteMark != 'alpha']">
      <xsl:for-each select="//footnote[not(@footnoteMark)] | //footnote[@footnoteMark = 'num']">
        <span style="font-size:8pt">
          <xsl:value-of select="position()"/>&#32;<xsl:apply-templates/>
        </span><br/>
      </xsl:for-each>      
    </xsl:if>
  </div>
</xsl:template>

</xsl:stylesheet>