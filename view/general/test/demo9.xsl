<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:str="http://exslt.org/str" extension-element-prefixes="str">

<!-- need bootstrap css-->
<!-- need crew.css -->
  <xsl:template match="content">
    <div class="content">
      <!-- <link rel="stylesheet" href="/?utility=getfile&#38;ct=css&#38;path=assets/general/css/crew.css"/> -->
      <link rel="stylesheet" href="/ietp_n219/assets/general/css/crew.css"/>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="crew">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="crewDrill">
    <!-- sepertinya child element title harus dilarang didalam crewDrill dan crewDrillStep / subCrewDrill -->
    <xsl:apply-templates select="*[name() != 'title']"/>
  </xsl:template>

  <xsl:template match="subCrewDrill">
    <xsl:apply-templates select="title">
      <xsl:with-param name="headingType" select="'h6'"/>
    </xsl:apply-templates>
    <xsl:apply-templates select="*[name() != 'title']"/>
    
  </xsl:template>

  <xsl:template match="crewDrillStep">
    <xsl:variable name="orderedStepsFlag" select="ancestor::*[@orderedStepsFlag][1]/@orderedStepsFlag"/>
    
    <div class="d-flex " style="padding-left:1rem;width:calc(100% - 1rem)">
      <xsl:if test="$orderedStepsFlag = 1">
          <xsl:number/>.&#160;
        </xsl:if>
      <div style="width:inherit">
        <xsl:attribute name="class">
          <xsl:value-of select="'d-flex flex-column '"/>
        </xsl:attribute>  
        <xsl:apply-templates/>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="challengeAndResponse">
    <xsl:variable name="separatorStyle">
      <xsl:choose>
        <xsl:when test="ancestor::*[@separatorStyle][1]/@separatorStyle">
          <xsl:value-of select="ancestor::*[@separatorStyle][1]/@separatorStyle"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="'dot'"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <div style="width:inherit">
      <xsl:attribute name="class">
        <xsl:value-of select="'d-flex '"/>
        <xsl:if test="../@memorizeStepsFlag = 1">
          <xsl:value-of select="'fw-bold '"/>
        </xsl:if>
        <xsl:if test="$separatorStyle = 'dot' or $separatorStyle = 'none'">
          <xsl:value-of select="'justify-content-between '"/>
        </xsl:if>
      </xsl:attribute>

      <xsl:apply-templates select="challenge"/>
      <xsl:choose>
        <xsl:when test="$separatorStyle = 'line'"><span class="drillStepSeparatorStyle-line">&#160;</span></xsl:when>
        <xsl:when test="$separatorStyle = 'dot'"><span class="drillStepSeparatorStyle-dot">&#160;</span></xsl:when>
        <xsl:otherwise>
          <span>&#160;-&#160;</span>
        </xsl:otherwise>
      </xsl:choose>
  
      <div class="d-flex">
        <xsl:apply-templates select="response"/>&#160;
        <xsl:apply-templates select="ancestor-or-self::*/crewMemberGroup"/>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="crewMemberGroup">
    [<xsl:apply-templates select="crewMember"/>]
  </xsl:template>

  <xsl:template match="crewMember">
    <xsl:choose>
      <xsl:when test="@crewMemberType = 'cm01'"><xsl:value-of select="'CM1, CM2'"/></xsl:when>
      <xsl:when test="@crewMemberType = 'cm02'"><xsl:value-of select="'CM1'"/></xsl:when>
      <xsl:when test="@crewMemberType = 'cm03'"><xsl:value-of select="'CM2'"/></xsl:when>
    </xsl:choose>
    <xsl:variable name="position"><xsl:number/></xsl:variable>
    <xsl:if test="../crewMember[$position + 1]"><xsl:value-of select="', '"/></xsl:if>
  </xsl:template>


  <!-- levelled Para dan get position TIDAK bersumber/diperbaiki di sini -->
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
      <xsl:copy-of select="$numberredPar"/><xsl:value-of select="' '"/>
        <xsl:apply-templates select="title">
          <xsl:with-param name="headingType" select="'none'"/>
        </xsl:apply-templates>
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

  <xsl:template match="sequentialList">
    <ol>
      <xsl:apply-templates />
    </ol>         
  </xsl:template>
  
  <xsl:template match="listItem">
    <li>
      <xsl:apply-templates />
    </li>
  </xsl:template>
  
  <xsl:template match="title">
    <xsl:param name="headingType">h1</xsl:param>
    <xsl:element name="{$headingType}">
      <xsl:apply-templates/>
    </xsl:element>
    <!-- <xsl:choose>
      <xsl:when test="$headingType = 'h1'">
        <h1><xsl:apply-templates/></h1>      
      </xsl:when>
      <xsl:when test="$headingType = 'h6'">
        <h6><xsl:apply-templates/></h6>      
      </xsl:when>
      <xsl:otherwise>
        <span><xsl:apply-templates/></span><br/>
      </xsl:otherwise>
    </xsl:choose> -->
  </xsl:template>


</xsl:stylesheet>