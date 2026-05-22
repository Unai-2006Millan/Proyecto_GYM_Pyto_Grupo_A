<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">

<html lang="es">

<head>

    <meta charset="UTF-8"/>

    <title>Actividades Fitness Gym</title>

    <style>

        body{
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 30px;
        }

        h1{
            text-align: center;
            color: #ff6600;
            margin-bottom: 30px;
        }

        table{
            width: 100%;
            border-collapse: collapse;
            background: white;
            box-shadow: 0 0 10px rgba(0,0,0,0.2);
        }

        th{
            background-color: #222;
            color: white;
            padding: 15px;
            font-size: 18px;
        }

        td{
            border: 1px solid #ccc;
            padding: 12px;
            text-align: center;
        }

        tr:nth-child(even){
            background-color: #f2f2f2;
        }

        tr:hover{
            background-color: #ddd;
        }

    </style>

</head>

<body>

    <h1>Actividades del Gimnasio</h1>

    <table>

        <tr>
            <th>Actividad</th>
            <th>Entrenador</th>
            <th>Sala</th>
            <th>Fecha Inicio</th>
        </tr>

        <xsl:for-each select="actividades/actividad">

            <xsl:sort select="fecha_inicio"/>

            <tr>

                <td>
                    <xsl:value-of select="nombre_actividad"/>
                </td>

                <td>
                    <xsl:value-of select="nombre_entrenador"/>
                </td>

                <td>
                    <xsl:value-of select="nombre_sala"/>
                </td>

                <td>
                    <xsl:value-of select="fecha_inicio"/>
                </td>

            </tr>

        </xsl:for-each>

    </table>

</body>

</html>

</xsl:template>

</xsl:stylesheet>