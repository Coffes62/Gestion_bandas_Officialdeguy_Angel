-- BASE DE DATOS: Sistema de Gestión de Bandas Musicales
--[Ver documentación PDF](https://acrobat.adobe.com/id/urn:aaid:sc:VA6C2:7303dc8f-f7af-45b9-81aa-5faf8df2adb4)

-- TABLA: Integrantes - Almacena información de los músicos (nombre, apellido y DNI único)
CREATE TABLE integrantes (
    id_integrante INT AUTO_INCREMENT PRIMARY KEY NOT NULL UNIQUE -- 'ID único del músico',
    nombres VARCHAR(80) NOT NULL -- 'Nombres completos',
    apellido VARCHAR(100) NOT NULL -- 'Apellido',
    DNI INT UNIQUE -- 'Documento Nacional de Identidad (único)'
) -- 'Registro de todos los integrantes musicales';

-- TABLA: Instrumentos - Catálogo de instrumentos musicales disponibles
CREATE TABLE instrumentos (
    id_instrumento INT AUTO_INCREMENT PRIMARY KEY NOT NULL UNIQUE -- 'ID único del instrumento',
    nombre_instrumento VARCHAR(100) -- 'Nombre del instrumento (ej: Guitarra, Batería)'
) -- 'Instrumentos utilizados por los músicos';

-- TABLA: Bandas - Grupos musicales registrados en el sistema
CREATE TABLE bandas (
    id_bandas INT AUTO_INCREMENT UNIQUE NOT NULL -- 'ID único de la banda',
    nombre_banda VARCHAR(100) NOT NULL -- 'Nombre artístico de la banda'
) -- 'Bandas musicales activas';

-- TABLA: Canciones - Repertorio musical (covers y temas originales)
CREATE TABLE canciones (
    id_cancion INT AUTO_INCREMENT NOT NULL UNIQUE PRIMARY KEY -- 'ID único de la canción',
    nombre_cancion VARCHAR(100) NOT NULL -- 'Nombre de la canción + artista (ej: "Bohemian Rhapsody - Queen (cover)")'
) --T 'Canciones disponibles para repertorios';

-- TABLA: Repertorios - Listas de canciones agrupadas por estilo o evento
CREATE TABLE repertorios (
    id_repertorio INT AUTO_INCREMENT NOT NULL UNIQUE PRIMARY KEY --T 'ID único del repertorio',
    nombre_repertorio VARCHAR(50) NOT NULL UNIQUE -- 'Nombre descriptivo (ej: "Clásicos Rock 80s")'
) -- 'Agrupaciones temáticas de canciones';

-- TABLA: integrantes_instrumentos - Relación N:M entre músicos e instrumentos que tocan
CREATE TABLE integrantes_instrumentos (
    id_integrante INT -- 'ID del músico (FK)',
    id_instrumento INT -- 'ID del instrumento (FK)',
    PRIMARY KEY (id_integrante, id_instrumento),
    FOREIGN KEY (id_integrante) REFERENCES integrantes(id_integrante) ON DELETE CASCADE,
    FOREIGN KEY (id_instrumento) REFERENCES instrumentos(id_instrumento) ON DELETE CASCADE
) -- 'Instrumentos que domina cada músico';

-- TABLA: integrantes_bandas - Relación N:M entre músicos y bandas
CREATE TABLE integrantes_bandas (
    id_integrante INT -- 'ID del músico (FK)',
    id_bandas INT -- 'ID de la banda (FK)',
    PRIMARY KEY (id_integrante, id_bandas),
    FOREIGN KEY (id_integrante) REFERENCES integrantes(id_integrante) ON DELETE CASCADE,
    FOREIGN KEY (id_bandas) REFERENCES bandas(id_bandas) ON DELETE CASCADE
) -- 'Bandas a las que pertenece cada músico';

-- TABLA: canciones_repertorio - Relación N:M entre canciones y repertorios
CREATE TABLE canciones_repertorio (
    id_cancion INT -- 'ID de la canción (FK)',
    id_repertorio INT -- 'ID del repertorio (FK)',
    PRIMARY KEY (id_cancion, id_repertorio),
    FOREIGN KEY (id_cancion) REFERENCES canciones(id_cancion) ON DELETE CASCADE,
    FOREIGN KEY (id_repertorio) REFERENCES repertorios(id_repertorio) ON DELETE CASCADE
) -- 'Canciones incluidas en cada repertorio';

-- TABLA: registro_personas - Asistentes a eventos (datos personales)
CREATE TABLE registro_personas (
    id_registre INT PRIMARY KEY AUTO_INCREMENT UNIQUE -- 'ID único del asistente',
    nombre VARCHAR(60) NOT NULL -- 'Nombre completo',
    DNI INT UNIQUE -- 'Documento (único)',
    id_fecha INT -- 'ID de la fecha del evento (FK)'
) -- 'Personas registradas para asistir a eventos';

-- TABLA: fechas - Calendario de eventos/conciertos
CREATE TABLE fechas (
    id_fecha INT PRIMARY KEY AUTO_INCREMENT -- 'ID único del evento',
    fecha_evento DATE NOT NULL -- 'Fecha del concierto (formato YYYY-MM-DD)'
) -- 'Fechas programadas para eventos';

-- TABLA: bandas_repertorio_fechas - Programación de eventos (banda + repertorio + fecha)
CREATE TABLE bandas_repertorio_fechas (
    id_bandas INT -- 'ID de la banda (FK)',
    id_repertorio INT -- 'ID del repertorio (FK)',
    id_fecha INT -- 'ID de la fecha (FK)',
    PRIMARY KEY (id_bandas, id_repertorio, id_fecha),
    FOREIGN KEY (id_bandas) REFERENCES bandas(id_bandas) ON DELETE CASCADE,
    FOREIGN KEY (id_repertorio) REFERENCES repertorios(id_repertorio) ON DELETE CASCADE,
    FOREIGN KEY (id_fecha) REFERENCES fechas(id_fecha) ON DELETE CASCADE
) -- 'Programación completa de eventos';

-- TABLA: registro_personas_fechas - Registro de venta de entradas
CREATE TABLE registro_personas_fechas (
    id_registro INT PRIMARY KEY AUTO_INCREMENT -- 'ID único del registro',
    id_registre INT -- 'ID del asistente (FK)',
    id_fecha INT -- 'ID del evento (FK)',
    precio_entrada INT NOT NULL -- 'Precio en pesos ($)',
    FOREIGN KEY (id_registre) REFERENCES registro_personas(id_registre) ON DELETE CASCADE,
    FOREIGN KEY (id_fecha) REFERENCES fechas(id_fecha) ON DELETE CASCADE
) -- 'Entradas vendidas por evento';
