<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:include href="caption.xsl"/>
  <xsl:include href="captionLine.xsl"/>
  <xsl:include href="captionText.xsl"/>

  <xsl:template match="captionGroup">
    <xsl:message>Need general.css</xsl:message>
    <xsl:comment>Need general.css</xsl:comment>

    <table>
      <xsl:apply-templates/>
    </table>
  </xsl:template>

  <xsl:template match="captionBody">
    <tbody>
      <xsl:apply-templates/>
    </tbody>
  </xsl:template>

  <xsl:template match="captionRow">
    <tr>
      <xsl:apply-templates/>
    </tr>
  </xsl:template>

  <!-- memerlukan xsl:template[@name = 'caption'] -->
  <xsl:template match="captionEntry">
    <xsl:param name="spanname"><xsl:value-of select="@spanname"/></xsl:param>
    <xsl:param name="colname"><xsl:value-of select="@colname"/></xsl:param>

    <td>
      <!-- class -->
      <xsl:attribute name="class">
        <xsl:call-template name="alignCaptionEntry">
          <xsl:with-param name="alignCaptionEntry"><xsl:value-of select="@alignCaptionEntry"/></xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="valign">
          <xsl:with-param name="valign"><xsl:value-of select="@valign"/></xsl:with-param>
        </xsl:call-template>
      </xsl:attribute>

      <!-- style (width) -->
      <xsl:if test="@colname and @colname = ancestor::captionGroup/colspec[@colname = $colname]/@colname">
        <xsl:attribute name="style">width:<xsl:value-of select="ancestor::captionGroup/colspec[@colname = $colname]/@colwidth"/></xsl:attribute>
      </xsl:if>

      <!-- colspan -->
      <!-- Setiap orang yang ingin buat colspan, jangan lupa colname nya juga diinput sesuai namest spanname atau tidak pakai spanname (langsung saja pakai attribute namest dan nameend) -->
      <xsl:choose>
        <!-- pengetesan @colname untuk memastikan user tidak salah taruh spanname di captionEntry -->
        <xsl:when test="@spanname and @colname = ancestor::captionGroup/spanspec[@spanname = $spanname]/@namest">
          <xsl:attribute name="colspan">
            <xsl:call-template name="getColspan">
              <xsl:with-param name="namest" select="ancestor::captionGroup/spanspec[@spanname = $spanname]/@namest"/>
              <xsl:with-param name="nameend" select="ancestor::captionGroup/spanspec[@spanname = $spanname]/@nameend"/>
            </xsl:call-template>
          </xsl:attribute>
        </xsl:when>
        <xsl:when test="@namest and @nameend">            
          <xsl:attribute name="colspan">
            <xsl:call-template name="getColspan">
              <xsl:with-param name="namest" select="@namest"/>
              <xsl:with-param name="nameend" select="@nameend"/>
            </xsl:call-template>
          </xsl:attribute>
        </xsl:when>
      </xsl:choose>
      <!-- end of colspan -->

      <!-- rowspan -->
      <xsl:if test="@morerows">
        <xsl:attribute name="rowspan"><xsl:value-of select="@morerows"/></xsl:attribute>
      </xsl:if>
      <!-- end of rowspan -->
      <xsl:apply-templates/>
    </td>
  </xsl:template>  
  <xsl:template name="alignCaptionEntry">
    <xsl:param name="alignCaptionEntry"></xsl:param>
    <xsl:choose>
      <xsl:when test="$alignCaptionEntry = 'left'">text-start&#32;</xsl:when>
      <xsl:when test="$alignCaptionEntry = 'right'">text-end&#32;</xsl:when>
      <xsl:otherwise>text-center&#32;</xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="valign">
    <xsl:param name="valign"></xsl:param>
    <xsl:choose>
      <xsl:when test="$valign = 'middle'">align-middle&#32;</xsl:when>
      <xsl:when test="$valign = 'bottom'">align-bottom&#32;</xsl:when>
      <xsl:otherwise>align-top&#32;</xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="getColspan">
    <xsl:param name="namest">foo</xsl:param>
    <xsl:param name="nameend">bar</xsl:param>

    <xsl:variable name="namestPos">
      <xsl:for-each select="//captionGroup/colspec">
        <xsl:if test="@colname = $namest">
          <xsl:number/>
        </xsl:if>
      </xsl:for-each>
    </xsl:variable>  
    <xsl:variable name="nameendPos">
      <xsl:for-each select="//captionGroup/colspec">
        <xsl:if test="@colname = $nameend">
          <xsl:number/>
        </xsl:if>
      </xsl:for-each>
    </xsl:variable>

    <xsl:value-of select="number($nameendPos) - number($namestPos) + 1"/>
  </xsl:template>

  <!--  <xsl:template match="caption">
        <xsl:template match="@color">
        sudah dipindah ke caption.xsl -->  
 
 <!--  <xsl:template match="captionLine">
        sudah dipindah ke captionLine.xsl -->

 <!--  <xsl:template match="captionText">
        sudah dipindah ke captionText.xsl -->

  
</xsl:stylesheet>