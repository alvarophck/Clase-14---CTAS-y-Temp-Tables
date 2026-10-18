-- Preparación
-- Comprobar el punto de partida de la clase: 43 reproducciones y 10 usuarios.

USE SonoraDB;
GO

SELECT (SELECT COUNT(*) FROM dbo.reproducciones) AS reproducciones,
       (SELECT COUNT(*) FROM dbo.usuarios)       AS usuarios;
