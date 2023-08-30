<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:str="http://exslt.org/str" extension-element-prefixes="str">

<!-- need bootstrap css-->
<!-- need crew.css -->
  <xsl:template match="dmodule">
    <xsl:apply-templates select="content"/>
  </xsl:template>

  <xsl:template match="content">
    <div class="content">
      <link rel="stylesheet" href="/ietp_n219/view/general/css/general.css"/>
      <xsl:apply-templates select="description"/>
      <!-- <xsl:apply-templates select="//warning"/>
      <xsl:apply-templates select="//caution"/>
      <xsl:apply-templates select="//note"/> -->
      
      <!-- <xsl:apply-templates select="//warningsAndCautionsRef"/> -->
    </div>
  </xsl:template>

  <xsl:template name="applicRefId">
    <xsl:param name="applicRefId" select="@applicRefId"/>
    <xsl:param name="applic" select="//applic[@id = $applicRefId]"/>
    <xsl:variable name="text">
      <xsl:if test="$applic/displayText">
        <xsl:apply-templates select="$applic/displayText"/>
      </xsl:if>
      <xsl:if test="$applic/assert | $applic/evaluate | $applic/expression">
        <xsl:apply-templates select="$applic/child::*[name() != 'displayText']"/>
      </xsl:if>
    </xsl:variable>
    <xsl:if test="$text != ''">
      <div><span class="applicRefId">(<xsl:value-of select="$text"/>)</span></div>
    </xsl:if>
 
  </xsl:template> 

  <!-- <xsl:param name="applicCrossRefTable"/> -->
  <xsl:param name="applicCrossRefTable" select="document('/ietp_n219/view/general/test/act.xml')"/>
  <xsl:template match="assert">
    <xsl:variable name="text">
      <xsl:value-of select="."/>
      <xsl:if test="$applicCrossRefTable">
        <xsl:call-template name="applicCrossRefTable">
          <xsl:with-param name="applicPropertyIdent" select="@applicPropertyIdent"/>
          <xsl:with-param name="applicPropertyType" select="@applicPropertyType"/>
          <xsl:with-param name="applicPropertyValues" select="@applicPropertyValues"/>
        </xsl:call-template>
      </xsl:if>
    </xsl:variable>
    <xsl:if test="$text != ''">
      Auto Generated:&#160;<div><xsl:value-of select="$text"/></div>
    </xsl:if>
  </xsl:template>

  <xsl:template name="applicCrossRefTable">
    fooxx
  </xsl:template>

  <xsl:template match="displayText">
    Manual Generated:&#160;<div><xsl:apply-templates/></div>
  </xsl:template>

  <xsl:template match="simplePara">
    <span><xsl:apply-templates/></span><br/>
  </xsl:template>

  <xsl:template match="subScript">
    <sub><xsl:value-of select="."/></sub>
  </xsl:template>

  <xsl:template match="superScript">
    <sup><xsl:value-of select="."/></sup>
  </xsl:template>


  <!-- perubahan levelledPara akan mengupdate demo5.xsl, kemudian mengupdate levelledPara.xsl -->
  <xsl:template match="levelledPara">
    <div class="ms-4">
      <xsl:if test="@id">
        <xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
      </xsl:if>
    
      <xsl:variable name="numberedPar">
        <xsl:call-template name="checkParent"/>
        <xsl:number/>
      </xsl:variable>

      <xsl:variable name="error">
        <xsl:if test="substring($numberedPar,1,1) >= 6">
          <xsl:comment>ERROR: the levelledPara only five levels allowed</xsl:comment>
          <xsl:message>ERROR: the levelledPara only five levels allowed</xsl:message>
        </xsl:if>
      </xsl:variable>
      
      <xsl:variable name="strLength">
        <xsl:value-of select="string-length(translate($numberedPar, '.', ''))"/>
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
        <xsl:copy-of select="$numberedPar"/><xsl:value-of select="' '"/><xsl:apply-templates select="title"/>
      </xsl:element>
      <!-- <xsl:apply-templates select="@applicRefId"/> -->
      <xsl:call-template name="applicRefId"/>
      <xsl:apply-templates select="para"/>
      <xsl:apply-templates select="child::*[name() != 'title']"/>
    </div>
  </xsl:template>

  <!-- TIDAK boleh diubah bagian bawah ini -->
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
</xsl:stylesheet>