<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="wlcp_characters.xsl"/> 

<!--- Based on jwlee's XSL file -->
<xsl:template match="key_vocabulary | supplementary_vocabulary">
	<p><table>
		<xsl:for-each select="word">
			<tr>

			<td><xsl:for-each select="character"><character><xsl:value-of select="normalize-space(simplified)"/></character></xsl:for-each></td>
			<td><xsl:for-each select="character"><reading><xsl:value-of select="normalize-space(pinyin)"/></reading></xsl:for-each></td>
			<td><annotation><xsl:value-of select="literal"/></annotation></td>
			</tr>
		</xsl:for-each>
	</table></p>
</xsl:template>


<xsl:template match="word">
	<xsl:variable name="number_of_characters" select="count(character)"/>
	<xsl:variable name="word_literal" select="normalize-space(literal)"/>
	
	<word><table>
		<tr><xsl:for-each select="character"><td><reading><xsl:if test="not(contains($characters_to_ignore,normalize-space(simplified)))"><xsl:value-of select="pinyin"/></xsl:if></reading></td></xsl:for-each></tr>
		<tr><xsl:for-each select="character"><td><character><xsl:value-of select="normalize-space(simplified)"/></character></td></xsl:for-each></tr>
		<tr><td colspan="{$number_of_characters}"><annotation><xsl:value-of select="literal"/><xsl:if test="string-length($word_literal)=0"><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text></xsl:if></annotation></td></tr>
	</table></word>
	<xsl:value-of select="normalize-space(punctuation)"/>
</xsl:template>
<!--
	<ruby xml:lang="zh">
		<rbc><xsl:for-each select="character"><rb><character><xsl:value-of select="normalize-space(simplified)"/></character></rb></xsl:for-each></rbc>
		<rtc class="reading"><xsl:for-each select="character"><rb><reading><xsl:if test="not(contains($characters_to_ignore,normalize-space(simplified)))"><xsl:value-of select="pinyin"/></xsl:if></reading></rb></xsl:for-each></rtc>
		<rtc class="annotation"><rt rbspan="{$number_of_characters}" xml:lang="en"><annotation><xsl:value-of select="literal"/></annotation></rt></rtc>
	</ruby>
-->

<xsl:template match="sentence">
	<p>
		<idiomatic><xsl:value-of select="idiomatic"/></idiomatic><br/>
		<xsl:apply-templates select="word"/>
	</p>
</xsl:template>

<xsl:template match="/">
	<xsl:for-each select="lesson">
		<html>
		<head>
			<link rel="stylesheet" type="text/css" href="wlcp.css" /> 
			<title><xsl:value-of select="title_and_level"/></title>
		</head>
		<body>

		<h4><idiomatic><xsl:value-of select="title_and_level"/></idiomatic></h4>

		<xsl:for-each select="key_vocabulary">
			<h5><idiomatic>Key Vocabulary</idiomatic></h5>
			<p><xsl:apply-templates select="."/></p>
		</xsl:for-each>

		<xsl:for-each select="supplementary_vocabulary">
			<h5><idiomatic>Supplementary Vocabulary</idiomatic></h5>
			<p><xsl:apply-templates select="."/></p>
		</xsl:for-each>

		<xsl:for-each select="dialogue_sentences">
			<h5><idiomatic>Dialogue</idiomatic></h5>
			<xsl:apply-templates select="sentence"/>
		</xsl:for-each>

		<xsl:for-each select="expansion_sentences">
			<h5><idiomatic>Expansion</idiomatic></h5>
			<xsl:apply-templates select="sentence"/>
		</xsl:for-each>
		</body>
		</html>
	</xsl:for-each>
</xsl:template>

</xsl:stylesheet>

