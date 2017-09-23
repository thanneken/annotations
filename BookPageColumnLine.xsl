<?xml version="1.0" encoding="UTF-8"?>
<!-- <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"> -->
<!-- https://www.w3.org/2007/schema-for-xslt20.xsd -->
<xsl:stylesheet version="2.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:fo="http://www.w3.org/1999/XSL/Format"
   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
   xsi:schemaLocation="http://www.w3.org/1999/XSL/Transform
                       https://www.w3.org/2007/schema-for-xslt20.xsd
                       http://www.w3.org/1999/XSL/Format
                       https://svn.apache.org/repos/asf/xmlgraphics/fop/trunk/fop/src/foschema/fop.xsd">
	<xsl:template match="/">
		<html>
			<head>
				<title><xsl:value-of select="/book/title"/>, <xsl:value-of select="/book/author"/> (<xsl:value-of select="/book/publicationyear"/>)</title>
			</head>
			<body style="margin:20px;">
				<h3><xsl:value-of select="/book/title"/>, <xsl:value-of select="/book/author"/> (<xsl:value-of select="/book/publicationyear"/>)</h3>
				<xsl:if test="/book/printpage">
					<p>
						Print edition page numbers in this document:
						<xsl:for-each select="//printpage">
							<a>
								<xsl:attribute name="href">#<xsl:value-of
									select="@id" /></xsl:attribute>
								<xsl:value-of select="@p1861" />
								<xsl:value-of select="@pagenumber" />
							</a>&#160;</xsl:for-each>
					</p>
				</xsl:if>
				<p>
					Ancient/modern page numbers in this document:
					<xsl:for-each select="//page[@p5c]">
						<a>
							<xsl:attribute name="href">#<xsl:value-of select="@id"/></xsl:attribute>
							<xsl:value-of select="@p5c"/>/<xsl:value-of select="@p19c"/>
						</a>&#160; </xsl:for-each>
				</p>
				<hr/>
				<xsl:apply-templates select="/book/page|/book/printpage"/>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="printpage">
		<h3 style="color:darkblue;margin-bottom:0;clear:left;">
			<xsl:attribute name="id"><xsl:value-of select="@id" /></xsl:attribute>
			Print edition page number
			<xsl:value-of select="@p1861" />
			<xsl:value-of select="@pagenumber" />
		</h3>
		<xsl:apply-templates select="heading" />
		<xsl:apply-templates select="page" />
	</xsl:template>

	<xsl:template match="heading">
		<h3>
			<xsl:value-of select="." />
		</h3>
	</xsl:template>
	<xsl:template match="page[@p19c]">
		<div style="clear:left;">
			<xsl:attribute name="id"><xsl:value-of select="@id" /></xsl:attribute>
			<h3 style="color:darkgreen;margin-bottom:0;">
				Ancient page <xsl:value-of select="@p5c" />
				(=modern page number <xsl:value-of select="@p19c" />)
			</h3>
			<xsl:apply-templates select="column" />
		</div>
	</xsl:template>
	<xsl:template match="column">
		<div style="float:left;">
			<p style="color:darkred;">
				<i>
					col.
					<xsl:value-of select="@value" />
				</i>
			</p>
			<xsl:apply-templates select="line" />
		</div>
	</xsl:template>
	<xsl:template match="line">
		<xsl:choose>
			<xsl:when test="@style='special'">
				<p style="margin-left:0;">
					<xsl:value-of select="." />
				</p>
			</xsl:when>
			<xsl:otherwise>
				<p style="margin-left:10px;">
					<xsl:value-of select="." />
				</p>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="i">
		<i><xsl:value-of select="."/></i>
	</xsl:template>
</xsl:stylesheet>