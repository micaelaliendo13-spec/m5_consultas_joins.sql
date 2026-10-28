-- =============================================
-- M5: CONSULTAS CON JOINS
-- Proyecto: RetailPro
-- =============================================


-- =============================================
-- CONSULTA 1: VISTA BASE DEL PROYECTO
-- INNER JOIN
-- =============================================

SELECT
    v.FechaVenta,
    c.ClientesID,
    c.Nombre AS NombreCliente,
    c.Ciudad,
    p.NombreProducto,
    v.Cantidad,
    v.PrecioUnitario,
    v.Cantidad * v.PrecioUnitario AS TotalVenta
FROM Ventas AS v
INNER JOIN Clientes AS c
    ON v.ClientesID = c.ClientesID
INNER JOIN Productos AS p
    ON v.ProductoID = p.ProductoID;


-- =============================================
-- CONSULTA 2: Clientes sin ventas 
-- LEFT JOIN
-- =============================================

SELECT
    c.Nombre,
    c.Email,
    c.FechaRegistro
FROM Clientes AS c
LEFT JOIN Ventas AS v
    ON c.ClientesID = v.ClientesID
WHERE v.VentaID IS NULL;

-- No hay existencia de clientes que no tengan ventas registradas. 

-- =============================================
-- CONSULTA 3:  Productos sin ventas 
-- LEFT JOIN
-- =============================================

SELECT
    p.NombreProducto,
    cat.NombreCategoria,
    p.Precio
FROM Productos AS p
INNER JOIN Categorias AS cat
    ON p.CategoriaID = cat.CategoriasID
LEFT JOIN Ventas AS v
    ON p.ProductoID = v.ProductoID
WHERE v.VentaID IS NULL;

-- No hay registros de productos que no se hayan vendido al menos una vez. 

-- =============================================
-- CONSULTA 4: Consolidado por canal
-- UNION ALL
-- =============================================

SELECT
    canal,
    SUM(total) AS total_canal
FROM (
    SELECT
        VentaID,
        Cantidad * PrecioUnitario AS total,
        'Grupo 1' AS canal
    FROM Ventas
    WHERE VentaID BETWEEN 1 AND 5

    UNION ALL

    SELECT
        VentaID,
        Cantidad * PrecioUnitario AS total,
        'Grupo 2' AS canal
    FROM Ventas
    WHERE VentaID BETWEEN 6 AND 10
) AS consolidado
GROUP BY canal;

-- El grupo 1 registra una mayor facturación que el gurpo 2. 