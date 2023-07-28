<?xml version = "1.0" encoding = "UTF-8"?>   
<xsl:stylesheet version = "1.0" xmlns:xsl = "http://www.w3.org/1999/XSL/Transform">     
   <xsl:template match = "/">   
       <div><xsl:apply-templates/></div>
   </xsl:template>

   <xsl:template match="brDecisionText">
      <xsl:value-of select="name(parent::*)"/> || foo
      <xsl:apply-templates/>
   </xsl:template>

  <xsl:template match="para">
    <xsl:value-of select="name(parent::*)"/>
    <!-- <xsl:choose>
      <xsl:when test="name(parent::*) = 'listItem'">
        <span>
          <xsl:apply-templates/>
        </span>      
      </xsl:when>
      <xsl:otherwise>
        <p>
          <xsl:apply-templates/>
        </p>
      </xsl:otherwise>
    </xsl:choose>   -->
  </xsl:template> 
  
</xsl:stylesheet>  