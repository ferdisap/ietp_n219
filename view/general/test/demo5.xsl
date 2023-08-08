<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">




<!-- 02. BERHASIL generate Para.2.1.1 otomatis -->
<!-- Bisa juga untuk Figure, tapi kan figure tidak ada levelledFigure, sehingga value $includedParent = 'no' -->
<xsl:variable name="refId">par-005</xsl:variable>
<xsl:template match="/">
  <div><xsl:apply-templates/></div>
</xsl:template>

<xsl:template match="content">
  <!-- 04. BERHASIL, generate judul paragraph otomatis pakai <h2> sampai <h6>, <h1> khusus title data module nanti -->
  <xsl:apply-templates select="//levelledPara"/>

  <!-- BERHASI generate number bullet of paragraphs  -->
  <!-- para.&#160;<xsl:call-template name="getPosition">
    <xsl:with-param name="xpath" select="//levelledPara"/>
    <xsl:with-param name="idCompared" select="$refId"/>
    <xsl:with-param name="includedParent" select="'yes'"/>
    <xsl:with-param name="parentName" select="'levelledPara'"/>
  </xsl:call-template> -->

  <!-- Fig.&#160;<xsl:call-template name="getPosition">
    <xsl:with-param name="xpath" select="//figure"/>
    <xsl:with-param name="idCompared" select="'fig-tes1'"/>
  </xsl:call-template>&#160; -->
  

  <!-- 03. berhasil untuk generate eg. Fig. 2 sheet 1 -->
  <!-- <xsl:call-template name="getPositionGraphic">
    <xsl:with-param name="xpath" select="//graphic[@id = 'gra-002']/.."/>
    <xsl:with-param name="compared" select="//graphic[@id = 'gra-002']/.."/>
  </xsl:call-template> -->
</xsl:template>

<xsl:template match="levelledPara">
  <xsl:variable name="titlePar">
    <xsl:call-template name="getPosition">
      <xsl:with-param name="xpath" select="//levelledPara"/>
      <xsl:with-param name="idCompared" select="$refId"/>
      <xsl:with-param name="includedParent" select="'yes'"/>
      <xsl:with-param name="parentName" select="'levelledPara'"/>
    </xsl:call-template>&#160;<xsl:apply-templates select="title"/>
  </xsl:variable>

  <xsl:variable name="error">
    <xsl:if test="substring($titlePar,1,1) >= 6">
      <xsl:comment>ERROR: the levelledPara only five levels allowed</xsl:comment>
      <xsl:message>ERROR: the levelledPara only five levels allowed</xsl:message>
    </xsl:if>
  </xsl:variable>

  <xsl:variable name="h">
    <xsl:choose>
      <xsl:when test="substring($titlePar,1,1) = 1">h2</xsl:when>
      <xsl:when test="substring($titlePar,1,1) = 2">h3</xsl:when>
      <xsl:when test="substring($titlePar,1,1) = 3">h4</xsl:when>
      <xsl:when test="substring($titlePar,1,1) = 4">h5</xsl:when>
      <xsl:when test="substring($titlePar,1,1) = 5">h6</xsl:when>
      <xsl:otherwise>p</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:element name="{$h}">
    <xsl:copy-of select="$error"/>
    <xsl:copy-of select="$titlePar"/>
  </xsl:element>
</xsl:template>

<xsl:template name="getPositionGraphic">
  <xsl:param name="xpath"/>
  <xsl:param name="compared"/>
  Fig.&#160;<xsl:for-each select="$xpath">
    <xsl:if test=". = $compared">
      <xsl:number/>&#160;sheet&#160;<xsl:call-template name="getPosition">
        <xsl:with-param name="xpath" select="//graphic"/>
        <xsl:with-param name="idCompared" select="'gra-002'"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:for-each>
</xsl:template>

<xsl:template name="getPosition">
  <xsl:param name="xpath"/>
  <xsl:param name="idCompared"/>
  <xsl:param name="includedParent" select="no"/>
  <xsl:param name="parentName" select="'levelledPara'"/>

  <xsl:for-each select="$xpath">
    <xsl:if test="@id = $idCompared">
      <xsl:if test="$includedParent = 'yes'">
        <xsl:call-template name="checkParent"><xsl:with-param name="parentName" select="$parentName"/></xsl:call-template>
      </xsl:if><xsl:number/>
    </xsl:if>
  </xsl:for-each>
</xsl:template>

<xsl:template name="checkParent">
  <xsl:param name="parentName" select="'levelledPara'"/>
  <xsl:if test="name(parent::*) = $parentName">
    <xsl:call-template name="getParentPosition">
      <xsl:with-param name="parentName" select="$parentName"/>
    </xsl:call-template>.
  </xsl:if>
</xsl:template>

<xsl:template name="getParentPosition">
  <xsl:param name="compared" select=".."/>
  <xsl:param name="parentName" select="'levelledPara'"/>
  <xsl:if test="$parentName = 'levelledPara'">
    <xsl:for-each select="../../levelledPara">
      <xsl:if test=". = $compared">
        <xsl:call-template name="checkParent">
          <xsl:with-param name="parentName" select="$parentName"/>
        </xsl:call-template><xsl:number/>
      </xsl:if>
    </xsl:for-each>
  </xsl:if>
</xsl:template>




<!-- 01. GET the position of Figure/ table/ etc -->
<!-- <xsl:template match="/">
  <div><xsl:apply-templates select="//internalRef"/></div>
</xsl:template>

<xsl:template match="internalRef">
  <span>    
    <a>
      <xsl:call-template name="irtt"/>
    </a>
  </span>
</xsl:template>

<xsl:template name="irtt">
  <xsl:choose>
    <xsl:when test="@internalRefTargetType = 'irtt01'">
      Fig. 
      <xsl:call-template name="getPosition">
        <xsl:with-param name="xpath" select="//figure"/>
        <xsl:with-param name="idCompared" select="@internalRefId"/>
      </xsl:call-template>
    </xsl:when>
  </xsl:choose>    
</xsl:template>

<xsl:template name="getPosition">
  <xsl:param name="xpath"/>
  <xsl:param name="idCompared"/>

  <xsl:for-each select="$xpath">
    <xsl:if test="@id = $idCompared">
      <xsl:number/>
    </xsl:if>
  </xsl:for-each>
</xsl:template> -->

</xsl:stylesheet>