<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:str="http://exslt.org/str" extension-element-prefixes="str">
  <!-- need bootstrap css-->
  <!-- need crew.css -->
  <!-- Sudah dicoba di demo9.xml dan demo9.xsl -->
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

</xsl:stylesheet>