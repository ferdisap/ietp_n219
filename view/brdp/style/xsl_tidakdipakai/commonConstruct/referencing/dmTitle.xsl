<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:msxsl="urn:schemas-microsoft-com:xslt"
  xmlns:user="http://mycompany.com/mynamespace">
  
  <xsl:include href="dmCode.xsl" />  

  <xsl:template match="dmTitle">

    <!-- <xsl:param name="isShowDmCode" name=""/> -->
    <!-- <xsl:if test="boolean($isShowDmCode)">
      <xsl:value-of select = "$isShowDmCode"/>
    </xsl:if> -->
    
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="techName">
    <span class="dmTitle"><xsl:value-of select="."/></span>
    <xsl:choose>
      <xsl:when test="boolean(following-sibling::infoName)">&#160;<xsl:value-of select="'-'"/>&#160;</xsl:when>
    </xsl:choose>
  </xsl:template>
 
  <xsl:template match="infoName">
    <span class="dmTitle"><xsl:value-of select="."/></span>
  </xsl:template>

  <xsl:template match="infoNameVariant">
    <span class="dmTitle"><xsl:value-of select="."/></span>
  </xsl:template>


</xsl:stylesheet>