<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!-- <xsl:include href="custom_getPosition.xsl"/> -->
  <!-- <xsl:include href="definitionList.xsl"/> -->

  <xsl:template match="content">
    <div class="content">
      <xsl:apply-templates/>
    </div>
  </xsl:template>

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

  <!-- Support saja, jangan di edit di sini -->
  <!-- Support saja, jangan di edit di sini -->
  <!-- Support saja, jangan di edit di sini -->
  <!-- Support saja, jangan di edit di sini -->
  <!-- Support saja, jangan di edit di sini -->
  <!-- Support saja, jangan di edit di sini -->
  <!-- Support saja, jangan di edit di sini -->
  <!-- Support saja, jangan di edit di sini -->
  <!-- Support saja, jangan di edit di sini -->
  <!-- Support saja, jangan di edit di sini -->
  <!-- Support saja, jangan di edit di sini -->
  <xsl:template match="levelledPara">
    <xsl:variable name="numberredPar">
      <xsl:call-template name="checkParent"/>
      <xsl:number/>
    </xsl:variable>
  
    <xsl:variable name="error">
      <xsl:if test="substring($numberredPar,1,1) >= 6">
        <xsl:comment>ERROR: the levelledPara only five levels allowed</xsl:comment>
        <xsl:message>ERROR: the levelledPara only five levels allowed</xsl:message>
      </xsl:if>
    </xsl:variable>
    
    <xsl:variable name="strLength">
      <xsl:value-of select="string-length(translate($numberredPar, '.', ''))"/>
    </xsl:variable>
    <xsl:variable name="h">
      <xsl:choose>
        <xsl:when test="$strLength = 1">h2</xsl:when>
        <xsl:when test="$strLength = 2">h3</xsl:when>
        <xsl:when test="$strLength = 3">h4</xsl:when>
        <xsl:when test="$strLength = 4">h5</xsl:when>
        <xsl:when test="$strLength = 5">h6</xsl:when>
        <xsl:otherwise>p</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
  
    <xsl:element name="{$h}">
      <xsl:copy-of select="$error"/>
      <xsl:copy-of select="$numberredPar"/><xsl:value-of select="' '"/><xsl:apply-templates select="title"/>
    </xsl:element>
    <xsl:apply-templates select="para"/>
    <xsl:apply-templates select="child::*[name() != 'title']"/>
  </xsl:template>

  <xsl:template name="getPosition">
    <xsl:param name="xpath"/>
    <xsl:param name="idCompared"/>
    <xsl:param name="includedParent" select="'no'"/>
    <xsl:param name="parentName" select="'levelledPara'"/>
  
    <xsl:variable name="pos">
      <xsl:for-each select="$xpath">
        <xsl:if test="@id = $idCompared">
          <xsl:if test="$includedParent = 'yes'">
            <xsl:call-template name="checkParent"><xsl:with-param name="parentName" select="$parentName"/></xsl:call-template>
          </xsl:if><xsl:number/>
        </xsl:if>
      </xsl:for-each>
    </xsl:variable>
    
    <xsl:value-of select="$pos"/>
  </xsl:template>
  
  <xsl:template name="checkParent">
    <xsl:param name="parentName" select="'levelledPara'"/>
    <xsl:if test="name(parent::*) = $parentName">
      <xsl:call-template name="getParentPosition">
        <xsl:with-param name="parentName" select="$parentName"/>
      </xsl:call-template><xsl:value-of select="'.'"/>
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
      <xsl:value-of select="'Fig. '"/>
      <xsl:call-template name="getPosition">
        <xsl:with-param name="xpath" select="//figure"/>
        <xsl:with-param name="idCompared" select="@internalRefId"/>
      </xsl:call-template><xsl:text>, </xsl:text><xsl:apply-templates/>
    </xsl:when>
    <xsl:when test="@internalRefTargetType = 'irtt09'">
      <xsl:variable name="internalRefId" select="@internalRefId"/>
      <xsl:value-of select="'Fig. '"/>
      <xsl:call-template name="getPositionGraphic">
        <!-- foreach figure; jika figure "ini" sama dengan figure "compared", maka... -->
        <xsl:with-param name="xpath" select="//graphic/.."/>
        <xsl:with-param name="compared" select="//graphic[@id = $internalRefId]/.."/>
      </xsl:call-template><xsl:text>, </xsl:text><xsl:apply-templates/>

      <!-- dummy -->
      <xsl:value-of select="//graphic[@id = $internalRefId]/../title"/>FXX
      <!-- end of dummy -->
    </xsl:when>
    <xsl:when test="@internalRefTargetType = 'irtt07'">
      <xsl:variable name="refId" select="@internalRefId"/>
      <xsl:value-of select="'Para. '"/>
      <xsl:call-template name="getPosition">
        <xsl:with-param name="xpath" select="//levelledPara"/>
        <xsl:with-param name="idCompared" select="$refId"/>
        <xsl:with-param name="includedParent" select="'yes'"/>
        <xsl:with-param name="parentName" select="'levelledPara'"/>
      </xsl:call-template><xsl:copy>(<xsl:apply-templates/>)</xsl:copy>
    </xsl:when>
  </xsl:choose>
</xsl:template>
<xsl:template name="getPositionGraphic">
  <xsl:param name="xpath"/>
  <xsl:param name="compared"/>
  <xsl:variable name="internalRefId" select="@internalRefId"/>
  <xsl:for-each select="$xpath">
    <xsl:if test=". = $compared">
      <xsl:number/><xsl:text> sheet </xsl:text><xsl:call-template name="getPosition">
        <xsl:with-param name="xpath" select="//graphic"/>
        <xsl:with-param name="idCompared" select="$internalRefId"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:for-each>
</xsl:template>


</xsl:stylesheet>
