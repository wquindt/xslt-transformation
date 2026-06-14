<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!--    <xsl:output method="text"/>-->
    <xsl:template match="/">
        <html>
            <body>

                <table border="1">
                    <tr>
                        <th>Titel</th>
                        <th>Format DE</th>
                        <th>Kanaele DE</th>
                        <th>Format EN</th>
                        <th>Kanaele EN</th>
                        <th>Format RU</th>
                        <th>Kanaele RU</th>
                        <th>Path</th>
                    </tr>

                    <!-- nur die Media auswählen, wo Titel vorhanden ist -->
                    <xsl:apply-templates select="/MediaInfo/media[track[@type='General']/Title]"/>

                </table>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="media">
        <tr>
            <!-- Titel -->
            <td>
                <xsl:value-of select="track[@type='General']/Title"/>
            </td>

            <!-- DE -->
            <xsl:choose>
                <xsl:when test="count(track[@type='Audio' and starts-with(Language, 'de')])>1">
                    <td>FEHLER</td>
                    <td>FEHLER</td>
                </xsl:when>
                <xsl:otherwise>
                    <!-- Format DE -->
                    <td>
                        <xsl:apply-templates select="track[@type='Audio' and starts-with(Language, 'de')]"/>
                    </td>
                    <!-- Anzahl Kanäle DE -->
                    <td>
                        <xsl:value-of select="track[@type='Audio' and starts-with(Language, 'de')]/Channels"/>
                    </td>
                </xsl:otherwise>
            </xsl:choose>

            <!-- EN -->
            <xsl:choose>
                <xsl:when test="count(track[@type='Audio' and starts-with(Language, 'en')])>1">
                    <td>FEHLER</td>
                    <td>FEHLER</td>
                </xsl:when>
                <xsl:otherwise>
                    <!-- Format EN -->
                    <td>
                        <xsl:apply-templates select="track[@type='Audio' and starts-with(Language, 'en')]"/>
                    </td>
                    <!-- Anzahl Kanäle EN -->
                    <td>
                        <xsl:value-of select="track[@type='Audio' and starts-with(Language, 'en')]/Channels"/>
                    </td>
                </xsl:otherwise>
            </xsl:choose>

            <!-- RU -->
            <xsl:choose>
                <xsl:when test="count(track[@type='Audio' and starts-with(Language, 'ru')])>1">
                    <td>FEHLER</td>
                    <td>FEHLER</td>
                </xsl:when>
                <xsl:otherwise>
                    <!-- Format RU -->
                    <td>
                        <xsl:apply-templates select="track[@type='Audio' and starts-with(Language, 'ru')]"/>
                    </td>
                    <!-- Anzahl Kanäle RU -->
                    <td>
                        <xsl:value-of select="track[@type='Audio' and starts-with(Language, 'ru')]/Channels"/>
                    </td>
                </xsl:otherwise>
            </xsl:choose>

            <!-- Path -->
            <td>
                <xsl:value-of select="@ref"/>
            </td>
        </tr>
    </xsl:template>

    <!-- Logic for format transformation -->
    <xsl:template match="track">
        <xsl:choose>
            <xsl:when test="Format_Commercial_IfAny">
                <xsl:value-of select="Format_Commercial_IfAny"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="Format"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


</xsl:stylesheet>
