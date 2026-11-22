-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS jueguicos;
USE jueguicos;

-- Crear la tabla genero
CREATE TABLE IF NOT EXISTS genero (
    id_genero INT AUTO_INCREMENT PRIMARY KEY,
    nombre_genero VARCHAR(50) NOT NULL,
    descripcion TEXT
);

-- Crear la tabla juego
CREATE TABLE IF NOT EXISTS juego (
    id_juego INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    descripcion TEXT,
    id_genero1 INT,
    id_genero2 INT,
    id_secuela INT,
    precio DECIMAL(10, 2),
    fecha_lanzamiento DATE,
    puntuacion INT,
    clasificacion_edad VARCHAR(5),
    FOREIGN KEY (id_genero1) REFERENCES genero(id_genero),
    FOREIGN KEY (id_genero2) REFERENCES genero(id_genero),
    FOREIGN KEY (id_secuela) REFERENCES juego(id_juego)

);

-- Crear tabla plataformas
CREATE TABLE IF NOT EXISTS plataforma (
    id_plataforma INT AUTO_INCREMENT PRIMARY KEY,
    nombre_plataforma VARCHAR(50) NOT NULL,
    fabricante VARCHAR(50),
    fecha_lanzamiento DATE
);

CREATE TABLE IF NOT EXISTS desarrollador (
    id_desarrollador INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único del desarrollador
    nombre VARCHAR(100) NOT NULL, -- Nombre del estudio
    pais_origen VARCHAR(50) NOT NULL, -- País de origen
    continente VARCHAR(50) NOT NULL, -- Continente del estudio
    ceo VARCHAR(100), -- Nombre del CEO del estudio
    numero_trabajadores INT,
    fundacion INT, -- Fecha de fundación del estudio
    sitio_web VARCHAR(200) -- Página web oficial del estudio
);


-- Crear tabla juegos_plataformas (relación muchos a muchos entre juegos y plataformas)
CREATE TABLE IF NOT EXISTS juego_plataforma (
    id_juego INT,
    id_plataforma INT,
    PRIMARY KEY (id_juego, id_plataforma),
    FOREIGN KEY (id_juego) REFERENCES juego(id_juego) ON DELETE CASCADE,
    FOREIGN KEY (id_plataforma) REFERENCES plataforma(id_plataforma) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS juego_desarrollador (
    id_juego INT, -- Identificador del juego
    id_desarrollador INT, -- Identificador del desarrollador
    FOREIGN KEY (id_juego) REFERENCES juego(id_juego) ON DELETE CASCADE,
    FOREIGN KEY (id_desarrollador) REFERENCES desarrollador(id_desarrollador) ON DELETE CASCADE,
    PRIMARY KEY (id_juego, id_desarrollador) -- Clave primaria compuesta para evitar duplicados
);


-- Crear tabla usuario
CREATE TABLE IF NOT EXISTS usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre_usuario VARCHAR(50) NOT NULL,
    email VARCHAR(100),
    pais VARCHAR(50),
    fecha_registro DATE,
    avatar_url VARCHAR(255), -- URL para el avatar del usuario
    telefono VARCHAR(15) -- Opcional para contacto
);

-- Crear tabla de relaciones de amistad
CREATE TABLE IF NOT EXISTS amistad (
    id_amigo1 INT,
    id_amigo2 INT,
    PRIMARY KEY (id_amigo1, id_amigo2),
    FOREIGN KEY (id_amigo1) REFERENCES usuario (id_usuario),
    FOREIGN KEY (id_amigo2) REFERENCES usuario (id_usuario)
);


-- Crear tabla reseña
CREATE TABLE IF NOT EXISTS resena (
    id_resena INT AUTO_INCREMENT PRIMARY KEY,
    id_juego INT,
    id_usuario INT,
    puntuacion INT,
    comentario TEXT,
    fecha DATE,
    FOREIGN KEY (id_juego) REFERENCES juego(id_juego) ON DELETE CASCADE,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE
);

-- Crear tabla compra
CREATE TABLE IF NOT EXISTS compra (
    id_compra INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    id_juego INT,
    fecha_compra DATE,
    metodo_pago VARCHAR(50), -- Método de pago (e.g., tarjeta, PayPal)
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_juego) REFERENCES juego(id_juego) ON DELETE CASCADE
);

CREATE TABLE wishlist (
    id_usuario INT,
    id_juego INT,
    fecha_agregado DATE,
    PRIMARY KEY (id_usuario, id_juego),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_juego) REFERENCES juego(id_juego) ON DELETE CASCADE
);

-- Inserciones para la tabla genero
INSERT INTO genero (nombre_genero, descripcion) VALUES
('Acción', 'Juegos con énfasis en habilidades físicas y reflejos rápidos.'),
('Aventura', 'Explora mundos abiertos y resuelve acertijos.'),
('RPG', 'Personaliza personajes y toma decisiones para progresar en la historia.'),
('Shooter', 'Enfocados en combates con armas, en primera o tercera persona.'),
('Estrategia', 'Planea y toma decisiones para lograr la victoria.'),
('Deportes', 'Simulaciones de deportes reales o fantásticos.'),
('Survival Horror', 'Enfrenta miedos y escasez de recursos para sobrevivir.'),
('Simulación', 'Recrea actividades de la vida real o fantasiosas.'),
('Plataformas', 'Saltos y exploración en niveles desafiantes.'),
('MOBA', 'Batallas estratégicas multijugador por equipos.'),
('Battle Royale', 'Sobrevive en combates masivos hasta ser el último en pie.'),
('Lucha', 'Compite en combates cuerpo a cuerpo contra un oponente.'),
('Carreras', 'Compite en circuitos de alta velocidad.'),
('Sigilo', 'Énfasis en el sigilo para completar misiones.'),
('Metroidvania', 'Explora mapas interconectados con progresión no lineal.'),
('Puzles', 'Resuelve desafíos intelectuales para avanzar.'),
('Roguelike', 'Explora mazmorras con niveles generados proceduralmente.'),
('Party', 'Juegos casuales y multijugador ideales para grupos.'),
('MMORPG', 'Juegos de rol masivos en línea.'),
('Ritmo', 'Sigue el ritmo y sincroniza tus acciones con la música.'),
('Survival', 'Supera desafíos y gestiona recursos para sobrevivir.'),
('Indie', 'Juegos independientes con estilos y mecánicas únicas.'),
('FPS', 'Juegos de disparos en primera persona.'),
('Terror', 'Crea una atmósfera para provocar miedo y tensión.'),
('Cooperativo', 'Diseñados para ser jugados en equipo.'),
('Aventura Gráfica', 'Narración interactiva con resolución de acertijos.'),
('Táctico', 'Estrategia en combates por turnos o en tiempo real.'),
('Exploración', 'Descubre ambientes desconocidos y secretos.'),
('Bullet Hell', 'Enfrenta oleadas de proyectiles en combates frenéticos.'),
('Sandbox', 'Libertad para construir y explorar.'),
('Arcade', 'Juegos rápidos y con mecánicas simples pero adictivas.');

-- Inserciones en la tabla juego
INSERT INTO juego (titulo, descripcion, id_genero1, id_genero2, id_secuela, precio, fecha_lanzamiento, puntuacion, clasificacion_edad) VALUES
('Hollow Knight: Silksong', 'Una secuela al aclamado juego de plataformas y metroidvania.', 15, 9, NULL, NULL, NULL, NULL, NULL),
('Final Fantasy VII Rebirth', 'La esperadísima nueva historia dentro del proyecto del remake de FINAL FANTASY VII.', 3, NULL, NULL, 69.99, '2024-02-29', 92, '+16'),
('Forza Horizon 5', 'Carreras en mundo abierto ambientadas en México.', 13, NULL, NULL, 59.99, '1921-11-09', 92, '+3'),
('The Legend of Zelda: Tears of the Kingdom', 'La secuela de Breath of the Wild con nuevas aventuras en Hyrule.', 2, 1, NULL, 69.99, '2023-05-12', 96, '+12'),
('The Legend of Zelda: Breath of the Wild', 'Explora la vasta tierra de Hyrule.', 2, 1, 4, 60.06, '2017-03-03', 97, '+12'),
('God of War Ragnarök', 'Kratos y Atreus se embarcan en una épica travesía.', 2, 1, NULL, 48.24, '2022-11-09', 94, '+18'),
('Like a Dragon Infinite Wealth', 'Dos héroes más grandes que la vida misma se unen guiados por el destino, o quizás, por algo más siniestro…', 3, NULL, NULL, 69.99, '2024-01-25', 89, '+18'),
('Super Mario Odyssey', 'Una aventura global con Mario.', 9, NULL, NULL, 40.49, '2017-10-27', 97, '+7'),
('Hades II', 'Secuela del popular roguelike basado en la mitología griega.', 17, NULL, NULL, NULL, NULL, NULL, NULL),
('Hollow Knight', 'Explora las profundidades de un reino olvidado.', 15, 22, 1, 16.68, '2017-02-24', 90, '+7'),
('Celeste', 'Ayuda a Madeline a superar sus demonios internos en su viaje a la cima de la Montaña Celeste.', 9, NULL, NULL, 69.57, '2018-01-25', 94, '+7'),
('Cuphead', 'Un juego clásico de correr y disparar con una estética de dibujos animados de los años 30.', 31, 9, NULL, 31.98, '2017-09-29', 86, '+7'),
('Stardew Valley', 'Construye la granja de tus sueños.', 8, 30, NULL, 44.02, '2016-02-26', 89, '+7'),
('Uncharted 4: A Thief\'s End', 'Sigue a Nathan Drake en su última aventura.', 2, 14, NULL, 38.75, '2016-05-10', 93, '+16'),
('Marvel\'s Spider-Man 2', 'Peter Parker y Miles Morales unen fuerzas en esta nueva aventura.', 1, 2, NULL, 69.99, '2023-10-20', 91, '+16'),
('Marvel\'s Spider-Man', 'Encárnate en la piel de una araña.', 1, 2, 15, 34.97, '2018-09-07', 85, '+16'),
('The Witcher 4', 'Una nueva aventura en el mundo de Geralt de Rivia.', 3, 2, NULL, NULL, NULL, NULL, NULL),
('Animal Crossing: New Horizons', 'Crea tu paraíso isleño ideal.', 8, 30, NULL, 34.11, '2020-03-20', 90, '+3'),
('The Witcher 3: Wild Hunt', 'Una obra maestra de RPG de mundo abierto.', 3, 1, 17, 46.34, '2015-05-19', 93, '+18'),
('Fire Emblem: Three Houses', 'Lidera a un grupo de estudiantes hacia el éxito en un mundo al borde de la guerra.', 27, 3, NULL, 54.55, '2019-07-26', 89, '+12'),
('Ori and the Will of the Wisps', 'Emprende una nueva aventura en un vasto mundo.', 2, 9, NULL, 10.67, '2020-03-11', 90, '+7'),
('Monster Hunter: World', 'Únete a la caza y derriba monstruos gigantes.', 1, 21, NULL, 58.5, '2018-01-26', 90, '+16'),
('Among Us', 'Encuentra al impostor en este juego de deducción social.', 11, 22, NULL, 28.08, '2018-06-15', 85, '+7'),
('DOOM Eternal', 'Desgarra y destroza hordas de demonios.', 23, 7, NULL, 35.32, '2020-03-20', 88, '+18'),
('The Last of Us Part II', 'Ellie continúa su viaje en un mundo peligroso.', 7, 2, NULL, 14.77, '2020-06-19', 93, '+18'),
('Splatoon 3', 'Un vibrante shooter multijugador con mecánicas únicas.', 4, 11, NULL, 64.87, '2022-09-09', 83, '+7'),
('Hades', 'Lucha para salir del infierno en este roguelike.', 17, 3, 9, 55.25, '2020-09-17', 93, '+12'),
('Disco Elysium', 'Un revolucionario juego de rol.', 3, NULL, NULL, 42.89, '2019-10-15', 91, '+18'),
('Elden Ring', 'Una nueva épica aventura de FromSoftware.', 3, 2, NULL, 15.4, '2022-02-25', 96, '+16'),
('Xenoblade Chronicles 3', 'Descubre la verdad de un mundo dividido.', 3, 2, NULL, 37.14, '2022-07-29', 89, '+12'),
('Minecraft Dungeons', 'Lucha en una nueva aventura de acción.', 1, 9, NULL, 65.91, '2020-05-26', 70, '+7'),
('Fall Guys', 'El juego de fiesta definitivo.', 18, NULL, NULL, 62.68, '2020-08-04', 80, '+3'),
('Forza Horizon 4', 'Experimenta las estaciones cambiantes en Gran Bretaña.', 13, NULL, 3, 12.33, '2018-10-02', 92, '+3'),
('Rocket League', 'Fútbol y coches se combinan en este juego lleno de acción.', 13, 6, NULL, 14.37, '2015-07-07', 86, '+3'),
('Journey', 'Una emotiva aventura a través de un hermoso desierto.', 2, NULL, NULL, 18.08, '2012-03-13', 92, '+7'),
('Inside', 'Un oscuro juego de plataformas narrativo.', 9, 24, NULL, 19.8, '2016-06-29', 91, '+18'),
('Little Nightmares', 'Una aventura llena de suspense con visuales oscuros y encantadores.', 24, 9, NULL, 42.4, '2017-04-28', 81, '+16'),
('Portal 2', 'Un juego de puzzles alucinante con humor y agudeza.', 16, 9, NULL, 39.43, '2011-04-19', 95, '+12'),
('Final Fantasy VII Remake', 'Una reinvención del clásico RPG.', 3, NULL, 2, 36.29, '2020-04-10', 87, '+16'),
('Persona 5 Royal', 'Un elegante y profundo RPG.', 3, NULL, NULL, 28.99, '2020-03-31', 95, '+16'),
('Tunic', 'Explora un reino plagado de leyendas olvidadas.', 2, 9, NULL, 36.52, '2022-03-16', 85, '+7'),
('Sekiro: Shadows Die Twice', 'Un juego de acción y aventura brutal y hermoso.', 1, 2, NULL, 48.08, '2019-03-22', 90, '+18'),
('Yakuza Like a Dragon', 'Lucha por conocer la verdad.', 3, NULL, 7, 47.31, '2020-11-10', 84, '+18'),
('Cyberpunk 2077', 'Un RPG futurista ambientado en una ciudad expansiva.', 3, 21, NULL, 62.22, '2020-12-10', 86, '+18'),
('Dead Cells', 'Un juego de acción rogue-lite inspirado en metroidvania.', 17, 15, NULL, 36.96, '2018-08-07', 91, '+16'),
('Outer Wilds', 'Un misterio sobre un sistema solar atrapado en un bucle temporal infinito.', 2, 28, NULL, 66.39, '2019-05-28', 85, '+7'),
('No Man\'s Sky', 'Explora un universo infinito.', 2, 30, NULL, 13.49, '2016-08-09', 61, '+7'),
('Bloodborne', 'Un RPG de acción de pesadilla ambientado en una ciudad maldita.', 7, 3, NULL, 68.78, '2015-03-24', 92, '+16'),
('It Takes Two', 'Una aventura cooperativa de plataformas.', 25, 2, NULL, 56.78, '2021-03-26', 88, '+12'),
('Mario Kart 8 Deluxe', 'La experiencia definitiva de carreras de karts.', 13, 18, NULL, 66.47, '2017-04-28', 92, '+3'),
('Super Smash Bros. Ultimate', 'El crossover definitivo de juegos de lucha.', 12, NULL, NULL, 32.57, '2018-12-07', 93, '+12'),
('Apex Legends', 'Un juego battle royale gratuito.', 11, 4, NULL, 30.44, '2019-02-04', 89, '+16'),
('Overwatch', 'Shooter multijugador basado en equipos con héroes.', 4, 25, NULL, 58.06, '2016-05-24', 91, '+12'),
('League of Legends', 'El popular juego MOBA.', 10, NULL, NULL, 41.69, '2009-10-27', 78, '+12'),
('Fortnite', 'Construye y lucha para lograr la victoria.', 11, 8, NULL, 56.28, '2017-07-25', 81, '+12'),
('Valorant', 'Un shooter táctico de Riot Games.', 4, 23, NULL, 12.54, '2020-06-02', 80, '+16'),
('Call of Duty: Modern Warfare', 'El regreso de la icónica franquicia de shooters.', 23, 4, NULL, 28.03, '2019-10-25', 81, '+18'),
('Resident Evil Village', 'Sobrevive en un nuevo capítulo de horror de supervivencia.', 7, NULL, NULL, 42.29, '2021-05-07', 84, '+18'),
('Metroid Dread', 'Samus Aran enfrenta una nueva amenaza en el planeta ZDR.', 1, 2, NULL, 59.99, '2021-10-08', 88, '+12'),
('Ratchet & Clank: Rift Apart', 'Una aventura interdimensional con Ratchet y Clank.', 1, 2, NULL, 69.99, '2021-06-11', 88, '+12'),
('Halo Infinite', 'El Jefe Maestro regresa para confrontar al enemigo más despiadado.', 4, 1, NULL, 59.99, '2021-12-08', 80, '+16'),
('Returnal', 'Una exploradora espacial atrapada en un ciclo temporal en un planeta alienígena.', 7, 2, NULL, 69.99, '2021-04-30', 86, '+16'),
('Kena: Bridge of Spirits', 'Una guía espiritual en una aventura mágica para descubrir los secretos de una aldea olvidada.', 2, 9, NULL, 39.99, '2021-09-21', 81, '+12'),
('Psychonauts 2', 'Únete a Raz en una misión para salvar al mundo de amenazas psíquicas.', 2, 3, NULL, 59.99, '2021-08-25', 89, '+12'),
('Deathloop', 'Dos asesinos rivales atrapados en un bucle temporal en la isla de Blackreef.', 1, 4, NULL, 59.99, '2021-09-14', 88, '+18'),
('Resident Evil 4 Remake', 'Una reimaginación del clásico juego de terror y supervivencia.', 7, NULL, NULL, 59.99, '2023-03-24', 93, '+18'),
('Hogwarts Legacy', 'Un RPG de mundo abierto ambientado en el universo de Harry Potter.', 3, 2, NULL, 69.99, '2023-02-10', 85, '+16'),
('Starfield', 'Una épica aventura espacial en un vasto universo.', 3, 2, NULL, 69.99, '2023-09-06', 83, '+18'),
('Final Fantasy XVI', 'Una nueva entrada en la aclamada serie de RPG.', 3, 1, NULL, 69.99, '2023-06-22', 87, '+18'),
('Street Fighter 6', 'La última entrega del icónico juego de lucha.', 12, NULL, NULL, 59.99, '2023-06-02', 92, '+12'),
('Diablo IV', 'El regreso del aclamado RPG de acción en un oscuro mundo de fantasía.', 3, NULL, NULL, 69.99, '2023-06-06', 91, '+18'),
('Baldur\'s Gate III', 'Un RPG basado en el universo de Dungeons & Dragons.', 3, NULL, NULL, 59.99, '2023-08-03', 96, '+18'),
('Assassin\'s Creed Mirage', 'Una nueva aventura en la serie de asesinos.', 2, 14, NULL, 59.99, '2023-10-05', 80, '+18'),
('Alan Wake II', 'Una secuela al thriller psicológico original.', 7, 2, NULL, 59.99, '2023-10-17', 89, '+18'),
('EA Sports FC 24', 'La última entrega del popular simulador de fútbol.', 6, NULL, NULL, 59.99, '2023-09-29', 79, '+3'),
('Call of Duty: Black Ops 6', 'La continuación de la serie de shooters en primera persona.', 23, NULL, NULL, 69.99, '2024-10-25', 83, '+18'),
('Elden Ring: Shadow of the Erdtree', 'Expansión del aclamado juego de rol.', 1, 2, NULL, 29.99, '2024-02-28', 94, '+16'),
('Metroid Prime 4', 'La cazarrecompensas Samus Aran regresa en una nueva misión.', 1, 2, NULL, NULL, NULL, NULL, NULL),
('Fable', 'Un reinicio de la clásica serie de RPG de acción.', 3, 2, NULL, NULL, NULL, NULL, NULL),
('The Elder Scrolls VI', 'La próxima entrega en la serie de RPG de mundo abierto.', 3, NULL, NULL, NULL, NULL, NULL, NULL),
('Grand Theft Auto VI', 'La esperada nueva entrega de la serie de mundo abierto.', 2, 1, NULL, NULL, NULL, NULL, NULL),
('Star Wars: Knights of the Old Republic Remake', 'Una reimaginación del clásico RPG ambientado en el universo de Star Wars.', 3, NULL, NULL, NULL, NULL, NULL, NULL),
('Dragon Age: The Veilguard', 'Una nueva aventura en el continente de Thedas.', 3, 2, NULL, 69.99, '2024-10-31', 82, '+18'),
('Perfect Dark', 'Un reinicio de la clásica serie de acción en primera persona.', 4, NULL, NULL, NULL, NULL, NULL, NULL),
('Avowed', 'Un RPG de fantasía épica en el mundo de Eora.', 3, 2, NULL, NULL, '2025-02-18', NULL, NULL),
('Hellblade II: Senua\'s Saga', 'Una aventura emocional en un mundo oscuro.', 3, 7, NULL, 59.99, '2024-05-21', 81, '+18'),
('Stalker 2: Heart of Chernobyl', 'Un juego de supervivencia en la zona de exclusión de Chernóbil.', 21, NULL, NULL, 59.99, '2024-11-20', 73, '+18'),
('Redfall', 'Un shooter cooperativo contra vampiros.', 4, 25, NULL, 59.99, '2022-05-02', 56, '+18'),
('Death Stranding', 'El legendario Hideo Kojima nos ofrece una experiencia que desafía los géneros.', 3, 2, NULL, 69.99, '2019-11-08', 82, '+18'),
('Stray', 'Un gato callejero desentraña un antiguo misterio para escapar de una ciudad cibernética olvidada.', 2, NULL, NULL, 29.99, '2022-07-19', 84, '+12'),
('Sifu', 'Un joven artista marcial en busca de venganza contra los asesinos de su familia.', 1, 4, NULL, 39.99, '2022-02-08', 81, '+16'),
('Kirby and the Forgotten Land', 'Kirby explora un misterioso mundo en ruinas.', 9, 2, NULL, 59.99, '2022-03-25', 85, '+7'),
('Bayonetta 3', 'La bruja de Umbra regresa para enfrentar nuevas amenazas.', 1, 2, NULL, 59.99, '2022-10-28', 87, '+16'),
('Mario + Rabbids Sparks of Hope', 'Mario y los Rabbids unen fuerzas en una nueva aventura galáctica.', 5, 2, NULL, 59.99, '2022-10-20', 85, '+7'),
('The Callisto Protocol', 'Un juego de terror y supervivencia ambientado en una colonia espacial.', 24, 7, NULL, 59.99, '2022-12-02', 71, '+18'),
('A Plague Tale: Requiem', 'Una historia de supervivencia en una Francia medieval devastada por la peste.', 2, 7, NULL, 59.99, '2022-10-18', 83, '+18'),
('Gotham Knights', 'Los protegidos de Batman defienden Gotham tras su desaparición.', 1, 4, NULL, 69.99, '2022-10-21', 67, '+16'),
('Dying Light 2 Stay Human', 'Sobrevive en una ciudad postapocalíptica infestada de zombis.', 21, NULL, NULL, 59.99, '2022-02-04', 76, '+18'),
('Ghostwire: Tokyo', 'Una visión sobrenatural de Tokio donde los espíritus han invadido la ciudad.', 24, 2, NULL, 59.99, '2022-03-25', 77, '+16'),
('Triangle Strategy', 'Un juego de rol táctico con decisiones que afectan la historia.', 5, 27, NULL, 59.99, '2022-03-04', 82, '+12'),
('Live A Live', 'Un remake en HD-2D del clásico RPG.', 3, 2, NULL, 49.99, '2022-07-22', 81, '+12'),
('The Quarry', 'Un grupo de adolescentes en un campamento de verano enfrentan una noche de terror.', 24, 7, NULL, 59.99, '2022-06-10', 80, '+18'),
('Cult of the Lamb', 'Un cordero poseído crea su propio culto en un mundo de falsos profetas.', 17, 2, NULL, 24.99, '2022-08-11', 84, '+12'),
('Neon White', 'Un asesino del infierno compite por la redención en el cielo.', 1, 2, NULL, 24.99, '2022-06-16', 88, '+12'),
('Ori and the Blind Forest', 'Una emotiva aventura de plataformas en un bosque mágico.', 9, NULL, 21, 19.99, '2015-03-11', 88, '+7'),
('Undertale', 'Un RPG donde las decisiones importan y puedes elegir no matar a ningún enemigo.', 3, NULL, NULL, 9.99, '2015-09-15', 92, '+7'),
('The Witness', 'Un juego de puzles en una isla misteriosa llena de desafíos.', 16, NULL, NULL, 39.99, '2016-01-26', 87, '+7'),
('Cocoon', 'Te lleva a una aventura a través de mundos dentro de mundos.', 9, NULL, NULL, 19.99, '2023-09-29', NULL, '+7'),
('Super Meat Boy', 'Un juego de plataformas ultra-difícil donde controlas a un trozo de carne en busca de su amada.', 9, NULL, NULL, 14.99, '2010-10-20', 87, '+12'),
('Bastion', 'Un RPG de acción con una narrativa envolvente y un hermoso estilo artístico.', 3, NULL, NULL, 14.99, '2011-07-20', 89, '+12'),
('Limbo', 'Un juego de plataformas y puzles en blanco y negro con una atmósfera inquietante.', 9, 16, NULL, 9.99, '2010-07-21', 88, '+16'),
('Shovel Knight', 'Un juego de plataformas retro donde controlas a un caballero con una pala.', 9, NULL, NULL, 24.99, '2014-06-26', 90, '+7'),
('Returnal', 'Una exploradora espacial atrapada en un ciclo temporal en un planeta alienígena.', 7, 2, NULL, 69.99, '2021-04-30', 86, '+16'),
('Slay the Spire', 'Un juego de construcción de mazos y roguelike donde asciendes por una torre llena de enemigos.', 17, NULL, NULL, 24.99, '2019-01-23', 89, '+7'),
('Gris', 'Una experiencia narrativa y visual sobre una joven en su propio mundo.', 9, NULL, NULL, 16.99, '2018-12-13', 84, '+7'),
('Katana Zero', 'Un juego de acción y plataformas con combates rápidos y una narrativa intrigante.', 1, 9, NULL, 14.99, '2019-04-18', 83, '+18'),
('The Binding of Isaac: Rebirth', 'Un roguelike de acción y disparos con niveles generados al azar.', 17, 24, NULL, 14.99, '2014-11-04', 86, '+16'),
('Oxenfree', 'Una aventura narrativa sobre un grupo de amigos que abren una grieta fantasmal.', 27, NULL, NULL, 9.99, '2016-01-15', 85, '+12'),
('Firewatch', 'Un juego de aventura en primera persona centrado en la narrativa y la exploración.', 27, NULL, NULL, 19.99, '2016-02-09', 85, '+12'),
('SOMA', 'Un juego de terror y ciencia ficción que explora la identidad y la conciencia.', 24, 7, NULL, 29.99, '2015-09-22', 84, '+18'),
('God of War', 'En este mundo cruel e implacable debe luchar para sobrevivir...', 2, 1, 6, 28.24, '2018-04-20', 94, '+18'),
('Shantae and the Seven Sirens', 'Una nueva aventura con la genio favorita de todos.', 9, NULL, NULL, 29.99, '2020-05-28', 81, '+7'),
('Horizon Forbidden West', 'Explora un vasto mundo lleno de máquinas y misterios.', 2, 1, NULL, 69.99, '2022-02-18', 88, '+16'),
('Death\'s Door', 'Explora una tierra llena de criaturas y secretos mientras recolectas almas.', 9, 2, NULL, 19.99, '2021-07-20', 88, '+12'),
('Eastward', 'Un RPG con una narrativa envolvente y un hermoso pixel art.', 3, NULL, NULL, 24.99, '2021-09-16', 82, '+12'),
('Chicory: A Colorful Tale', 'Un juego de aventuras donde usas un pincel mágico para explorar y resolver puzzles.', 9, 16, NULL, 19.99, '2021-06-10', 90, '+3'),
('Luigi\'s Mansion 3', 'Únete a Luigi, un héroe de lo más cobardica, en una aventura fantasmagórica.', 24, 2, NULL, 59.99, '2019-10-31', 86, '+7'),
('Papers, Please', 'Un juego de simulación donde trabajas como inspector de inmigración.', 8, NULL, NULL, 9.99, '2013-08-08', 85, '+16'),
('Vampire Survivors', 'Enfréntate a hordas infinitas de enemigos mientras recolectas habilidades.', 17, NULL, NULL, 3.99, '2021-12-17', 88, '+12'),
('Terraria', 'Explora, cava, construye y lucha en un mundo generado procedimentalmente.', 30, 8, NULL, 9.99, '2011-05-16', 83, '+12'),
('Factorio', 'Construye y administra fábricas automatizadas en un mundo alienígena.', 8, NULL, NULL, 29.99, '2020-08-14', 90, '+7'),
('13 Sentinels: Aegis Rim', 'Disfruta de esta aventura con desplazamiento lateral en 2D con unos escenarios y un estilo artístico espectaculares y revela los misterios que esconde esta historia.', 3, 2, NULL, 34.99, '2019-11-28', 89, '+16'),
('Red Dead Redemption II', 'Épica historia de Arthur Morgan y la banda de Van der Linde.', 2, 1, NULL, 24.99, '2018-10-26', 97, '+18'),
('The Forest', 'Sobrevive en un bosque lleno de misterios y peligros sobrenaturales.', 21, NULL, NULL, 19.99, '2018-04-30', 83, '+18'),
('Project Zomboid', 'Un simulador de supervivencia en un apocalipsis zombi.', 21, 8, NULL, 14.99, '2013-11-08', 80, '+18'),
('Minecraft', 'Explora mundos generados aleatoriamente y construye cosas maravillosas, desde una simple casa hasta un fastuoso castillo.', 30, 8, NULL, 19.99, '2009-05-17', 93, '+7'),
('Subnautica', 'Explora un océano alienígena mientras gestionas recursos y sobrevives.', 21, NULL, NULL, 29.99, '2018-01-23', 87, '+7'),
('A Hat in Time', 'A Hat in Time es un plataformas en 3D mono hasta decir basta.', 9, NULL, NULL, 28.99, '2017-10-05', 79, '+7'),
('Tinykin', '¡Atrapa cientos de tinykin y usa sus poderes especiales para llevar a Milo de vuelta a su planeta natal y a su tamaño normal!', 9, NULL, NULL, 24.50, '2022-08-30', 78, '+3'),
('Super Mario Bros. Wonder', '¡Únete a Mario y sus amigos en una nueva y maravillosa aventura de desplazamiento lateral en 2D!', 9, NULL, NULL, 59.99, '2023-10-20', 92, '+3'),
('Darkest Dungeon', 'Un desafiante RPG por turnos con temática gótica.', 3, 7, NULL, 24.99, '2016-01-19', 84, '+16'),
('Paper Mario: The Thousand-Year Door', '¡Una historia clásica comienza a desplegarse en la consola Nintendo Switch!', 3, 15, NULL, 59.99, '2024-05-23', 88, '+7'),
('Satisfactory', 'Construye fábricas masivas en un mundo alienígena.', 8, 30, NULL, 29.99, '2020-06-08', 85, '+7'),
('Hi-Fi RUSH', 'Siente el ritmo y acompaña a Chai y a su grupo en su lucha contra una malvada empresa en un mundo sincronizado con la música.', 20, 9, NULL, 29.99, '2023-01-25', 87, '+12'),
('Astro Bot', 'En tu travesía, aprovecha al máximo los nuevos poderes de ASTRO y reúnete con cantidad de héroes emblemáticos del universo PlayStation.', 9, NULL, NULL, 69.99, '2024-09-06', 94, '+7'),
('Judgment', 'Lucha por la verdad y descubre el retorcido crimen que se esconde bajo las calles de Tokio.', 2, 14, NULL, 39.99, '2018-12-13', 80, '+18'),
('Metaphor: ReFantazio', 'El trono está vacío tras el asesinato del rey.', 3, NULL, NULL, 69.99, '2024-10-11', 94, '+16'),
('NieR: Automata', 'Vive la historia de unos androides para recuperar un mundo dominado por las máquinas.', 3, NULL, NULL, 39.99, '2017-03-17', 88, '+18'),
('Pikmin 4', '¡Los Pikmin regresan para emprender otra gran misión!', 30, NULL, NULL, 23.99, '2023-07-21', 87, '+12'),
('Grand Theft Auto V', 'Un joven estafador callejero, un ladrón de bancos retirado y un psicópata aterrador se ven involucrados con lo peor y más desquiciado del mundo criminal.', 1, 2, 81, 39.99, '2013-09-17', 97, '+18');

-- Inserciones para la tabla plataforma
INSERT INTO plataforma (nombre_plataforma, fabricante, fecha_lanzamiento) VALUES
('PlayStation 3', 'Sony', '2006-11-11'),
('PlayStation 4', 'Sony', '2013-11-15'),
('PlayStation 5', 'Sony', '2020-11-12'),
('Xbox 360', 'Microsoft', '2005-11-22'),
('Xbox One', 'Microsoft', '2013-11-22'),
('Xbox Series X/S', 'Microsoft', '2020-11-10'),
('Nintendo Wii', 'Nintendo', '2006-11-19'),
('Nintendo Wii U', 'Nintendo', '2012-11-18'),
('Nintendo Switch', 'Nintendo', '2017-03-03'),
('PC', 'Microsoft', NULL);

-- Inserciones para la tabla juego_plataforma
INSERT INTO juego_plataforma (id_juego, id_plataforma) VALUES
-- The Legend of Zelda: Breath of the Wild
(5, 8), -- Nintendo Wii U
(5, 9), -- Nintendo Switch
-- God of War Ragnarök
(6, 3), -- PlayStation 5
(6, 2), -- PlayStation 4
(6, 10), -- PC
-- Super Mario Odyssey
(8, 9), -- Nintendo Switch
-- Hollow Knight
(10, 9), -- Nintendo Switch
(10, 10), -- PC
(10, 5), -- Xbox One
(10, 2), -- PlayStation 4
-- Celeste
(11, 10), -- PC
(11, 5), -- Xbox One
(11, 2), -- PlayStation 4
(11, 9), -- Nintendo Switch
-- Cuphead
(12, 10), -- PC
(12, 5), -- Xbox One
(12, 9), -- Nintendo Switch
(12, 2), -- PlayStation 4
-- Stardew Valley
(13, 9), -- Nintendo Switch
(13, 10), -- PC
(13, 2), -- PlayStation 4
(13, 5), -- Xbox One
-- Uncharted 4: A Thief's End
(14, 2), -- PlayStation 4
-- Marvel's Spider-Man: Miles Morales
(16, 2), -- PlayStation 4
-- Animal Crossing: New Horizons
(18, 9), -- Nintendo Switch
-- The Witcher 3: Wild Hunt
(19, 10), -- PC
(19, 5), -- Xbox One
(19, 2), -- PlayStation 4
(19, 3), -- PlayStation 5
(19, 9), -- Nintendo Switch
-- Fire Emblem: Three Houses
(20, 9), -- Nintendo Switch
-- Ori and the Will of the Wisps
(21, 10), -- PC
(21, 5), -- Xbox One
(21, 9), -- Nintendo Switch
-- Monster Hunter: World
(22, 10), -- PC
(22, 5), -- Xbox One
(22, 2), -- PlayStation 4
-- Among Us
(23, 10), -- PC
(23, 9), -- Nintendo Switch
(23, 5), -- Xbox One
(23, 2), -- PlayStation 4
-- DOOM Eternal
(24, 10), -- PC
(24, 5), -- Xbox One
(24, 2), -- PlayStation 4
(24, 6), -- Xbox Series X/S
(24, 3), -- PlayStation 5
(24, 9), -- Nintendo Switch
-- The Last of Us Part II
(25, 2), -- PlayStation 4
(25, 3), -- PlayStation 5
-- Splatoon 3
(26, 9), -- Nintendo Switch
-- Hades
(27, 10), -- PC
(27, 5), -- Xbox One
(27, 2), -- PlayStation 4
(27, 3), -- PlayStation 5
(27, 9), -- Nintendo Switch
-- Disco Elysium
(28, 10), -- PC
(28, 5), -- Xbox One
(28, 2), -- PlayStation 4
(28, 9), -- Nintendo Switch
-- Elden Ring
(29, 10), -- PC
(29, 5), -- Xbox One
(29, 6), -- Xbox Series X/S
(29, 2), -- PlayStation 4
(29, 3), -- PlayStation 5
-- Xenoblade Chronicles 3
(30, 9), -- Nintendo Switch
-- Minecraft Dungeons
(31, 10), -- PC
(31, 5), -- Xbox One
(31, 2), -- PlayStation 4
(31, 9), -- Nintendo Switch
-- Fall Guys
(32, 10), -- PC
(32, 2), -- PlayStation 4
(32, 5), -- Xbox One
(32, 9), -- Nintendo Switch
-- Forza Horizon 4
(33, 10), -- PC
(33, 5), -- Xbox One
-- Rocket League
(34, 10), -- PC
(34, 5), -- Xbox One
(34, 6), -- Xbox Series X/S
(34, 2), -- PlayStation 4
(34, 3), -- PlayStation 5
(34, 9), -- Nintendo Switch
-- Journey
(35, 2), -- PlayStation 4
(35, 1), -- PlayStation 3
-- Inside
(36, 10), -- PC
(36, 5), -- Xbox One
(36, 2), -- PlayStation 4
(36, 9), -- Nintendo Switch
-- Little Nightmares
(37, 10), -- PC
(37, 5), -- Xbox One
(37, 2), -- PlayStation 4
(37, 9), -- Nintendo Switch
-- Portal 2
(38, 10), -- PC
(38, 4), -- Xbox 360
(38, 1), -- PlayStation 3
-- Final Fantasy VII Remake
(39, 2), -- PlayStation 4
(39, 3), -- PlayStation 5
-- Persona 5 Royal
(40, 2), -- PlayStation 4
(40, 3), -- PlayStation 5
(40, 9), -- Nintendo Switch
(40, 6), -- Xbox Series X/S
-- Tunic
(41, 10), -- PC
(41, 5), -- Xbox One
(41, 6), -- Xbox Series X/S
(41, 9), -- Nintendo Switch
(41, 2), -- PlayStation 4
(41, 3), -- PlayStation 5
-- Sekiro: Shadows Die Twice
(42, 10), -- PC
(42, 5), -- Xbox One
(42, 2), -- PlayStation 4
-- Yakuza Like a Dragon
(43, 10), -- PC
(43, 5), -- Xbox One
(43, 6), -- Xbox Series X/S
(43, 2), -- PlayStation 4
(43, 3), -- PlayStation 5
-- Cyberpunk 2077
(44, 10), -- PC
(44, 5), -- Xbox One
(44, 6), -- Xbox Series X/S
(44, 2), -- PlayStation 4
(44, 3), -- PlayStation 5
-- Dead Cells
(45, 10), -- PC
(45, 5), -- Xbox One
(45, 2), -- PlayStation 4
(45, 3), -- PlayStation 5
(45, 9), -- Nintendo Switch
-- Outer Wilds
(46, 10), -- PC
(46, 5), -- Xbox One
(46, 6), -- Xbox Series X/S
(46, 2), -- PlayStation 4
(46, 3), -- PlayStation 5
(46, 9), -- Nintendo Switch
-- No Man's Sky
(47, 10), -- PC
(47, 5), -- Xbox One
(47, 6), -- Xbox Series X/S
(47, 2), -- PlayStation 4
(47, 3), -- PlayStation 5
(47, 9), -- Nintendo Switch
-- Bloodborne
(48, 2), -- PlayStation 4
-- It Takes Two
(49, 10), -- PC
(49, 5), -- Xbox One
(49, 6), -- Xbox Series X/S
(49, 2), -- PlayStation 4
(49, 3), -- PlayStation 5
(49, 9), -- Nintendo Switch
-- Mario Kart 8 Deluxe
(50, 9), -- Nintendo Switch
(50, 8), -- Nintendo Wii U
-- Super Smash Bros. Ultimate
(51, 9), -- Nintendo Switch
-- Apex Legends
(52, 10), -- PC
(52, 5), -- Xbox One
(52, 6), -- Xbox Series X/S
(52, 2), -- PlayStation 4
(52, 3), -- PlayStation 5
(52, 9), -- Nintendo Switch
-- Overwatch
(53, 10), -- PC
(53, 5), -- Xbox One
(53, 6), -- Xbox Series X/S
(53, 2), -- PlayStation 4
(53, 3), -- PlayStation 5
(53, 9), -- Nintendo Switch
-- League of Legends
(54, 10), -- PC
-- Fortnite
(55, 10), -- PC
(55, 5), -- Xbox One
(55, 6), -- Xbox Series X/S
(55, 2), -- PlayStation 4
(55, 3), -- PlayStation 5
(55, 9), -- Nintendo Switch
-- Valorant
(56, 10), -- PC
(56, 3), -- PlayStation 5
(56, 6), -- Xbox Series X/S
-- Call of Duty: Modern Warfare
(57, 10), -- PC
(57, 5), -- Xbox One
(57, 6), -- Xbox Series X/S
(57, 2), -- PlayStation 4
(57, 3), -- PlayStation 5
-- Resident Evil Village
(58, 10), -- PC
(58, 5), -- Xbox One
(58, 6), -- Xbox Series X/S
(58, 2), -- PlayStation 4
(58, 3), -- PlayStation 5
(58, 9), -- Nintendo Switch
-- Metroid Dread
(59, 9), -- Nintendo Switch
-- Ratchet & Clank: Rift Apart
(60, 3), -- PlayStation 5
(60, 10), -- PC
-- Halo Infinite
(61, 10), -- PC
(61, 6), -- Xbox Series X/S
-- Returnal
(62, 3), -- PlayStation 5
(62, 10), -- PC
-- Kena: Bridge of Spirits
(63, 10), -- PC
(63, 2), -- PlayStation 4
(63, 3), -- PlayStation 5
(63, 5), -- Xbox One
(63, 6), -- Xbox Series X/S
-- Psychonauts 2
(64, 10), -- PC
(64, 5), -- Xbox One
(64, 6), -- Xbox Series X/S
(64, 2), -- PlayStation 4
-- Deathloop
(65, 10), -- PC
(65, 3), -- PlayStation 5
(65, 6), -- Xbox Series X/S
-- Forza Horizon 5
(3, 10), -- PC
(3, 6), -- Xbox Series X/S
-- Resident Evil 4 Remake
(66, 10), -- PC
(66, 5), -- Xbox One
(66, 6), -- Xbox Series X/S
(66, 2), -- PlayStation 4
(66, 3), -- PlayStation 5
-- Hogwarts Legacy
(67, 10), -- PC
(67, 5), -- Xbox One
(67, 6), -- Xbox Series X/S
(67, 2), -- PlayStation 4
(67, 3), -- PlayStation 5
(67, 9), -- Nintendo Switch
-- Starfield
(68, 10), -- PC
(68, 6), -- Xbox Series X/S
-- The Legend of Zelda: Tears of the Kingdom
(4, 9), -- Nintendo Switch
-- Final Fantasy XVI
(69, 3), -- PlayStation 5
(69, 10), -- PC
-- Street Fighter 6
(70, 10), -- PC
(70, 5), -- Xbox One
(70, 6), -- Xbox Series X/S
(70, 2), -- PlayStation 4
(70, 3), -- PlayStation 5
-- Diablo IV
(71, 10), -- PC
(71, 5), -- Xbox One
(71, 6), -- Xbox Series X/S
(71, 2), -- PlayStation 4
(71, 3), -- PlayStation 5
-- Baldur's Gate III
(72, 10), -- PC
(72, 3), -- PlayStation 5
(72, 6), -- Xbox Serries X/S
-- Assassin's Creed Mirage
(73, 10), -- PC
(73, 5), -- Xbox One
(73, 6), -- Xbox Series X/S
(73, 2), -- PlayStation 4
(73, 3), -- PlayStation 5
-- Alan Wake II
(74, 10), -- PC
(74, 6), -- Xbox Series X/S
(74, 3), -- PlayStation 5
-- Marvel's Spider-Man 2
(15, 3), -- PlayStation 5
-- EA Sports FC 24
(75, 10), -- PC
(75, 5), -- Xbox One
(75, 6), -- Xbox Series X/S
(75, 2), -- PlayStation 4
(75, 3), -- PlayStation 5
(75, 9), -- Nintendo Switch
-- Call of Duty: Black Ops 6
(76, 10), -- PC
(76, 5), -- Xbox One
(76, 6), -- Xbox Series X/S
(76, 2), -- PlayStation 4
(76, 3), -- PlayStation 5
-- Elden Ring: Shadow of the Erdtree
(77, 10), -- PC
(77, 5), -- Xbox One
(77, 6), -- Xbox Series X/S
(77, 2), -- PlayStation 4
(77, 3), -- PlayStation 5
-- Hades II
(9, 3), -- PlayStation 5
(9, 10), -- PC
(9, 9), -- Nintendo Switch
(9, 6), -- Xbox Series X/S
-- Metroid Prime 4
(78, 9), -- Nintendo Switch
-- Fable
(79, 6), -- Xbox Series X/S
(79, 10), -- PC
-- The Elder Scrolls VI
(80, 6), -- Xbox Series X/S
(80, 10), -- PC
-- Grand Theft Auto VI
(81, 3), -- PlayStation 5
(81, 6), -- Xbox Series X/S
(81, 10), -- PC
-- Star Wars: Knights of the Old Republic Remake
(82, 3), -- PlayStation 5
-- The Witcher 4
(17, 3), -- PlayStation 5
(17, 6), -- Xbox Series X/S
(17, 10), -- PC
-- Dragon Age: The Veilguard
(83, 10), -- PC
(83, 6), -- Xbox Series X/S
(83, 3), -- PlayStation 5
-- Perfect Dark
(84, 6), -- Xbox Series X/S
(84, 10), -- PC
-- Hollow Knight: Silksong
(1, 3), -- PlayStation 5
(1, 6), -- Xbox Series X/S
(1, 9), -- Nintendo Switch
(1, 10), -- PC
-- Avowed
(85, 6), -- Xbox Series X/S
(85, 10), -- PC
-- Hellblade II: Senua's Saga
(86, 10), -- PC
(86, 6), -- Xbox Series X/S
-- Stalker 2: Heart of Chernobyl
(87, 10), -- PC
(87, 6), -- Xbox Series X/S
-- Redfall
(88, 10), -- PC
(88, 6), -- Xbox Series X/S
-- Death Stranding
(89, 10), -- PC
(89, 3), -- PlayStation 5
(89, 2), -- PlayStation 4
(89, 6), -- Xbox Series X/S
-- Stray
(90, 10), -- PC
(90, 9), -- Nintendo Switch
(90, 3), -- PlayStation 5
(90, 2), -- PlayStation 4
-- Sifu
(91, 10), -- PC
(91, 3), -- PlayStation 5
(91, 2), -- PlayStation 4
(91, 5), -- Xbox One
(91, 6), -- Xbox Series X/S
(91, 9), -- Nintendo Switch
-- Kirby and the Forgotten Land
(92, 9), -- Nintendo Switch
-- Bayonetta 3
(93, 9), -- Nintendo Switch
-- Mario + Rabbids Sparks of Hope
(94, 9), -- Nintendo Switch
-- The Callisto Protocol
(95, 10), -- PC
(95, 6), -- Xbox Series X/S
(95, 3), -- PlayStation 5
(95, 2), -- PlayStation 4
(95, 5), -- Xbox One
-- A Plague Tale: Requiem
(96, 10), -- PC
(96, 6), -- Xbox Series X/S
(96, 3), -- PlayStation 5
(96, 9), -- Nintnedo Switch
-- Gotham Knights
(97, 10), -- PC
(97, 5), -- Xbox One
(97, 6), -- Xbox Series X/S
(97, 2), -- PlayStation 4
(97, 3), -- PlayStation 5
-- Dying Light 2 Stay Human
(98, 10), -- PC
(98, 5), -- Xbox One
(98, 6), -- Xbox Series X/S
(98, 2), -- PlayStation 4
(98, 3), -- PlayStation 5
-- Ghostwire: Tokyo
(99, 10), -- PC
(99, 3), -- PlayStation 5
(99, 6), -- Xbox Series X
-- Triangle Strategy
(100, 9), -- Nintendo Switch
(100, 10), -- PC
-- Live A Live
(101, 9), -- Nintendo Switch
-- The Quarry
(102, 10), -- PC
(102, 6), -- Xbox Series X/S
(102, 5), -- Xbox One
(102, 3), -- PlayStation 5
(102, 2), -- PlayStation 4
-- Cult of the Lamb
(103, 10), -- PC
(103, 9), -- Nintendo Switch
(103, 5), -- Xbox One
(103, 6), -- Xbox Series X/S
(103, 2), -- PlayStation 4
(103, 3), -- PlayStation 5
-- Neon White
(104, 10), -- PC
(104, 9), -- Nintendo Switch
(104, 3), -- PlayStation 5
-- Ori and the Blind Forest
(105, 10), -- PC
(105, 5), -- Xbox One
(105, 6), -- Xbox Series X/S
(105, 9), -- Nintendo Switch
-- Undertale
(106, 10), -- PC
(106, 9), -- Nintendo Switch
(106, 2), -- PlayStation 4
(106, 5), -- Xbox One
(106, 6), -- Xbox Series X/S
-- The Witness
(107, 10), -- PC
(107, 5), -- Xbox One
(107, 2), -- PlayStation 4
-- Cocoon
(108, 10), -- PC
(108, 9), -- Nintendo Switch
(108, 6), -- Xbox Series X/S
(108, 5), -- Xbox One
(108, 3), -- PlayStation 5
(108, 2), -- PlayStation 4
-- Super Meat Boy
(109, 10), -- PC
(109, 9), -- Nintendo Switch
(109, 8), -- Nintendo Wii U
(109, 4), -- Xbox 360
(109, 2), -- PlayStation 4
-- Bastion
(110, 10), -- PC
(110, 9), -- Nintendo Switch
(110, 2), -- PlayStation 4
(110, 3), -- PlayStation 5
-- Limbo
(111, 10), -- PC
(111, 9), -- Nintendo Switch
(111, 5), -- Xbox One
(111, 4), -- Xbox 360
(111, 2), -- PlayStation 4
(111, 1), -- PlayStation 3
-- Shovel Knight
(112, 10), -- PC
(112, 9), -- Nintendo Switch
(112, 8), -- Nintendo Wii U
(112, 5), -- Xbox One
(112, 3), -- PlayStation 5
-- Returnal
(113, 10), -- PC
(113, 3), -- PlayStation 5
-- Slay the Spire
(114, 10), -- PC
(114, 8), -- Nintendo Wii U
(114, 9), -- Nintendo Switch
(114, 4), -- Xbox 360
(114, 5), -- Xbox One
(114, 1), -- PlayStation 3
(114, 2), -- PlayStation 4
(114, 3), -- PlayStation 5
-- Gris
(115, 10), -- PC
(115, 9), -- Nintendo Switch
(115, 5), -- Xbonx One
(115, 6), -- Xbonx Series X/S
(115, 3), -- PlayStation 5
(115, 2), -- PlayStation 4
-- Katana Zero
(116, 10), -- PC
(116, 9), -- Nintendo Switch
(116, 5), -- Xbox One
(116, 2), -- PlayStation 4
-- The Binding of Isaac: Rebirth
(117, 10), -- PC
(117, 9), -- Nintendo Switch
(117, 8), -- Nintendo Wii U
(117, 5), -- Xbox One
(117, 2), -- PlayStation 4
-- Oxenfree
(118, 10), -- PC
(118, 9), -- Nintendo Switch
(118, 5), -- Xbox One
(118, 3), -- PlayStation 5
(118, 2), -- PlayStation 4
-- Firewatch
(119, 10), -- PC
(119, 5), -- Xbox One
(119, 2), -- PlayStation 4
(119, 9), -- Nintendo Switch
-- SOMA
(120, 10), -- PC
(120, 2), -- PlayStation 4
(120, 5), -- Xbox One
-- God Of War
(121, 10), -- PC
(121, 3), -- PlayStation 5
-- Shantae and the Seven Sirens
(122, 10), -- PC
(122, 9), -- Nintendo Switch
(122, 5), -- Xbox One
(122, 3), -- PlayStation 5
-- Horizon Forbidden West
(123, 3), -- PlayStation 5
(123, 10), -- PC
-- Death's Door
(124, 10), -- PC
(124, 9), -- Nintendo Switch
(124, 5), -- Xbox One
(124, 6), -- Xbox Series X/S
(124, 3), -- PlayStation 5
(124, 2), -- PlayStation 4
-- Eastward
(125, 10), -- PC
(125, 9), -- Nintendo Switch
(125, 5), -- Xbox One
-- Chicory: A Colorful Tale
(126, 10), -- PC
(126, 9), -- Nintendo Switch
(126, 2), -- PlayStation 4
(126, 3), -- PlayStation 5
(126, 5), -- Xbox One
(126, 6), -- Xbox Series X/S
-- Luigi's Mansion 3
(127, 9), -- Nintendo Switch
-- Papers, Please
(128, 10), -- PC
-- Vampire Survivors
(129, 10), -- PC
(129, 5), -- Xbox One
(129, 6), -- Xbox Series X/S
(129, 9), -- Nintendo Switch
(129, 2), -- PlayStation 4
(129, 3), -- PlayStation 5
-- Terraria
(130, 10), -- PC
(130, 9), -- Nintendo Switch
(130, 8), -- Nintendo Wii U
(130, 5), -- Xbox One
(130, 3), -- PlayStation 5
-- Factorio
(131, 10), -- PC
(131, 9), -- Nintendo Switch
-- Like a Dragon Infinite Wealth
(7, 10), -- PC
(7, 5), -- Xbox One
(7, 6), -- Xbox Series X/S
(7, 3), -- PlayStation 5
(7, 2), -- PlayStation 4
-- 13 Sentinels: Aegis Rim
(132, 9), -- Nintendo Switch
(132, 2), -- PlayStation 4
-- Red Dead Redemption II
(133, 10), -- PC
(133, 5), -- Xbox One
(133, 2), -- PlayStation 4
-- The Forest
(134, 10), -- PC
(134, 2), -- PlayStation 4
-- Project Zomboid
(135, 10), -- PC
-- Minecraft
(136, 10), -- PC
(136, 9), -- Nintendo Switch
(136, 5), -- Xbox One
(136, 6), -- Xbox Series X/S
(136, 3), -- PlayStation 5
(136, 2), -- PlayStation 4
-- Subnautica
(137, 10), -- PC
(137, 5), -- Xbox One
(137, 9), -- Nintendo Switch
(137, 3), -- PlayStation 5
(137, 2), -- PlayStation 4
-- A Hat in Time
(138, 10), -- PC
(138, 9), -- Nintendo Switch
(138, 5), -- Xbox One
(138, 2), -- PlayStation 4
-- Tinykin
(139, 10), -- PC
(139, 9), -- Nintendo Switch
(139, 5), -- Xbox One
(139, 6), -- Xbox Series X/S
(139, 3), -- PlayStation 5
(139, 2), -- PlayStation 4
-- Super Mario Bros. Wonder
(140, 9), -- Nintendo Switch
-- Darkest Dungeon
(141, 10), -- PC
(141, 9), -- Nintendo Switch
(141, 5), -- Xbox One
(141, 6), -- Xbox Series X/S
(141, 3), -- PlayStation 5
(141, 2), -- PlayStation 4
-- Final Fantasy VII Rebirth
(2, 3), -- PlayStation 5
-- Paper Mario: The Thousand-Year Door
(142, 9), -- Nintendo Switch
-- Satisfactory
(143, 10), -- PC
(143, 3), -- PlayStation 5
(143, 6), -- Xbox Series X/S
-- Hi-Fi RUSH
(144, 10), -- PC
(144, 6), -- Xbox Series X/S
(144, 3), -- PlayStation 5
-- Astro Bot
(145, 3), -- PlayStation 5
-- Judgment
(146, 10), -- PC
(146, 5), -- Xbox One
(146, 6), -- Xbox Series X/S
(146, 3), -- PlayStation 5
(146, 2), -- PlayStation 4
-- Metaphor: ReFantazio
(147, 10), -- PC
(147, 3), -- PlayStation 5
(147, 6), -- Xbox Series X/S
-- NieR: Automata
(148, 10), -- PC
(148, 9), -- Nintendo Switch
(148, 5), -- Xbox One
(148, 2), -- PlayStation 4
-- Pikmin 4
(149, 9), -- Nintendo Switch
-- Grand Theft Auto V
(150, 10), -- PC
(150, 5), -- Xbox One
(150, 4), -- Xbox 360
(150, 6), -- Xbox Series X/S
(150, 3), -- PlayStation 5
(150, 2), -- PlayStation 4
(150, 1); -- PlayStation 3

-- Inserciones tabla usuario
INSERT INTO usuario (nombre_usuario, email, pais, fecha_registro, avatar_url, telefono) VALUES
('Alice Johnson', 'alice.johnson@example.com', 'USA', '2023-01-15', 'https://example.com/avatar1.jpg', '+1234567890'),
('Bob Smith', 'bob.smith@example.com', 'Canada', '2023-01-20', 'https://example.com/avatar2.jpg', '+1234567891'),
('Charlie Brown', 'charlie.brown@example.com', 'UK', '2023-02-10', 'https://example.com/avatar3.jpg', '+1234567892'),
('Daisy Green', 'daisy.green@example.com', 'Australia', '2023-02-15', 'https://example.com/avatar4.jpg', '+1234567893'),
('Ethan White', 'ethan.white@example.com', 'Germany', '2023-02-20', 'https://example.com/avatar5.jpg', '+1234567894'),
('Fiona Black', 'fiona.black@example.com', 'España', '2023-03-01', 'https://example.com/avatar6.jpg', '+1234567895'),
('George Carter', 'george.carter@example.com', 'France', '2023-03-10', 'https://example.com/avatar7.jpg', '+1234567896'),
('Hannah Adams', 'hannah.adams@example.com', 'Italy', '2023-03-15', 'https://example.com/avatar8.jpg', '+1234567897'),
('Ian Wright', 'ian.wright@example.com', 'Brazil', '2023-04-01', 'https://example.com/avatar9.jpg', '+1234567898'),
('Jane King', 'jane.king@example.com', 'India', '2023-04-10', 'https://example.com/avatar10.jpg', '+1234567899'),
('Kyle Young', 'kyle.young@example.com', 'Mexico', '2023-04-20', 'https://example.com/avatar11.jpg', '+1234567800'),
('Lily Hall', 'lily.hall@example.com', 'Argentina', '2023-05-01', 'https://example.com/avatar12.jpg', '+1234567801'),
('Mason Lee', 'mason.lee@example.com', 'Japan', '2023-05-15', 'https://example.com/avatar13.jpg', '+1234567802'),
('Nina Scott', 'nina.scott@example.com', 'China', '2023-05-20', 'https://example.com/avatar14.jpg', '+1234567803'),
('Oscar Evans', 'oscar.evans@example.com', 'South Korea', '2023-06-01', 'https://example.com/avatar15.jpg', '+1234567804'),
('Paula Baker', 'paula.baker@example.com', 'South Africa', '2023-06-10', 'https://example.com/avatar16.jpg', '+1234567805'),
('Quinn Mitchell', 'quinn.mitchell@example.com', 'Russia', '2023-06-15', 'https://example.com/avatar17.jpg', '+1234567806'),
('Rachel Hughes', 'rachel.hughes@example.com', 'New Zealand', '2023-07-01', 'https://example.com/avatar18.jpg', '+1234567807'),
('Sam Wilson', 'sam.wilson@example.com', 'Portugal', '2023-07-10', 'https://example.com/avatar19.jpg', '+1234567808'),
('Tina Carter', 'tina.carter@example.com', 'Sweden', '2023-07-20', 'https://example.com/avatar20.jpg', '+1234567809'),
('Uma Kelly', 'uma.kelly@example.com', 'Netherlands', '2023-08-01', 'https://example.com/avatar21.jpg', '+1234567810'),
('Victor Roberts', 'victor.roberts@example.com', 'Belgium', '2023-08-10', 'https://example.com/avatar22.jpg', '+1234567811'),
('Wendy Campbell', 'wendy.campbell@example.com', 'Norway', '2023-08-15', 'https://example.com/avatar23.jpg', '+1234567812'),
('Xander Foster', 'xander.foster@example.com', 'Denmark', '2023-08-20', 'https://example.com/avatar24.jpg', '+1234567813'),
('Yvonne Morris', 'yvonne.morris@example.com', 'Ireland', '2023-09-01', 'https://example.com/avatar25.jpg', '+1234567814'),
('Zachary Turner', 'zachary.turner@example.com', 'Poland', '2023-09-10', 'https://example.com/avatar26.jpg', '+1234567815'),
('Amy Taylor', 'amy.taylor@example.com', 'Switzerland', '2023-09-15', 'https://example.com/avatar27.jpg', '+1234567816'),
('Brian Walker', 'brian.walker@example.com', 'Austria', '2023-09-20', 'https://example.com/avatar28.jpg', '+1234567817'),
('Chloe Lewis', 'chloe.lewis@example.com', 'Czech Republic', '2023-09-25', 'https://example.com/avatar29.jpg', '+1234567818'),
('Daniel Edwards', 'daniel.edwards@example.com', 'Hungary', '2023-10-01', 'https://example.com/avatar30.jpg', '+1234567819'),
('Emma Collins', 'emma.collins@example.com', 'Finland', '2023-10-05', 'https://example.com/avatar31.jpg', '+1234567820'),
('Franklin Diaz', 'franklin.diaz@example.com', 'Chile', '2023-10-10', 'https://example.com/avatar32.jpg', '+1234567821'),
('Grace Carter', 'grace.carter@example.com', 'Colombia', '2023-10-15', 'https://example.com/avatar33.jpg', '+1234567822'),
('Henry Perez', 'henry.perez@example.com', 'Venezuela', '2023-10-20', 'https://example.com/avatar34.jpg', '+1234567823'),
('Isabella Rivera', 'isabella.rivera@example.com', 'Peru', '2023-10-25', 'https://example.com/avatar35.jpg', '+1234567824'),
('Jack Simmons', 'jack.simmons@example.com', 'Ecuador', '2023-11-01', 'https://example.com/avatar36.jpg', '+1234567825'),
('Katherine Morris', 'katherine.morris@example.com', 'Uruguay', '2023-11-05', 'https://example.com/avatar37.jpg', '+1234567826'),
('Liam Stewart', 'liam.stewart@example.com', 'Paraguay', '2023-11-10', 'https://example.com/avatar38.jpg', '+1234567827'),
('Mia Bailey', 'mia.bailey@example.com', 'Bolivia', '2023-11-15', 'https://example.com/avatar39.jpg', '+1234567828'),
('Noah Wilson', 'noah.wilson@example.com', 'Costa Rica', '2023-11-20', 'https://example.com/avatar40.jpg', '+1234567829'),
('Olivia Martinez', 'olivia.martinez@example.com', 'Panama', '2023-11-25', 'https://example.com/avatar41.jpg', '+1234567830'),
('Patrick Johnson', 'patrick.johnson@example.com', 'Honduras', '2023-12-01', 'https://example.com/avatar42.jpg', '+1234567831'),
('Quincy Taylor', 'quincy.taylor@example.com', 'El Salvador', '2023-12-05', 'https://example.com/avatar43.jpg', '+1234567832'),
('Rebecca Harris', 'rebecca.harris@example.com', 'Guatemala', '2023-12-10', 'https://example.com/avatar44.jpg', '+1234567833'),
('Samuel Young', 'samuel.young@example.com', 'Dominican Republic', '2023-12-15', 'https://example.com/avatar45.jpg', '+1234567834'),
('Tara Mitchell', 'tara.mitchell@example.com', 'Puerto Rico', '2023-12-20', 'https://example.com/avatar46.jpg', '+1234567835'),
('Uma Wright', 'uma.wright@example.com', 'Cuba', '2023-12-25', 'https://example.com/avatar47.jpg', '+1234567836'),
('Victor Garcia', 'victor.garcia@example.com', 'Haiti', '2023-12-30', 'https://example.com/avatar48.jpg', '+1234567837'),
('Wendy Martinez', 'wendy.martinez@example.com', 'Jamaica', '2024-01-01', 'https://example.com/avatar49.jpg', '+1234567838'),
('Xavier Lopez', 'xavier.lopez@example.com', 'Trinidad and Tobago', '2024-01-05', 'https://example.com/avatar50.jpg', '+1234567839'),
('Yasmin Rivera', 'yasmin.rivera@example.com', 'Guyana', '2024-01-10', 'https://example.com/avatar51.jpg', '+1234567840'),
('Zane Clark', 'zane.clark@example.com', 'Suriname', '2024-01-15', 'https://example.com/avatar52.jpg', '+1234567841'),
('Alicia Morgan', 'alicia.morgan@example.com', 'Belize', '2024-01-20', 'https://example.com/avatar53.jpg', '+1234567842'),
('Benjamin Torres', 'benjamin.torres@example.com', 'Barbados', '2024-01-25', 'https://example.com/avatar54.jpg', '+1234567843'),
('Camila Brooks', 'camila.brooks@example.com', 'Bahamas', '2024-01-30', 'https://example.com/avatar55.jpg', '+1234567844'),
('David Sanders', 'david.sanders@example.com', 'Grenada', '2024-02-01', 'https://example.com/avatar56.jpg', '+1234567845'),
('Eliza Perry', 'eliza.perry@example.com', 'Saint Lucia', '2024-02-05', 'https://example.com/avatar57.jpg', '+1234567846'),
('Francis Ramirez', 'francis.ramirez@example.com', 'Saint Kitts and Nevis', '2024-02-10', 'https://example.com/avatar58.jpg', '+1234567847'),
('Gabriel Foster', 'gabriel.foster@example.com', 'Antigua and Barbuda', '2024-02-15', 'https://example.com/avatar59.jpg', '+1234567848'),
('Hazel Ward', 'hazel.ward@example.com', 'Dominica', '2024-02-20', 'https://example.com/avatar60.jpg', '+1234567849'),
('Ian James', 'ian.james@example.com', 'Saint Vincent and the Grenadines', '2024-02-25', 'https://example.com/avatar61.jpg', '+1234567850'),
('Jade Peterson', 'jade.peterson@example.com', 'Montserrat', '2024-03-01', 'https://example.com/avatar62.jpg', '+1234567851'),
('Kevin Brooks', 'kevin.brooks@example.com', 'Aruba', '2024-03-05', 'https://example.com/avatar63.jpg', '+1234567852'),
('Luis Rodríguez', 'luis.rodriguez@example.com', 'México', '2024-01-02', 'https://example.com/avatars/luis.jpg', '+525512345678'),
('Emma Gómez', 'emma.gomez@example.com', 'Argentina', '2024-01-03', 'https://example.com/avatars/emma.jpg', '+5491167891234'),
('Mateo Fernández', 'mateo.fernandez@example.com', 'Chile', '2024-01-04', 'https://example.com/avatars/mateo.jpg', '+569987654321'),
('Isabella López', 'isabella.lopez@example.com', 'Colombia', '2024-01-05', 'https://example.com/avatars/isabella.jpg', '+573212345678'),
('Lucas Pérez', 'lucas.perez@example.com', 'Uruguay', '2024-01-06', 'https://example.com/avatars/lucas.jpg', '+59891234567'),
('Valentina Díaz', 'valentina.diaz@example.com', 'Perú', '2024-01-07', 'https://example.com/avatars/valentina.jpg', '+51987654321'),
('Martín Sánchez', 'martin.sanchez@example.com', 'España', '2024-01-08', 'https://example.com/avatars/martin.jpg', '+34678901235'),
('Camila Torres', 'camila.torres@example.com', 'México', '2024-01-09', 'https://example.com/avatars/camila.jpg', '+525512345679'),
('Sebastián Romero', 'sebastian.romero@example.com', 'Argentina', '2024-01-10', 'https://example.com/avatars/sebastian.jpg', '+5491167891235'),
('Victoria Herrera', 'victoria.herrera@example.com', 'Chile', '2024-01-11', 'https://example.com/avatars/victoria.jpg', '+569987654322'),
('Diego Castro', 'diego.castro@example.com', 'Colombia', '2024-01-12', 'https://example.com/avatars/diego.jpg', '+573212345679'),
('Daniela Morales', 'daniela.morales@example.com', 'Uruguay', '2024-01-13', 'https://example.com/avatars/daniela.jpg', '+59891234568'),
('Javier Méndez', 'javier.mendez@example.com', 'Perú', '2024-01-14', 'https://example.com/avatars/javier.jpg', '+51987654322'),
('Sara Ruiz', 'sara.ruiz@example.com', 'España', '2024-01-15', 'https://example.com/avatars/sara.jpg', '+34678901236'),
('Alejandro Ortega', 'alejandro.ortega@example.com', 'México', '2024-01-16', 'https://example.com/avatars/alejandro.jpg', '+525512345680'),
('Julieta Rivera', 'julieta.rivera@example.com', 'Argentina', '2024-01-17', 'https://example.com/avatars/julieta.jpg', '+5491167891236'),
('Tomás Gil', 'tomas.gil@example.com', 'Chile', '2024-01-18', 'https://example.com/avatars/tomas.jpg', '+569987654323'),
('Lucía Vargas', 'lucia.vargas@example.com', 'Colombia', '2024-01-19', 'https://example.com/avatars/lucia.jpg', '+573212345680'),
('Hugo Peña', 'hugo.pena@example.com', 'Uruguay', '2024-01-20', 'https://example.com/avatars/hugo.jpg', '+59891234569'),
('Paula Navarro', 'paula.navarro@example.com', 'Perú', '2024-01-21', 'https://example.com/avatars/paula.jpg', '+51987654323'),
('Carlos Reyes', 'carlos.reyes@example.com', 'España', '2024-01-22', 'https://example.com/avatars/carlos.jpg', '+34678901237'),
('Elena Flores', 'elena.flores@example.com', 'México', '2024-01-23', 'https://example.com/avatars/elena.jpg', '+525512345681'),
('Mario Álvarez', 'mario.alvarez@example.com', 'Argentina', '2024-01-24', 'https://example.com/avatars/mario.jpg', '+5491167891237'),
('Andrea Cruz', 'andrea.cruz@example.com', 'Chile', '2024-01-25', 'https://example.com/avatars/andrea.jpg', '+569987654324'),
('Pablo Jiménez', 'pablo.jimenez@example.com', 'Colombia', '2024-01-26', 'https://example.com/avatars/pablo.jpg', '+573212345681'),
('Claudia Vega', 'claudia.vega@example.com', 'Uruguay', '2024-01-27', 'https://example.com/avatars/claudia.jpg', '+59891234570'),
('Santiago Ramos', 'santiago.ramos@example.com', 'Perú', '2024-01-28', 'https://example.com/avatars/santiago.jpg', '+51987654324'),
('Nuria Ortiz', 'nuria.ortiz@example.com', 'España', '2024-01-29', 'https://example.com/avatars/nuria.jpg', '+34678901238'),
('Adrián Paredes', 'adrian.paredes@example.com', 'México', '2024-01-30', 'https://example.com/avatars/adrian.jpg', '+525512345682'),
('Carmen Castillo', 'carmen.castillo@example.com', 'Argentina', '2024-01-31', 'https://example.com/avatars/carmen.jpg', '+5491167891238'),
('Felipe Medina', 'felipe.medina@example.com', 'Chile', '2024-02-01', 'https://example.com/avatars/felipe.jpg', '+569987654325'),
('Verónica Fuentes', 'veronica.fuentes@example.com', 'Colombia', '2024-02-02', 'https://example.com/avatars/veronica.jpg', '+573212345682'),
('Manuel Aguirre', 'manuel.aguirre@example.com', 'Uruguay', '2024-02-03', 'https://example.com/avatars/manuel.jpg', '+59891234571'),
('Teresa Escobar', 'teresa.escobar@example.com', 'Perú', '2024-02-04', 'https://example.com/avatars/teresa.jpg', '+51987654325'),
('Gabriel Delgado', 'gabriel.delgado@example.com', 'España', '2024-02-05', 'https://example.com/avatars/gabriel.jpg', '+34678901239'),
('Ana Campos', 'ana.campos@example.com', 'México', '2024-02-06', 'https://example.com/avatars/ana.jpg', '+525512345683'),
('David Bautista', 'david.bautista@example.com', 'Argentina', '2024-02-07', 'https://example.com/avatars/david.jpg', '+5491167891239'),
('Carla Gutiérrez', 'carla.gutierrez@example.com', 'Chile', '2024-02-08', 'https://example.com/avatars/carla.jpg', '+569987654326'),
('Francisco Molina', 'francisco.molina@example.com', 'Colombia', '2024-02-09', 'https://example.com/avatars/francisco.jpg', '+573212345683'),
('Patricia Márquez', 'patricia.marquez@example.com', 'Uruguay', '2024-02-10', 'https://example.com/avatars/patricia.jpg', '+59891234572'),
('Álvaro Guerra', 'alvaro.guerra@example.com', 'Perú', '2024-02-11', 'https://example.com/avatars/alvaro.jpg', '+51987654326'),
('Irene Blanco', 'irene.blanco@example.com', 'España', '2024-02-12', 'https://example.com/avatars/irene.jpg', '+34678901240'),
('Ricardo Suárez', 'ricardo.suarez@example.com', 'México', '2024-02-13', 'https://example.com/avatars/ricardo.jpg', '+525512345684'),
('Sandra Acosta', 'sandra.acosta@example.com', 'Argentina', '2024-02-14', 'https://example.com/avatars/sandra.jpg', '+5491167891240'),
('Guillermo Cabrera', 'guillermo.cabrera@example.com', 'Chile', '2024-02-15', 'https://example.com/avatars/guillermo.jpg', '+569987654327'),
('María Ángeles Bravo', 'maria.bravo@example.com', 'Colombia', '2024-02-16', 'https://example.com/avatars/maria.jpg', '+573212345684'),
('José Ignacio Paz', 'jose.paz@example.com', 'Uruguay', '2024-02-17', 'https://example.com/avatars/jose.jpg', '+59891234573'),
('Marta Padilla', 'marta.padilla@example.com', 'Perú', '2024-02-18', 'https://example.com/avatars/marta.jpg', '+51987654327'),
('César Herrera', 'cesar.herrera@example.com', 'España', '2024-02-19', 'https://example.com/avatars/cesar.jpg', '+34678901241'),
('Nerea Sánchez', 'nerea.sanchez@example.com', 'México', '2024-02-20', 'https://example.com/avatars/nerea.jpg', '+525512345685'),
('Esteban Vargas', 'esteban.vargas@example.com', 'Argentina', '2024-02-21', 'https://example.com/avatars/esteban.jpg', '+5491167891241'),
('Paula Pérez', 'paula.perez@example.com', 'Chile', '2024-02-22', 'https://example.com/avatars/paula.jpg', '+569987654328'),
('Héctor Ruiz', 'hector.ruiz@example.com', 'Colombia', '2024-02-23', 'https://example.com/avatars/hector.jpg', '+573212345685'),
('Nayara Morales', 'nayara.morales@example.com', 'Uruguay', '2024-02-24', 'https://example.com/avatars/nayara.jpg', '+59891234574'),
('Antonio Castillo', 'antonio.castillo@example.com', 'Perú', '2024-02-25', 'https://example.com/avatars/antonio.jpg', '+51987654328'),
('Beatriz Gil', 'beatriz.gil@example.com', 'España', '2024-02-26', 'https://example.com/avatars/beatriz.jpg', '+34678901242'),
('Damián Ortega', 'damian.ortega@example.com', 'México', '2024-02-27', 'https://example.com/avatars/damian.jpg', '+525512345686'),
('Mónica Herrera', 'monica.herrera@example.com', 'Argentina', '2024-02-28', 'https://example.com/avatars/monica.jpg', '+5491167891242'),
('Arturo Ramos', 'arturo.ramos@example.com', 'Chile', '2024-02-29', 'https://example.com/avatars/arturo.jpg', '+569987654329'),
('Laura Escobar', 'laura.escobar@example.com', 'Colombia', '2024-03-01', 'https://example.com/avatars/laura.jpg', '+573212345686'),
('Roberto Paredes', 'roberto.paredes@example.com', 'Uruguay', '2024-03-02', 'https://example.com/avatars/roberto.jpg', '+59891234575'),
('Diana Vega', 'diana.vega@example.com', 'Perú', '2024-03-03', 'https://example.com/avatars/diana.jpg', '+51987654329'),
('Marcos Navarro', 'marcos.navarro@example.com', 'España', '2024-03-04', 'https://example.com/avatars/marcos.jpg', '+34678901243'),
('Luciana López', 'luciana.lopez@example.com', 'México', '2024-03-05', 'https://example.com/avatars/luciana.jpg', '+525512345687'),
('Guillermo Díaz', 'guillermo.diaz@example.com', 'Argentina', '2024-03-06', 'https://example.com/avatars/guillermo.jpg', '+5491167891243'),
('Patricia Romero', 'patricia.romero@example.com', 'Chile', '2024-03-07', 'https://example.com/avatars/patricia.jpg', '+569987654330'),
('Fernando Álvarez', 'fernando.alvarez@example.com', 'Colombia', '2024-03-08', 'https://example.com/avatars/fernando.jpg', '+573212345687'),
('Isabel Méndez', 'isabel.mendez@example.com', 'Uruguay', '2024-03-09', 'https://example.com/avatars/isabel.jpg', '+59891234576'),
('Ricardo Torres', 'ricardo.torres@example.com', 'Perú', '2024-03-10', 'https://example.com/avatars/ricardo.jpg', '+51987654330'),
('Cecilia Sánchez', 'cecilia.sanchez@example.com', 'España', '2024-03-11', 'https://example.com/avatars/cecilia.jpg', '+34678901244'),
('Eduardo Jiménez', 'eduardo.jimenez@example.com', 'México', '2024-03-12', 'https://example.com/avatars/eduardo.jpg', '+525512345688'),
('Florencia Pérez', 'florencia.perez@example.com', 'Argentina', '2024-03-13', 'https://example.com/avatars/florencia.jpg', '+5491167891244'),
('Oscar Castillo', 'oscar.castillo@example.com', 'Chile', '2024-03-14', 'https://example.com/avatars/oscar.jpg', '+569987654331'),
('Adriana Vargas', 'adriana.vargas@example.com', 'Colombia', '2024-03-15', 'https://example.com/avatars/adriana.jpg', '+573212345688'),
('Vicente Martínez', 'vicente.martinez@example.com', 'Uruguay', '2024-03-16', 'https://example.com/avatars/vicente.jpg', '+59891234577'),
('Silvia Herrera', 'silvia.herrera@example.com', 'Perú', '2024-03-17', 'https://example.com/avatars/silvia.jpg', '+51987654331'),
('Andrés Gil', 'andres.gil@example.com', 'España', '2024-03-18', 'https://example.com/avatars/andres.jpg', '+34678901245'),
('Clara Ortiz', 'clara.ortiz@example.com', 'México', '2024-03-19', 'https://example.com/avatars/clara.jpg', '+525512345689'),
('Leonardo Fernández', 'leonardo.fernandez@example.com', 'Argentina', '2024-03-20', 'https://example.com/avatars/leonardo.jpg', '+5491167891245'),
('Gabriela Ramos', 'gabriela.ramos@example.com', 'Chile', '2024-03-21', 'https://example.com/avatars/gabriela.jpg', '+569987654332'),
('Raúl Acosta', 'raul.acosta@example.com', 'Colombia', '2024-03-22', 'https://example.com/avatars/raul.jpg', '+573212345689'),
('Daniela Fuentes', 'daniela.fuentes@example.com', 'Uruguay', '2024-03-23', 'https://example.com/avatars/daniela.jpg', '+59891234578'),
('Ignacio Méndez', 'ignacio.mendez@example.com', 'Perú', '2024-03-24', 'https://example.com/avatars/ignacio.jpg', '+51987654332'),
('Elisa Blanco', 'elisa.blanco@example.com', 'España', '2024-03-25', 'https://example.com/avatars/elisa.jpg', '+34678901246'),
('Cristina Delgado', 'cristina.delgado@example.com', 'México', '2024-03-26', 'https://example.com/avatars/cristina.jpg', '+525512345690'),
('Estela Fernández', 'estela.fernandez@example.com', 'Argentina', '2024-03-27', 'https://example.com/avatars/estela.jpg', '+5491167891246'),
('Marco Vargas', 'marco.vargas@example.com', 'Chile', '2024-03-28', 'https://example.com/avatars/marco.jpg', '+569987654333'),
('Gloria Sánchez', 'gloria.sanchez@example.com', 'Colombia', '2024-03-29', 'https://example.com/avatars/gloria.jpg', '+573212345690'),
('Hernán Martínez', 'hernan.martinez@example.com', 'Uruguay', '2024-03-30', 'https://example.com/avatars/hernan.jpg', '+59891234579'),
('Rocío Herrera', 'rocio.herrera@example.com', 'Perú', '2024-03-31', 'https://example.com/avatars/rocio.jpg', '+51987654333'),
('Ramón Gil', 'ramon.gil@example.com', 'España', '2024-04-01', 'https://example.com/avatars/ramon.jpg', '+34678901247'),
('Lorena Escobar', 'lorena.escobar@example.com', 'México', '2024-04-02', 'https://example.com/avatars/lorena.jpg', '+525512345691'),
('Juan Ramírez', 'juan.ramirez@example.com', 'Argentina', '2024-04-03', 'https://example.com/avatars/juan.jpg', '+5491167891247'),
('Rafaela Blanco', 'rafaela.blanco@example.com', 'Chile', '2024-04-04', 'https://example.com/avatars/rafaela.jpg', '+569987654334'),
('Nicolás Torres', 'nicolas.torres@example.com', 'Colombia', '2024-04-05', 'https://example.com/avatars/nicolas.jpg', '+573212345691'),
('Fabiola Fuentes', 'fabiola.fuentes@example.com', 'Uruguay', '2024-04-06', 'https://example.com/avatars/fabiola.jpg', '+59891234580'),
('Andrés Méndez', 'andres.mendez@example.com', 'Perú', '2024-04-07', 'https://example.com/avatars/andres.jpg', '+51987654334'),
('Lidia Delgado', 'lidia.delgado@example.com', 'España', '2024-04-08', 'https://example.com/avatars/lidia.jpg', '+34678901248'),
('Iván Cruz', 'ivan.cruz@example.com', 'México', '2024-04-09', 'https://example.com/avatars/ivan.jpg', '+525512345692'),
('Camila Martínez', 'camila.martinez@example.com', 'Argentina', '2024-04-10', 'https://example.com/avatars/camila.jpg', '+5491167891248'),
('Alberto Gil', 'alberto.gil@example.com', 'Chile', '2024-04-11', 'https://example.com/avatars/alberto.jpg', '+569987654335'),
('Yolanda Vargas', 'yolanda.vargas@example.com', 'Colombia', '2024-04-12', 'https://example.com/avatars/yolanda.jpg', '+573212345692'),
('Sergio Ramos', 'sergio.ramos@example.com', 'Uruguay', '2024-04-13', 'https://example.com/avatars/sergio.jpg', '+59891234581'),
('Natalia Méndez', 'natalia.mendez@example.com', 'Perú', '2024-04-14', 'https://example.com/avatars/natalia.jpg', '+51987654335'),
('Pedro Ortega', 'pedro.ortega@example.com', 'España', '2024-04-15', 'https://example.com/avatars/pedro.jpg', '+34678901249'),
('Carmen Sánchez', 'carmen.sanchez@example.com', 'México', '2024-04-16', 'https://example.com/avatars/carmen.jpg', '+525512345693'),
('Elena Jiménez', 'elena.jimenez@example.com', 'Argentina', '2024-04-17', 'https://example.com/avatars/elena.jpg', '+5491167891249'),
('Hugo Vargas', 'hugo.vargas@example.com', 'Chile', '2024-04-18', 'https://example.com/avatars/hugo.jpg', '+569987654336'),
('Lucía Torres', 'lucia.torres@example.com', 'Colombia', '2024-04-19', 'https://example.com/avatars/lucia.jpg', '+573212345693'),
('Federico Fuentes', 'federico.fuentes@example.com', 'Uruguay', '2024-04-20', 'https://example.com/avatars/federico.jpg', '+59891234582'),
('Miriam Delgado', 'miriam.delgado@example.com', 'Perú', '2024-04-21', 'https://example.com/avatars/miriam.jpg', '+51987654336'),
('Adriana Martínez', 'adriana.martinez@example.com', 'España', '2024-04-22', 'https://example.com/avatars/adriana.jpg', '+34678901250'),
('Rubén Sánchez', 'ruben.sanchez@example.com', 'México', '2024-04-23', 'https://example.com/avatars/ruben.jpg', '+525512345694'),
('María Vargas', 'maria.vargas@example.com', 'Argentina', '2024-04-24', 'https://example.com/avatars/maria.jpg', '+5491167891250'),
('Jorge Gil', 'jorge.gil@example.com', 'Chile', '2024-04-25', 'https://example.com/avatars/jorge.jpg', '+569987654337'),
('Isabel Herrera', 'isabel.herrera@example.com', 'Colombia', '2024-04-26', 'https://example.com/avatars/isabel.jpg', '+573212345694'),
('Rafael Paredes', 'rafael.paredes@example.com', 'Uruguay', '2024-04-27', 'https://example.com/avatars/rafael.jpg', '+59891234583'),
('Laure Escobar', 'laure.escobar@example.com', 'Perú', '2024-04-28', 'https://example.com/avatars/laura.jpg', '+51987654337'),
('Esther Jiménez', 'esther.jimenez@example.com', 'España', '2024-04-29', 'https://example.com/avatars/esther.jpg', '+34678901251'),
('Cristian Martínez', 'cristian.martinez@example.com', 'México', '2024-04-30', 'https://example.com/avatars/cristian.jpg', '+525512345695'),
('Tania Fuentes', 'tania.fuentes@example.com', 'Argentina', '2024-05-01', 'https://example.com/avatars/tania.jpg', '+5491167891251'),
('Vicente Gil', 'vicente.gil@example.com', 'Chile', '2024-05-02', 'https://example.com/avatars/vicente.jpg', '+569987654338'),
('Soledad Vargas', 'soledad.vargas@example.com', 'Colombia', '2024-05-03', 'https://example.com/avatars/soledad.jpg', '+573212345695'),
('Antonio Blanco', 'antonio.blanco@example.com', 'Uruguay', '2024-05-04', 'https://example.com/avatars/antonio.jpg', '+59891234584'),
('Rosa Delgado', 'rosa.delgado@example.com', 'Perú', '2024-05-05', 'https://example.com/avatars/rosa.jpg', '+51987654338'),
('Diego Escobar', 'diego.escobar@example.com', 'España', '2024-05-06', 'https://example.com/avatars/diego.jpg', '+34678901252'),
('Ángela Sánchez', 'angela.sanchez@example.com', 'México', '2024-05-07', 'https://example.com/avatars/angela.jpg', '+525512345696'),
('Fernando Jiménez', 'fernando.jimenez@example.com', 'Argentina', '2024-05-08', 'https://example.com/avatars/fernando.jpg', '+5491167891252'),
('Mónica Torres', 'monica.torres@example.com', 'Chile', '2024-05-09', 'https://example.com/avatars/monica.jpg', '+569987654339'),
('Javier Vargas', 'javier.vargas@example.com', 'Colombia', '2024-05-10', 'https://example.com/avatars/javier.jpg', '+573212345696'),
('Susana Martínez', 'susana.martinez@example.com', 'Uruguay', '2024-05-11', 'https://example.com/avatars/susana.jpg', '+59891234585'),
('Anabel Herrera', 'anabel.herrera@example.com', 'Perú', '2024-05-12', 'https://example.com/avatars/anabel.jpg', '+51987654339'),
('Félix Martínez', 'felix.martinez@example.com', 'España', '2024-05-13', 'https://example.com/avatars/felix.jpg', '+34678901253'),
('Cecilia Jiménez', 'cecilia.jimenez@example.com', 'México', '2024-05-14', 'https://example.com/avatars/cecilia.jpg', '+525512345697'),
('Guadalupe Martínez', 'guadalupe.martinez@example.com', 'Argentina', '2024-05-15', 'https://example.com/avatars/guadalupe.jpg', '+5491167891253'),
('Enrique Martínez', 'enrique.martinez@example.com', 'Chile', '2024-05-16', 'https://example.com/avatars/enrique.jpg', '+569987654340'),
('Mariana Vargas', 'mariana.vargas@example.com', 'Colombia', '2024-05-17', 'https://example.com/avatars/mariana.jpg', '+573212345697'),
('Amalia Fuentes', 'amalia.fuentes@example.com', 'Uruguay', '2024-05-18', 'https://example.com/avatars/amalia.jpg', '+59891234586'),
('Patricio Herrera', 'patricio.herrera@example.com', 'Perú', '2024-05-19', 'https://example.com/avatars/patricio.jpg', '+51987654340'),
('Lorena Vargas', 'lorena.vargas@example.com', 'España', '2024-05-20', 'https://example.com/avatars/lorena.jpg', '+34678901254'),
('Esteban Jiménez', 'esteban.jimenez@example.com', 'México', '2024-05-21', 'https://example.com/avatars/esteban.jpg', '+525512345698'),
('Rosa Blanco', 'rosa.blanco@example.com', 'Argentina', '2024-05-22', 'https://example.com/avatars/rosa.jpg', '+5491167891254'),
('Miguel Paredes', 'miguel.paredes@example.com', 'Chile', '2024-05-23', 'https://example.com/avatars/miguel.jpg', '+569987654341'),
('Elena Escobar', 'elena.escobar@example.com', 'Colombia', '2024-05-24', 'https://example.com/avatars/elena.jpg', '+573212345698'),
('José Gil', 'jose.gil@example.com', 'Uruguay', '2024-05-25', 'https://example.com/avatars/jose.jpg', '+59891234587'),
('Luisa Delgado', 'luisa.delgado@example.com', 'Perú', '2024-05-26', 'https://example.com/avatars/luisa.jpg', '+51987654341'),
('César Sánchez', 'cesar.sanchez@example.com', 'España', '2024-05-27', 'https://example.com/avatars/cesar.jpg', '+34678901255'),
('Andrea Ramírez', 'andrea.ramirez@example.com', 'México', '2024-05-28', 'https://example.com/avatars/andrea.jpg', '+525512345699'),
('Luis Torres', 'luis.torres@example.com', 'Argentina', '2024-05-29', 'https://example.com/avatars/luis.jpg', '+5491167891255'),
('Gabriela Herrera', 'gabriela.herrera@example.com', 'Chile', '2024-05-30', 'https://example.com/avatars/gabriela.jpg', '+569987654342'),
('Francisco Fuentes', 'francisco.fuentes@example.com', 'Colombia', '2024-05-31', 'https://example.com/avatars/francisco.jpg', '+573212345699'),
('Carla Gil', 'carla.gil@example.com', 'Uruguay', '2024-06-01', 'https://example.com/avatars/carla.jpg', '+59891234588'),
('Renata Jiménez', 'renata.jimenez@example.com', 'Perú', '2024-06-02', 'https://example.com/avatars/renata.jpg', '+51987654342'),
('Ignacio Vargas', 'ignacio.vargas@example.com', 'España', '2024-06-03', 'https://example.com/avatars/ignacio.jpg', '+34678901256'),
('Isabel Martínez', 'isabel.martinez@example.com', 'México', '2024-06-04', 'https://example.com/avatars/isabel.jpg', '+525512345700'),
('Octavio Blanco', 'octavio.blanco@example.com', 'Argentina', '2024-06-05', 'https://example.com/avatars/octavio.jpg', '+5491167891256'),
('Daniela Escobar', 'daniela.escobar@example.com', 'Chile', '2024-06-06', 'https://example.com/avatars/daniela.jpg', '+569987654343'),
('Emilio Delgado', 'emilio.delgado@example.com', 'Colombia', '2024-06-07', 'https://example.com/avatars/emilio.jpg', '+573212345700'),
('Marisol Torres', 'marisol.torres@example.com', 'Uruguay', '2024-06-08', 'https://example.com/avatars/marisol.jpg', '+59891234589');

-- Inserciones en la tabla resena
INSERT INTO resena (id_juego, id_usuario, puntuacion, comentario, fecha) VALUES
(5, 1, 95, 'Un juego revolucionario. Absolutamente imprescindible.', '2023-06-01'),
(6, 2, 90, 'Una secuela épica. Gran mejora respecto al anterior.', '2023-07-15'),
(8, 3, 87, 'La creatividad de este juego es increíble.', '2023-08-10'),
(10, 4, 89, 'Excelente estilo y jugabilidad fluida.', '2023-08-20'),
(11, 5, 92, 'Difícil pero gratificante. Una joya indie.', '2023-09-05'),
(12, 6, 88, 'Arte visual impresionante y gameplay entretenido.', '2023-09-10'),
(13, 1, 93, 'Ideal para relajarse. Una experiencia única.', '2023-09-15'),
(14, 2, 85, 'Buena historia, pero un poco corto.', '2023-09-20'),
(16, 3, 84, 'Un juego sólido, aunque esperaba más.', '2023-10-01'),
(18, 4, 96, 'Horas y horas de diversión en esta isla.', '2023-10-05'),
(19, 5, 94, 'Un RPG de mundo abierto simplemente espectacular.', '2023-10-10'),
(20, 6, 91, 'Estrategia y narrativa perfectamente combinadas.', '2023-10-15'),
(21, 7, 88, 'Gran historia y mecánicas fluidas.', '2023-10-20'),
(22, 8, 90, 'Monstruos épicos y gran diseño de niveles.', '2023-10-25'),
(23, 9, 82, 'Divertido con amigos, pero se vuelve repetitivo.', '2023-11-01'),
(24, 10, 89, 'Acción frenética y gráficos increíbles.', '2023-11-05'),
(25, 11, 95, 'Una obra maestra de narrativa y emociones.', '2023-11-10'),
(26, 12, 85, 'Divertido, pero el matchmaking podría mejorar.', '2023-11-15'),
(27, 1, 93, 'Un roguelike adictivo con un gran diseño.', '2023-11-20'),
(28, 2, 90, 'Una historia profunda y conmovedora.', '2023-11-25'),
(29, 3, 94, 'Mundo abierto fascinante y desafiante.', '2023-12-01'),
(30, 4, 79, 'Narrativa sólida y mecánicas divertidas.', '2023-12-05'),
(31, 5, 80, 'Simpático, pero un poco superficial.', '2023-12-10'),
(32, 6, 89, 'Perfecto para jugar con amigos.', '2023-12-15'),
(33, 7, 92, 'Gráficos impresionantes y carreras emocionantes.', '2023-12-20'),
(34, 8, 86, 'Un concepto único, pero a veces frustrante.', '2023-12-25'),
(35, 9, 90, 'Pura creatividad en cada nivel.', '2024-01-01'),
(36, 10, 88, 'Historia oscura y mecánicas de juego interesantes.', '2024-01-05'),
(37, 11, 84, 'Visualmente impresionante, pero algo corto.', '2024-01-10'),
(38, 12, 94, 'Un clásico moderno con puzzles geniales.', '2024-01-15'),
(39, 1, 87, 'Una reimaginación fiel pero innovadora.', '2024-01-20'),
(40, 2, 96, 'Un RPG elegante y profundo.', '2024-01-25'),
(41, 3, 85, 'Mecánicas originales y buena exploración.', '2024-02-01'),
(42, 4, 90, 'Desafiante y con combates precisos.', '2024-02-05'),
(43, 5, 91, 'Una mezcla interesante de humor y acción.', '2024-02-10'),
(44, 6, 89, 'Un mundo inmersivo con muchas posibilidades.', '2024-02-15'),
(45, 7, 84, 'Un buen roguelike, aunque algo repetitivo.', '2024-02-20'),
(46, 8, 92, 'Original, desafiante y visualmente impactante.', '2024-02-25'),
(47, 9, 88, 'Gran concepto, pero la ejecución podría mejorar.', '2024-03-01'),
(48, 10, 93, 'Oscuro y fascinante, un juego de culto.', '2024-03-05'),
(49, 11, 90, 'Cooperativo excepcional y muy bien diseñado.', '2024-03-10'),
(50, 12, 89, 'Diversión garantizada en cada carrera.', '2024-03-15'),
(51, 1, 94, 'Una locura de acción y personajes icónicos.', '2024-03-20'),
(52, 2, 87, 'Rápido, frenético y muy competitivo.', '2024-03-25'),
(53, 3, 90, 'Juego en equipo con gran atención al detalle.', '2024-04-01'),
(54, 4, 83, 'Divertido, aunque no para todos los gustos.', '2024-04-05'),
(55, 5, 89, 'Un battle royale entretenido.', '2024-04-10'),
(56, 6, 85, 'Interesante, pero con una curva de aprendizaje alta.', '2024-04-15'),
(57, 7, 91, 'Acción en primera persona al máximo nivel.', '2024-04-20'),
(58, 8, 93, 'Un survival horror moderno y bien ejecutado.', '2024-04-25'),
(59, 9, 94, 'Una obra maestra de Nintendo.', '2024-05-01'),
(60, 10, 88, 'Visualmente hermoso y con gran jugabilidad.', '2024-05-05'),
(61, 11, 86, 'Divertido, pero un poco repetitivo.', '2024-05-10'),
(62, 12, 89, 'Un shooter intenso con gran historia.', '2024-05-15'),
(63, 1, 84, 'Encantador y lleno de magia.', '2024-05-20'),
(64, 2, 87, 'Narrativa única y mecánicas innovadoras.', '2024-05-25'),
(65, 3, 90, 'Una experiencia de bucle temporal brillante.', '2024-06-01'),
(3, 4, 93, 'Carreras de mundo abierto y paisajes espectaculares.', '2024-06-05'),
(66, 5, 88, 'Un remake fiel y visualmente impactante.', '2024-06-10'),
(67, 6, 90, 'Un juego mágico con gran atención al detalle.', '2024-06-15'),
(68, 7, 92, 'Un RPG espacial impresionante.', '2024-06-20'),
(4, 8, 95, 'Un juego que define el género de aventuras.', '2024-06-25'),
(69, 9, 87, 'Visualmente atractivo y entretenido.', '2024-07-01'),
(70, 10, 89, 'Luchas intensas y gran diseño.', '2024-07-05'),
(71, 11, 93, 'Un ARPG épico con contenido interminable.', '2024-07-10'),
(72, 12, 96, 'Una narrativa brillante y combates profundos.', '2024-07-15'),
(73, 1, 85, 'Entretenido, pero no tan innovador.', '2024-07-20'),
(74, 2, 88, 'Oscuro y atmosférico. Muy recomendable.', '2024-07-25'),
(15, 3, 94, 'Un juego que establece nuevos estándares.', '2024-08-01'),
(75, 4, 91, 'Ideal para los fanáticos del fútbol.', '2024-08-05'),
(76, 5, 89, 'Una entrega sólida de la saga.', '2024-08-10'),
(77, 6, 90, 'Una expansión que eleva el juego base.', '2024-08-15'),
(9, 7, 87, 'Emocionante y prometedor.', '2024-08-20'),
(78, 8, 92, 'Una entrega muy esperada y gratificante.', '2024-08-25'),
(79, 9, 85, 'Interesante, pero se siente incompleto.', '2024-09-01'),
(80, 10, 94, 'El mundo abierto más ambicioso jamás creado.', '2024-09-05'),
(81, 11, 95, 'Una obra maestra del mundo criminal.', '2024-09-10'),
(82, 12, 88, 'Un remake bien ejecutado.', '2024-09-15'),
(17, 1, 93, 'Una continuación esperada que no decepciona.', '2024-09-20'),
(83, 2, 90, 'Narrativa excelente y visualmente impresionante.', '2024-09-25'),
(84, 3, 86, 'Un juego prometedor con gran potencial.', '2024-10-01'),
(1, 4, 89, 'Un indie sobresaliente con gran corazón.', '2024-10-05');

-- Reseñas negativas
INSERT INTO resena (id_juego, id_usuario, puntuacion, comentario, fecha) VALUES
(18, 5, 30, 'Monótono y aburrido, esperaba mucho más.', '2024-10-06'),
(33, 6, 40, 'El rendimiento técnico deja mucho que desear.', '2024-10-07'),
(46, 10, 25, 'La mecánica de juego es confusa y frustrante.', '2024-10-08'),
(58, 11, 35, 'Un diseño anticuado que no innova.', '2024-10-09'),
(55, 12, 20, 'Poco equilibrado y lleno de bugs.', '2024-10-10'),
(15, 2, 45, 'El contenido es repetitivo y sin inspiración.', '2024-10-11'),
(76, 3, 10, 'Realmente no vale la pena el tiempo invertido.', '2024-10-12'),
(63, 4, 38, 'La historia prometía más de lo que entrega.', '2024-10-13'),
(67, 7, 15, 'No cumple con los estándares de calidad actuales.', '2024-10-14'),
(47, 8, 25, 'Desbalanceado y con errores persistentes.', '2024-10-15'),
(50, 9, 35, 'Repetitivo y sin innovación alguna.', '2024-10-16'),
(79, 1, 28, 'Demasiado corto y sin desarrollo significativo.', '2024-10-17'),
(17, 6, 20, 'Las expectativas eran altas, pero resultó decepcionante.', '2024-10-18'),
(70, 12, 45, 'La jugabilidad es torpe y poco atractiva.', '2024-10-19'),
(9, 10, 30, 'Poco esfuerzo en el diseño de niveles.', '2024-10-20'),
(30, 11, 10, 'Un desperdicio de potencial en todos los aspectos.', '2024-10-21'),
(42, 12, 20, 'El combate es tedioso y la historia plana.', '2024-10-22'),
(22, 5, 18, 'Parece inacabado y lleno de errores.', '2024-10-23'),
(48, 7, 40, 'Gráficos mediocres y jugabilidad básica.', '2024-10-24'),
(32, 8, 35, 'Un concepto interesante, pero mal ejecutado.', '2024-10-25');

INSERT INTO resena (id_juego, id_usuario, puntuacion, comentario, fecha)
VALUES
(32, 10, 40, 'Mucho potencial, pero decepciona en casi todo.', '2024-10-26'),
(32, 12, 28, 'Bugs constantes y rendimiento pésimo.', '2024-10-27'),
(32, 15, 45, 'La historia no engancha y los gráficos son mediocres.', '2024-10-28'),
(32, 16, 33, 'Esperaba más, me aburrí en la primera hora.', '2024-10-29'),
(32, 19, 22, 'No se puede jugar bien, muy mal optimizado.', '2024-10-30'),
(32, 20, 15, 'Una decepción total. Dinero tirado.', '2024-11-01'),
(32, 21, 39, 'Se hace repetitivo muy rápido.', '2024-11-02'),
(32, 22, 48, 'Solo salva la música. Lo demás es un desastre.', '2024-11-03'),
(32, 23, 29, 'Ideas buenas, ejecución pésima.', '2024-11-04'),
(32, 24, 20, 'Me obligué a terminarlo, pero no lo recomiendo.', '2024-11-05');

-- Reseñas negativas para el juego J0011
INSERT INTO resena (id_juego, id_usuario, puntuacion, comentario, fecha) VALUES
(19, 25, 40, 'Prometía mucho, pero se queda corto.', '2024-11-06'),
(19, 26, 38, 'Controles poco intuitivos y sin emoción.', '2024-11-07'),
(19, 27, 45, 'Muy repetitivo y sin profundidad.', '2024-11-08');

-- Reseñas negativas para el juego J0015
INSERT INTO resena (id_juego, id_usuario, puntuacion, comentario, fecha) VALUES
(23, 28, 30, 'Gráficos decentes, pero jugabilidad aburrida.', '2024-11-09'),
(23, 29, 20, 'Crash constante, injugable.', '2024-11-10'),
(23, 30, 42, 'Lo terminé por compromiso, no por diversión.', '2024-11-11');

-- Reseñas negativas para el juego J0018
INSERT INTO resena (id_juego, id_usuario, puntuacion, comentario, fecha) VALUES
(26, 31, 18, 'El peor juego que he comprado este año.', '2024-11-12'),
(26, 32, 33, 'El ritmo es muy lento y mal estructurado.', '2024-11-13'),
(26, 33, 44, 'Corto, caro y mal optimizado.', '2024-11-14');

-- Reseñas negativas para el juego J0020
INSERT INTO resena (id_juego, id_usuario, puntuacion, comentario, fecha) VALUES
(28, 34, 39, 'El modo historia es muy pobre.', '2024-11-15'),
(28, 35, 25, 'Nada que ver con lo prometido en los tráilers.', '2024-11-16'),
(28, 36, 30, 'Solo lo salva la banda sonora.', '2024-11-17');

-- Reseñas negativas para el juego J0022
INSERT INTO resena (id_juego, id_usuario, puntuacion, comentario, fecha) VALUES
(30, 37, 29, 'Un clon barato de otros juegos mejores.', '2024-11-18'),
(30, 38, 41, 'Nada memorable, lo olvidé en dos días.', '2024-11-19'),
(30, 39, 34, 'Mecánicas rotas y falta de contenido.', '2024-11-20');


-- Inserciones en la tabla compra
INSERT INTO compra (id_usuario, id_juego, fecha_compra, metodo_pago) VALUES
(1, 5, '2024-01-15', 'Tarjeta de Crédito'),
(2, 6, '2024-02-10', 'PayPal'),
(3, 8, '2024-03-12', 'Transferencia Bancaria'),
(4, 10, '2024-04-08', 'Tarjeta de Débito'),
(5, 11, '2024-05-20', 'Tarjeta de Crédito'),
(6, 12, '2024-06-15', 'PayPal'),
(7, 13, '2024-07-10', 'Tarjeta de Débito'),
(8, 14, '2024-08-18', 'Transferencia Bancaria'),
(9, 16, '2024-09-22', 'Tarjeta de Crédito'),
(10, 18, '2024-10-01', 'PayPal'),
(11, 19, '2024-01-20', 'Tarjeta de Débito'),
(12, 20, '2024-02-14', 'Tarjeta de Crédito'),
(1, 21, '2024-03-03', 'PayPal'),
(2, 22, '2024-04-19', 'Transferencia Bancaria'),
(3, 23, '2024-05-23', 'Tarjeta de Crédito'),
(4, 24, '2024-06-11', 'Tarjeta de Débito'),
(5, 25, '2024-07-30', 'PayPal'),
(6, 26, '2024-08-09', 'Tarjeta de Crédito'),
(7, 27, '2024-09-25', 'Tarjeta de Débito'),
(8, 28, '2024-10-15', 'Transferencia Bancaria'),
(9, 29, '2024-01-10', 'Tarjeta de Crédito'),
(10, 30, '2024-02-08', 'PayPal'),
(11, 31, '2024-03-06', 'Tarjeta de Débito'),
(12, 32, '2024-04-03', 'Transferencia Bancaria'),
(1, 33, '2024-05-01', 'Tarjeta de Crédito'),
(2, 34, '2024-06-12', 'PayPal'),
(3, 35, '2024-07-18', 'Tarjeta de Débito'),
(4, 36, '2024-08-29', 'Transferencia Bancaria'),
(5, 37, '2024-09-30', 'Tarjeta de Crédito'),
(6, 38, '2024-10-05', 'PayPal'),
(13, 39, '2024-01-15', 'Tarjeta de Débito'),
(14, 40, '2024-02-11', 'Transferencia Bancaria'),
(15, 41, '2024-03-05', 'Tarjeta de Crédito'),
(16, 42, '2024-04-08', 'PayPal'),
(17, 43, '2024-05-22', 'Tarjeta de Débito'),
(18, 44, '2024-06-15', 'Transferencia Bancaria'),
(19, 45, '2024-07-09', 'Tarjeta de Crédito'),
(20, 46, '2024-08-17', 'PayPal'),
(21, 47, '2024-09-14', 'Tarjeta de Débito'),
(22, 48, '2024-10-01', 'Transferencia Bancaria'),
(23, 49, '2024-01-10', 'Tarjeta de Crédito'),
(24, 50, '2024-02-18', 'PayPal'),
(25, 51, '2024-03-22', 'Tarjeta de Débito'),
(26, 52, '2024-04-20', 'Transferencia Bancaria'),
(27, 53, '2024-05-15', 'Tarjeta de Crédito'),
(28, 54, '2024-06-18', 'PayPal'),
(29, 55, '2024-07-14', 'Tarjeta de Débito'),
(30, 56, '2024-08-10', 'Transferencia Bancaria'),
(31, 57, '2024-09-07', 'Tarjeta de Crédito'),
(32, 58, '2024-10-01', 'PayPal'),
(33, 59, '2024-01-20', 'Tarjeta de Débito'),
(34, 60, '2024-02-10', 'Transferencia Bancaria'),
(35, 61, '2024-03-15', 'Tarjeta de Crédito'),
(36, 62, '2024-04-11', 'PayPal'),
(37, 63, '2024-05-20', 'Tarjeta de Débito'),
(38, 64, '2024-06-22', 'Transferencia Bancaria'),
(39, 65, '2024-07-18', 'Tarjeta de Crédito'),
(40, 3, '2024-08-12', 'PayPal'),
(41, 66, '2024-09-25', 'Tarjeta de Débito'),
(42, 67, '2024-10-14', 'Transferencia Bancaria'),
(43, 68, '2024-01-19', 'Tarjeta de Crédito'),
(44, 4, '2024-02-15', 'PayPal'),
(45, 69, '2024-03-13', 'Tarjeta de Débito'),
(46, 70, '2024-04-10', 'Transferencia Bancaria'),
(47, 71, '2024-05-25', 'Tarjeta de Crédito'),
(48, 72, '2024-06-29', 'PayPal'),
(49, 73, '2024-07-13', 'Tarjeta de Débito'),
(50, 74, '2024-08-15', 'Tarjeta de crédito'),
(51, 15, '2024-09-12', 'PayPal'),
(52, 75, '2024-10-05', 'Transferencia bancaria'),
(53, 76, '2024-01-28', 'Tarjeta de crédito'),
(54, 77, '2024-02-18', 'PayPal'),
(55, 9, '2024-03-22', 'Tarjeta de crédito'),
(56, 78, '2024-04-19', 'Tarjeta de crédito'),
(57, 79, '2024-05-20', 'PayPal'),
(58, 80, '2024-06-15', 'Transferencia bancaria'),
(59, 81, '2024-07-08', 'Tarjeta de crédito'),
(60, 82, '2024-08-12', 'PayPal'),
(61, 17, '2024-09-14', 'Tarjeta de crédito'),
(62, 83, '2024-10-20', 'Transferencia bancaria'),
(63, 84, '2024-01-18', 'PayPal'),
(64, 1, '2024-02-11', 'Tarjeta de crédito'),
(65, 85, '2024-03-07', 'PayPal'),
(66, 86, '2024-04-03', 'Tarjeta de crédito'),
(67, 87, '2024-05-10', 'Transferencia bancaria'),
(68, 88, '2024-06-14', 'PayPal'),
(69, 89, '2024-07-05', 'Tarjeta de crédito'),
(70, 90, '2024-08-09', 'PayPal'),
(71, 91, '2024-09-21', 'Tarjeta de crédito'),
(72, 92, '2024-10-18', 'Transferencia bancaria'),
(73, 93, '2024-01-24', 'PayPal'),
(74, 94, '2024-02-20', 'Tarjeta de crédito'),
(75, 95, '2024-03-18', 'PayPal'),
(76, 96, '2024-04-17', 'Transferencia bancaria'),
(77, 97, '2024-05-22', 'Tarjeta de crédito'),
(78, 98, '2024-06-26', 'PayPal'),
(79, 99, '2024-07-19', 'Tarjeta de crédito'),
(82, 102, '2024-10-29', 'Tarjeta de crédito'),
(84, 104, '2024-02-14', 'Transferencia bancaria'),
(85, 105, '2024-03-10', 'Tarjeta de crédito'),
(86, 106, '2024-04-13', 'PayPal'),
(87, 107, '2024-05-19', 'Tarjeta de crédito'),
(88, 108, '2024-06-20', 'Transferencia bancaria'),
(89, 109, '2024-07-18', 'PayPal'),
(90, 110, '2024-08-25', 'Tarjeta de crédito'),
(91, 111, '2024-09-27', 'Transferencia bancaria'),
(92, 112, '2024-10-15', 'Tarjeta de crédito'),
(93, 113, '2024-01-23', 'PayPal'),
(94, 114, '2024-02-17', 'Tarjeta de crédito'),
(95, 115, '2024-03-19', 'Transferencia bancaria'),
(96, 116, '2024-04-21', 'PayPal'),
(98, 118, '2024-06-22', 'Transferencia bancaria'),
(99, 119, '2024-07-16', 'PayPal'),
(100, 120, '2024-08-08', 'Tarjeta de crédito'),
(101, 121, '2024-09-15', 'PayPal'),
(102, 122, '2024-10-10', 'Transferencia bancaria'),
(103, 123, '2024-01-13', 'Tarjeta de crédito'),
(104, 124, '2024-02-18', 'PayPal'),
(105, 125, '2024-03-24', 'Transferencia bancaria'),
(106, 126, '2024-04-30', 'Tarjeta de crédito'),
(107, 127, '2024-05-20', 'Efectivo'),
(108, 128, '2024-06-10', 'Tarjeta de crédito'),
(109, 129, '2024-07-05', 'PayPal'),
(110, 130, '2024-08-15', 'Tarjeta de crédito'),
(111, 131, '2024-09-19', 'Transferencia bancaria'),
(112, 7, '2024-10-04', 'PayPal'),
(113, 132, '2024-01-14', 'Efectivo'),
(114, 133, '2024-02-20', 'Tarjeta de crédito'),
(115, 134, '2024-03-18', 'PayPal'),
(116, 135, '2024-04-27', 'Transferencia bancaria'),
(117, 136, '2024-05-31', 'Tarjeta de crédito'),
(118, 137, '2024-06-23', 'Efectivo'),
(119, 138, '2024-07-15', 'PayPal'),
(120, 139, '2024-08-07', 'Tarjeta de crédito'),
(121, 140, '2024-09-20', 'Transferencia bancaria'),
(122, 141, '2024-10-17', 'PayPal'),
(123, 2, '2024-01-30', 'Tarjeta de crédito'),
(124, 142, '2024-02-25', 'Transferencia bancaria'),
(125, 143, '2024-03-15', 'Efectivo'),
(126, 144, '2024-04-12', 'PayPal'),
(127, 145, '2024-05-21', 'Tarjeta de crédito'),
(128, 146, '2024-06-19', 'Transferencia bancaria'),
(129, 147, '2024-07-09', 'Efectivo'),
(130, 148, '2024-08-28', 'PayPal'),
(131, 149, '2024-09-14', 'Tarjeta de crédito'),
(132, 150, '2024-10-25', 'Transferencia bancaria'),
(133, 5, '2024-01-22', 'Efectivo'),
(134, 6, '2024-02-16', 'PayPal'),
(135, 8, '2024-03-11', 'Tarjeta de crédito'),
(136, 10, '2024-04-18', 'Transferencia bancaria'),
(137, 11, '2024-05-12', 'PayPal'),
(138, 12, '2024-06-26', 'Tarjeta de crédito'),
(139, 13, '2024-07-18', 'Transferencia bancaria'),
(140, 14, '2024-08-30', 'Efectivo'),
(141, 16, '2024-09-23', 'PayPal'),
(142, 18, '2024-10-08', 'Tarjeta de crédito'),
(143, 19, '2024-01-05', 'Transferencia bancaria'),
(144, 20, '2024-02-20', 'Efectivo'),
(145, 21, '2024-03-25', 'PayPal'),
(146, 22, '2024-04-21', 'Tarjeta de crédito'),
(147, 23, '2024-05-10', 'Transferencia bancaria'),
(148, 24, '2024-06-22', 'PayPal'),
(149, 25, '2024-07-19', 'Tarjeta de crédito'),
(150, 26, '2024-08-14', 'Transferencia bancaria'),
(151, 27, '2024-09-30', 'Efectivo'),
(152, 28, '2024-10-03', 'PayPal'),
(153, 29, '2024-01-09', 'Tarjeta de crédito'),
(154, 30, '2024-02-15', 'Transferencia bancaria'),
(155, 31, '2024-03-20', 'PayPal'),
(156, 32, '2024-04-27', 'Tarjeta de crédito'),
(157, 33, '2024-05-31', 'Transferencia bancaria'),
(158, 34, '2024-06-18', 'PayPal'),
(159, 35, '2024-07-25', 'Efectivo'),
(160, 36, '2024-08-30', 'Tarjeta de crédito'),
(161, 37, '2024-09-17', 'Transferencia bancaria'),
(162, 38, '2024-10-29', 'PayPal'),
(163, 39, '2024-01-20', 'Tarjeta de crédito'),
(164, 40, '2024-02-12', 'PayPal'),
(165, 41, '2024-03-15', 'Transferencia bancaria'),
(166, 42, '2024-04-22', 'Tarjeta de débito'),
(167, 43, '2024-05-19', 'Efectivo'),
(168, 44, '2024-06-25', 'Tarjeta de crédito'),
(169, 45, '2024-07-08', 'PayPal'),
(170, 46, '2024-08-19', 'Transferencia bancaria'),
(171, 47, '2024-09-11', 'Tarjeta de débito'),
(172, 48, '2024-10-07', 'Efectivo'),
(173, 49, '2024-01-29', 'Tarjeta de crédito'),
(174, 50, '2024-02-23', 'PayPal'),
(175, 51, '2024-03-17', 'Transferencia bancaria'),
(176, 52, '2024-04-16', 'Tarjeta de débito'),
(177, 53, '2024-05-12', 'Efectivo'),
(178, 54, '2024-06-14', 'Tarjeta de crédito'),
(179, 55, '2024-07-07', 'PayPal'),
(180, 56, '2024-08-04', 'Transferencia bancaria'),
(181, 57, '2024-09-27', 'Tarjeta de débito'),
(182, 58, '2024-10-20', 'Efectivo'),
(182, 59, '2024-01-18', 'Tarjeta de crédito'),
(182, 60, '2024-02-21', 'PayPal'),
(182, 61, '2024-03-09', 'Transferencia bancaria'),
(182, 62, '2024-04-24', 'Tarjeta de débito'),
(182, 63, '2024-05-13', 'Efectivo'),
(182, 64, '2024-06-15', 'Tarjeta de crédito'),
(182, 65, '2024-07-02', 'PayPal'),
(182, 3, '2024-08-13', 'Transferencia bancaria'),
(182, 66, '2024-09-06', 'Tarjeta de débito'),
(182, 67, '2024-10-12', 'Efectivo'),
(182, 68, '2024-01-07', 'Tarjeta de crédito'),
(182, 4, '2024-02-14', 'PayPal'),
(182, 69, '2024-03-16', 'Transferencia bancaria'),
(182, 70, '2024-04-10', 'Tarjeta de débito'),
(182, 71, '2024-05-22', 'Efectivo'),
(182, 72, '2024-06-11', 'Tarjeta de crédito'),
(182, 73, '2024-07-28', 'PayPal'),
(182, 74, '2024-08-21', 'Transferencia bancaria'),
(201, 15, '2024-09-25', 'Tarjeta de débito'),
(202, 75, '2024-10-19', 'Efectivo'),
(203, 76, '2024-01-28', 'Tarjeta de crédito'),
(204, 77, '2024-02-17', 'PayPal'),
(205, 9, '2024-03-30', 'Transferencia bancaria'),
(206, 78, '2024-04-29', 'Tarjeta de débito'),
(207, 79, '2024-05-23', 'Efectivo'),
(208, 80, '2024-06-20', 'Tarjeta de crédito'),
(209, 81, '2024-07-22', 'PayPal'),
(210, 82, '2024-08-10', 'Transferencia bancaria'),
(211, 17, '2024-09-19', 'Tarjeta de débito'),
(212, 83, '2024-10-16', 'Efectivo'),
(213, 84, '2024-01-12', 'Tarjeta de crédito'),
(214, 1, '2024-02-26', 'PayPal'),
(215, 85, '2024-03-06', 'Transferencia bancaria'),
(216, 86, '2024-04-04', 'Tarjeta de débito'),
(217, 87, '2024-05-30', 'Efectivo'),
(218, 88, '2024-06-08', 'Tarjeta de crédito'),
(200, 89, '2024-07-14', 'PayPal'),
(210, 150, '2024-07-14', 'PayPal'),
(100, 150, '2024-07-14', 'PayPal'),
(1, 150, '2024-07-14', 'PayPal'),
(202, 150, '2024-07-14', 'PayPal'),
(203, 150, '2024-07-14', 'PayPal'),
(211, 150, '2024-07-14', 'PayPal'),
(215, 150, '2024-07-14', 'PayPal'),
(218, 150, '2024-07-14', 'PayPal'),
(199, 150, '2024-07-14', 'PayPal'),
(199, 5, '2024-07-14', 'PayPal'),
(201, 134, '2024-03-20', 'Tarjeta de crédito'),
(202, 134, '2024-03-22', 'PayPal'),
(203, 135, '2024-04-28', 'Efectivo'),
(204, 135, '2024-05-01', 'Transferencia bancaria'),
(205, 136, '2024-06-02', 'Tarjeta de crédito'),
(206, 136, '2024-06-05', 'PayPal'),
(207, 137, '2024-07-01', 'Tarjeta de crédito'),
(208, 137, '2024-07-10', 'Efectivo'),
(209, 138, '2024-07-18', 'Transferencia bancaria'),
(210, 139, '2024-08-09', 'PayPal'),
(211, 139, '2024-08-10', 'Tarjeta de crédito'),
(212, 140, '2024-09-22', 'Transferencia bancaria'),
(213, 140, '2024-09-25', 'Efectivo'),
(214, 141, '2024-10-19', 'PayPal'),
(215, 2, '2024-01-31', 'Tarjeta de crédito'),
(216, 2, '2024-02-02', 'PayPal'),
(217, 142, '2024-02-27', 'Transferencia bancaria'),
(218, 143, '2024-03-17', 'Efectivo'),
(219, 144, '2024-04-14', 'PayPal'),
(220, 145, '2024-05-22', 'Tarjeta de crédito'),
(221, 146, '2024-06-20', 'Transferencia bancaria'),
(222, 147, '2024-07-10', 'Efectivo'),
(221, 148, '2024-08-30', 'PayPal'),
(220, 149, '2024-09-15', 'Tarjeta de crédito'),
-- Compras adicionales para J0133
(110, 134, '2024-03-21', 'PayPal'),
(111, 134, '2024-03-23', 'Transferencia bancaria'),
(112, 134, '2024-03-24', 'Efectivo'),
(113, 134, '2024-03-25', 'Tarjeta de crédito'),

-- Compras adicionales para J0134
(114, 135, '2024-04-29', 'PayPal'),
(115, 135, '2024-04-30', 'Transferencia bancaria'),
(116, 135, '2024-05-02', 'Efectivo'),
(117, 135, '2024-05-03', 'Tarjeta de crédito'),
(118, 135, '2024-05-04', 'PayPal'),

-- Compras adicionales para J0135
(119, 136, '2024-05-31', 'Tarjeta de crédito'),
(120, 136, '2024-06-01', 'Transferencia bancaria'),
(121, 136, '2024-06-03', 'Efectivo'),
(122, 136, '2024-06-04', 'PayPal'),

-- Compras adicionales para J0136
(123, 137, '2024-06-24', 'Tarjeta de crédito'),
(124, 137, '2024-06-25', 'Transferencia bancaria'),
(125, 137, '2024-06-26', 'PayPal'),
(126, 137, '2024-06-27', 'Efectivo'),

-- Compras adicionales para J0137
(127, 138, '2024-07-16', 'Transferencia bancaria'),
(128, 138, '2024-07-17', 'PayPal'),
(129, 138, '2024-07-18', 'Efectivo'),

-- Compras adicionales para J0138
(130, 139, '2024-08-08', 'Tarjeta de crédito'),
(131, 139, '2024-08-09', 'PayPal'),
(132, 139, '2024-08-10', 'Transferencia bancaria'),
(133, 139, '2024-08-11', 'Efectivo'),
(134, 139, '2024-08-12', 'Tarjeta de crédito'),

-- Compras adicionales para J0139
(135, 140, '2024-09-21', 'PayPal'),
(136, 140, '2024-09-22', 'Transferencia bancaria'),
(137, 140, '2024-09-23', 'Tarjeta de crédito'),

-- Compras adicionales para J0140
(138, 141, '2024-10-18', 'PayPal'),
(139, 141, '2024-10-19', 'Transferencia bancaria'),
(140, 141, '2024-10-20', 'Efectivo'),

-- Compras adicionales para J0141
(141, 2, '2024-02-01', 'Tarjeta de crédito'),
(142, 2, '2024-02-03', 'PayPal'),
(143, 2, '2024-02-04', 'Transferencia bancaria'),

-- Compras adicionales para J0142
(144, 142, '2024-02-26', 'Efectivo'),
(145, 142, '2024-02-28', 'Tarjeta de crédito'),
(146, 142, '2024-02-29', 'PayPal'),

-- Compras adicionales para J0143
(147, 143, '2024-03-16', 'Transferencia bancaria'),
(148, 143, '2024-03-17', 'Efectivo'),
(149, 143, '2024-03-18', 'PayPal'),

-- Compras adicionales para J0144
(150, 144, '2024-04-13', 'Tarjeta de crédito'),
(151, 144, '2024-04-14', 'Transferencia bancaria'),

-- Compras adicionales para J0145
(152, 145, '2024-05-22', 'Efectivo'),
(153, 145, '2024-05-23', 'Tarjeta de crédito'),
(154, 145, '2024-05-24', 'PayPal'),

-- Compras adicionales para J0146
(155, 146, '2024-06-20', 'Transferencia bancaria'),
(156, 146, '2024-06-21', 'Tarjeta de crédito'),

-- Compras adicionales para J0147
(157, 147, '2024-07-11', 'Efectivo'),
(158, 147, '2024-07-12', 'PayPal'),

-- Compras adicionales para J0148
(159, 148, '2024-08-29', 'Transferencia bancaria'),
(160, 148, '2024-08-30', 'Tarjeta de crédito'),

-- Compras adicionales para J0149
(161, 149, '2024-09-16', 'PayPal'),
(162, 149, '2024-09-17', 'Efectivo'),
(163, 149, '2024-09-18', 'Tarjeta de crédito'),

-- Compras adicionales para J0150
(164, 150, '2024-10-16', 'PayPal'),
(165, 150, '2024-11-17', 'Efectivo'),
(166, 150, '2024-12-18', 'Tarjeta de crédito');

-- Inserciones para la tabla wishlist
INSERT INTO wishlist (id_usuario, id_juego, fecha_agregado) VALUES
(63, 81, '2024-03-17'),
(64, 81, '2024-03-18'),
(65, 81, '2024-03-19'),
(66, 66, '2024-03-20'),
(67, 67, '2024-03-21'),
(68, 68, '2024-03-22'),
(69, 1, '2024-03-23'),
(70, 1, '2024-03-24'),
(71, 1, '2024-03-25'),
(72, 1, '2024-03-26'),
(73, 1, '2024-03-27'),
(74, 1, '2024-03-28'),
(75, 74, '2024-03-29'),
(76, 81, '2024-03-30'),
(77, 81, '2024-03-31'),
(78, 76, '2024-04-01'),
(79, 77, '2024-04-02'),
(80, 9, '2024-04-03'),
(81, 78, '2024-04-04'),
(82, 79, '2024-04-05'),
(83, 80, '2024-04-06'),
(84, 81, '2024-04-07'),
(85, 82, '2024-04-08'),
(86, 81, '2024-04-09'),
(87, 83, '2024-04-10'),
(88, 1, '2024-04-11'),
(89, 1, '2024-04-12'),
(90, 1, '2024-04-13'),
(91, 1, '2024-04-14'),
(92, 17, '2024-04-15'),
(93, 17, '2024-04-16'),
(94, 89, '2024-04-17'),
(95, 81, '2024-04-18'),
(96, 81, '2024-04-19'),
(97, 92, '2024-04-20'),
(98, 93, '2024-04-21'),
(99, 94, '2024-04-22'),
(100, 95, '2024-04-23'),
(101, 96, '2024-04-24'),
(102, 97, '2024-04-25'),
(103, 98, '2024-04-26'),
(104, 99, '2024-04-27'),
(105, 17, '2024-04-28'),
(106, 17, '2024-04-29'),
(107, 17, '2024-04-30'),
(108, 81, '2024-05-01'),
(109, 81, '2024-05-02'),
(110, 81, '2024-05-03'),
(111, 106, '2024-05-04'),
(112, 107, '2024-05-05'),
(113, 108, '2024-05-06'),
(114, 109, '2024-05-07'),
(115, 17, '2024-05-08'),
(116, 111, '2024-05-09'),
(117, 112, '2024-05-10'),
(118, 113, '2024-05-11'),
(119, 114, '2024-05-12'),
(120, 81, '2024-05-13'),
(121, 81, '2024-05-14'),
(122, 81, '2024-05-15'),
(123, 118, '2024-05-16'),
(124, 119, '2024-05-17'),
(125, 81, '2024-05-18'),
(126, 81, '2024-05-19'),
(127, 81, '2024-05-20'),
(128, 81, '2024-05-21'),
(129, 124, '2024-05-22'),
(130, 125, '2024-05-23'),
(131, 126, '2024-05-24'),
(132, 127, '2024-05-25'),
(133, 128, '2024-05-26'),
(134, 129, '2024-05-27'),
(135, 130, '2024-05-28'),
(136, 131, '2024-05-29'),
(137, 81, '2024-05-30'),
(138, 81, '2024-05-31'),
(139, 81, '2024-06-01'),
(140, 81, '2024-06-02'),
(141, 135, '2024-06-03'),
(142, 136, '2024-06-04'),
(143, 81, '2024-06-05'),
(144, 81, '2024-06-06'),
(145, 139, '2024-06-07'),
(146, 140, '2024-06-08'),
(147, 141, '2024-06-09'),
(148, 2, '2024-06-10'),
(149, 142, '2024-06-11'),
(150, 143, '2024-06-12'),
(151, 144, '2024-06-13'),
(152, 145, '2024-06-14'),
(153, 146, '2024-06-15'),
(154, 147, '2024-06-16'),
(155, 148, '2024-06-17'),
(156, 149, '2024-06-18'),
(157, 150, '2024-06-19'),
(158, 64, '2024-06-20'),
(159, 65, '2024-06-21'),
(160, 3, '2024-06-22'),
(161, 66, '2024-06-23'),
(162, 67, '2024-06-24'),
(163, 68, '2024-06-25'),
(164, 4, '2024-06-26'),
(165, 69, '2024-06-27'),
(166, 70, '2024-06-28'),
(167, 71, '2024-06-29'),
(168, 72, '2024-06-30'),
(169, 73, '2024-07-01'),
(170, 74, '2024-07-02'),
(171, 15, '2024-07-03'),
(172, 75, '2024-07-04'),
(173, 76, '2024-07-05'),
(174, 77, '2024-07-06'),
(175, 9, '2024-07-07'),
(176, 78, '2024-07-08'),
(177, 79, '2024-07-09'),
(178, 80, '2024-07-10'),
(179, 81, '2024-07-11'),
(180, 82, '2024-07-12'),
(181, 17, '2024-07-13'),
(182, 83, '2024-07-14'),
(183, 84, '2024-07-15'),
(184, 1, '2024-07-16'),
(185, 85, '2024-07-17'),
(186, 86, '2024-07-18'),
(187, 87, '2024-07-19'),
(188, 88, '2024-07-20'),
(189, 89, '2024-07-21'),
(190, 90, '2024-07-22'),
(191, 91, '2024-07-23'),
(192, 92, '2024-07-24'),
(193, 93, '2024-07-25'),
(194, 94, '2024-07-26'),
(195, 95, '2024-07-27'),
(196, 96, '2024-07-28'),
(197, 97, '2024-07-29'),
(198, 98, '2024-07-30'),
(199, 99, '2024-07-31'),
(200, 100, '2024-08-01'),
(201, 101, '2024-08-02'),
(202, 102, '2024-08-03'),
(203, 103, '2024-08-04'),
(204, 104, '2024-08-05'),
(205, 105, '2024-08-06'),
(206, 106, '2024-08-07'),
(207, 107, '2024-08-08'),
(208, 108, '2024-08-09'),
(209, 109, '2024-08-10'),
(210, 110, '2024-08-11'),
(211, 111, '2024-08-12'),
(212, 112, '2024-08-13'),
(213, 113, '2024-08-14'),
(214, 114, '2024-08-15'),
(215, 115, '2024-08-16'),
(216, 116, '2024-08-17');

-- Insertar datos en la tabla desarrollador
INSERT INTO desarrollador (nombre, pais_origen, continente, ceo, numero_trabajadores, fundacion, sitio_web) VALUES
('Nintendo', 'Japón', 'Asia', 'Shuntaro Furukawa', 6674, 1889, 'https://www.nintendo.co.jp'),
('Santa Monica Studio', 'Estados Unidos', 'América', 'Yumi Yang', 250, 1999, 'https://sms.playstation.com'),
('Team Cherry', 'Australia', 'Oceanía', 'William Pellen', 15, 2017, 'https://www.teamcherry.com.au'),
('Maddy Makes Games', 'Canadá', 'América', 'Maddy Thorson', 5, 2013, 'https://www.maddymakesgames.com'),
('Studio MDHR', 'Canadá', 'América', 'Chad Moldenhauer', 20, 2013, 'https://www.studiomdhr.com'),
('ConcernedApe', 'Estados Unidos', 'América', 'Eric Barone', 1, 2012, 'https://www.concernedape.com'),
('Naughty Dog', 'Estados Unidos', 'América', 'Neil Druckmann', 350, 1984, 'https://www.naughtydog.com'),
('Insomniac Games', 'Estados Unidos', 'América', 'Ted Price', 400, 1994, 'https://www.insomniacgames.com'),
('CD Projekt Red', 'Polonia', 'Europa', 'Adam Kiciński', 1200, 2002, 'https://www.cdprojekt.com'),
('Intelligent Systems', 'Japón', 'Asia', 'Toru Narihiro', 150, 1983, 'https://www.intsys.co.jp'),
('Moon Studios', 'Austria', 'Europa', 'Thomas Mahler', 80, 2010, 'https://www.orithegame.com'),
('Capcom', 'Japón', 'Asia', 'Haruhiro Tsujimoto', 2800, 1979, 'https://www.capcom.co.jp'),
('Innersloth', 'Estados Unidos', 'América', 'Marcus Bromander', 15, 2015, 'https://www.innersloth.com'),
('id Software', 'Estados Unidos', 'América', 'Marty Stratton', 300, 1991, 'https://www.idsoftware.com'),
('Supergiant Games', 'Estados Unidos', 'América', 'Amir Rao', 20, 2009, 'https://www.supergiantgames.com'),
('ZA/UM', 'Estonia', 'Europa', 'Ilmar Kompus', 35, 2016, 'https://www.zaumstudio.com'),
('FromSoftware', 'Japón', 'Asia', 'Hidetaka Miyazaki', 300, 1986, 'https://www.fromsoftware.jp'),
('Mojang Studios', 'Suecia', 'Europa', 'Helen Chiang', 600, 2009, 'https://www.minecraft.net'),
('Mediatonic', 'Reino Unido', 'Europa', 'Dave Bailey', 300, 2005, 'https://www.mediatonicgames.com'),
('Playground Games', 'Reino Unido', 'Europa', 'Trevor Williams', 300, 2010, 'https://www.playground-games.com'),
('Rockstar Games', 'Estados Unidos', 'América', 'Sam Houser', 2000, 1998, 'https://www.rockstargames.com'),
('Blizzard Entertainment', 'Estados Unidos', 'América', 'Mike Ybarra', 4700, 1991, 'https://www.blizzard.com'),
('Riot Games', 'Estados Unidos', 'América', 'Nicolo Laurent', 3000, 2006, 'https://www.riotgames.com'),
('Square Enix', 'Japón', 'Asia', 'Yosuke Matsuda', 5300, 1986, 'https://www.square-enix.com'),
('Ubisoft', 'Francia', 'Europa', 'Yves Guillemot', 20000, 1986, 'https://www.ubisoft.com'),
('Larian Studios', 'Bélgica', 'Europa', 'Swen Vincke', 400, 1996, 'https://www.larian.com'),
('Team Asobi', 'Japón', 'Asia', 'Nicolas Doucet', 80, 2012, 'https://www.teamasobi.com'),
('Hello Games', 'Reino Unido', 'Europa', 'Sean Murray', 30, 2008, 'https://www.hellogames.org'),
('Supermassive Games', 'Reino Unido', 'Europa', 'Pete Samuels', 300, 2008, 'https://www.supermassivegames.com'),
('BioWare', 'Canadá', 'América', 'Gary McKay', 200, 1995, 'https://www.bioware.com'),
('Valve', 'Estados Unidos', 'América', 'Gabe Newell', 360, 1996, 'https://www.valvesoftware.com'),
('Infinity Ward', 'Estados Unidos', 'América', 'Patrick Kelly', 450, 2002, 'https://www.infinityward.com'),
('Tarsier Studios', 'Suecia', 'Europa', 'Andreas Johnsson', 80, 2004, 'https://www.tarsier.se'),
('Arkane Studios', 'Francia', 'Europa', 'Raphael Colantonio', 120, 1999, 'https://www.arkane-studios.com'),
('BlueTwelve Studio', 'Francia', 'Europa', NULL, 15, 2016, 'https://www.bluetwelvestudio.com'),
('Obsidian Entertainment', 'Estados Unidos', 'América', 'Feargus Urquhart', 230, 2003, 'https://www.obsidian.net'),
('MegaCrit', 'Estados Unidos', 'América', NULL, 20, 2017, 'https://www.megacrit.com'),
('Splashteam', 'Francia', 'Europa', NULL, 25, 2018, 'https://splashteam.fr'),
('Yacht Club Games', 'Estados Unidos', 'América', 'Sean Velasco', 30, 2011, 'https://www.yachtclubgames.com'),
('Nicalis', 'Estados Unidos', 'América', 'Tyrone Rodriguez', 50, 2007, 'https://www.nicalis.com'),
('Night School Studio', 'Estados Unidos', 'América', 'Sean Krankel', 30, 2014, 'https://www.nightschoolstudio.com'),
('Toby Fox', 'Estados Unidos', 'América', 'Toby Fox', 1, 2015, 'https://tobyfox.net'),
('Jonathan Blow', 'Estados Unidos', 'América', 'Jonathan Blow', 10, 2008, 'https://thekla.com'),
('Campo Santo', 'Estados Unidos', 'América', 'Sean Vanaman', 12, 2013, 'https://www.camposanto.com'),
('Frictional Games', 'Suecia', 'Europa', 'Thomas Grip', 25, 2007, 'https://frictionalgames.com'),
('Massive Monster', 'Australia', 'Oceanía', 'Julian Wilton', 15, 2017, 'https://www.massivemonster.co'),
('Lucas Pope', 'Estados Unidos', 'América', 'Lucas Pope', 1, 2013, 'https://dukope.com'),
('WayForward', 'Estados Unidos', 'América', 'Voldi Way', 200, 1990, 'https://wayforward.com'),
('Team Meat', 'Estados Unidos', 'América', 'Tommy Refenes', 2, 2010, 'https://supermeatboy.com'),
('Askiisoft', 'Canadá', 'América', NULL, 5, 2008, 'https://askiisoft.com'),
('Re-Logic', 'Estados Unidos', 'América', 'Andrew Spinks', 12, 2011, 'https://terraria.org'),
('Wube Software', 'República Checa', 'Europa', NULL, 30, 2012, 'https://factorio.com'),
('Coffee Stain Studios', 'Suecia', 'Europa', 'Albert Säfström', 90, 2010, 'https://coffeestainstudios.com'),
('Angel Matrix', 'Estados Unidos', 'América', NULL, 15, 2018, 'https://angelmatrix.com'),
('Geometric Interactive', 'Dinamarca', 'Europa', 'Jeppe Carlsen', 8, 2019, 'https://www.geometricinteractive.com'),
('GSC Game World', 'Ucrania', 'Europa', 'Sergey Grigorovich', 300, 1995, 'https://gsc-game.com'),
('The Indie Stone', 'Reino Unido', 'Europa', NULL, 15, 2009, 'https://projectzomboid.com'),
('Unknown Worlds Entertainment', 'Estados Unidos', 'América', NULL, 50, 2001, 'https://unknownworlds.com'),
('Vanillaware', 'Japón', 'Asia', 'George Kamitani', 30, 2002, 'https://www.vanillaware.co.jp'),
('Double Fine Productions', 'Estados Unidos', 'América', 'Tim Schafer', 65, 2000, 'https://www.doublefine.com'),
('Asobo Studio', 'Francia', 'Europa', 'Sebastian Wloch', 250, 2002, 'https://www.asobostudio.com'),
('Red Hook Studios', 'Canadá', 'América', 'Chris Bourassa', 15, 2013, 'https://www.redhookgames.com'),
('Mobius Digital', 'Estados Unidos', 'América', 'Masi Oka', 15, 2013, 'https://www.mobiusdigitalgames.com'),
('Thatgamecompany', 'Estados Unidos', 'América', 'Jenova Chen', 80, 2006, 'https://thatgamecompany.com'),
('Kojima Productions', 'Japón', 'Asia', 'Hideo Kojima', 150, 2015, 'https://www.kojimaproductions.jp/en'),
('Housemarque', 'Finlandia', 'Europa', 'Ilari Kuittinen', 100, 1995, 'https://housemarque.com'),
('Playdead', 'Dinamarca', 'Europa', NULL, 50, 2006, 'https://playdead.com'),
('Finji', 'Estados Unidos', 'América', NULL, 20, 2014, 'https://finji.co'),
('Greg Lobanov Studio', 'Canadá', 'América', 'Greg Lobanov', 10, 2020, 'https://greglobanov.com'),
('Ryu Ga Gotoku Studio', 'Japón', 'Asia', 'Masayoshi Yokoyama', 300, 2011, 'https://ryu-ga-gotoku.com'),
('Gears for Breakfast', 'Dinamarca', 'Europa', 'Jonas Kaerlev', 15, 2013, 'https://www.gearsforbreakfast.com'),
('Nomada Studio', 'España', 'Europa', 'Conrad Roset', 10, 2016, 'https://nomadastudio.eu'),
('Monolith Soft', 'Japón', 'Asia', 'Hitoshi Yamagami', 275, 1999, 'https://www.monolithsoft.co.jp'),
('Psyonix', 'Estados Unidos', 'América', 'Dave Hagewood', 132, 2000, 'https://www.psyonix.com'),
('Atlus', 'Japón', 'Asia', 'Naoto Hiraoka', 450, 1986, 'https://www.atlus.com'),
('Motion Twin', 'Francia', 'Europa', 'Julien Barnoin', 10, 2001, 'https://www.motion-twin.com'),
('Hazelight Studios', 'Suecia', 'Europa', 'Josef Fares', 60, 2014, 'https://www.hazelight.se'),
('Respawn Entertainment', 'Estados Unidos', 'América', 'Vince Zampella', 300, 2010, 'https://www.respawn.com'),
('Epic Games', 'Estados Unidos', 'América', 'Tim Sweeney', 3500, 1991, 'https://www.epicgames.com'),
('343 Industries', 'Estados Unidos', 'América', 'Bonnie Ross', 500, 2007, 'https://www.halowaypoint.com'),
('Ember Lab', 'Estados Unidos', 'América', 'Mike Grier', 30, 2009, 'https://www.emberlab.com'),
('Portkey Games', 'Reino Unido', 'Europa', 'Rachel Wakley', 100, 2017, 'https://www.portkeygames.com'),
('Bethesda Game Studios', 'Estados Unidos', 'América', 'Todd Howard', 420, 2001, 'https://bethesda.net'),
('Remedy Entertainment', 'Finlandia', 'Europa', 'Tero Virtala', 300, 1995, 'https://www.remedygames.com'),
('EA Sports', 'Estados Unidos', 'América', 'Cam Weber', 800, 1991, 'https://www.ea.com/ea-sports'),
('Aspyr', 'Estados Unidos', 'América', 'Ted Staloch', 120, 1996, 'https://www.aspyr.com'),
('The Initiative', 'Estados Unidos', 'América', 'Darryl Gallagher', 75, 2018, 'https://www.theinitiative.com'),
('Ninja Theory', 'Reino Unido', 'Europa', 'Tameem Antoniades', 150, 2000, 'https://www.ninjatheory.com'),
('Sloclap', 'Francia', 'Europa', 'Pierre Tarno', 50, 2015, 'https://www.sloclap.com'),
('HAL Laboratory', 'Japón', 'Asia', 'Shigefumi Kawase', 170, 1980, 'https://www.hallab.co.jp'),
('PlatinumGames', 'Japón', 'Asia', 'Atsushi Inaba', 300, 2006, 'https://www.platinumgames.com'),
('Striking Distance Studios', 'Estados Unidos', 'América', 'Glen Schofield', 150, 2019, 'https://www.sds.com'),
('WB Games Montréal', 'Canadá', 'América', 'Marie-Pierre Ducharme', 340, 2010, 'https://wbgamesmontreal.com'),
('Techland', 'Polonia', 'Europa', 'Paweł Marchewka', 400, 1991, 'https://techland.net'),
('Tango Gameworks', 'Japón', 'Asia', 'Shinji Mikami', 120, 2010, 'https://www.tangogameworks.com'),
('Artdink', 'Japón', 'Asia', 'Takashi Hasegawa', 50, 1986, 'https://www.artdink.co.jp'),
('Guerrilla Games', 'Países Bajos', 'Europa', 'Angie Smets', 400, 2000, 'https://www.guerrilla-games.com'),
('Acid Nerve', 'Reino Unido', 'Europa', NULL, 10, 2014, 'https://www.acidnerve.com'),
('Pixpil', 'China', 'Asia', 'Hong Yu', 20, 2016, 'https://www.pixpil.com'),
('Next Level Games', 'Canadá', 'América', 'Douglas Tronsgard', 80, 2002, 'https://www.nextlevelgames.com'),
('Luca Galante', 'Italia', 'Europa', 'Luca Galante', 1, 2020, 'https://www.poncle.co.uk'),
('Endnight Games', 'Canadá', 'América', 'Ben Falcone', 20, 2013, 'https://endnightgames.com');

INSERT INTO amistad (id_amigo1, id_amigo2) VALUES
(1, 23),
(1, 45),
(2, 34),
(2, 56),
(3, 67),
(3, 78),
(4, 89),
(4, 10),
(5, 111),
(5, 22),
(6, 33),
(6, 44),
(7, 55),
(7, 66),
(8, 77),
(8, 88),
(9, 99),
(9, 100),
(10, 11),
(10, 22),
(11, 33),
(11, 44),
(12, 55),
(12, 66),
(13, 77),
(13, 88),
(14, 99),
(14, 100),
(15, 16),
(15, 27),
(16, 38),
(16, 49),
(17, 50),
(17, 61),
(18, 72),
(18, 83),
(19, 94),
(19, 105),
(20, 116),
(20, 127),
(21, 138),
(21, 149),
(22, 150),
(22, 161),
(23, 172),
(23, 183),
(24, 194),
(24, 205),
(25, 216),
(51, 108),
(51, 109),
(52, 110),
(52, 111),
(53, 112),
(53, 113),
(54, 114),
(54, 115),
(55, 116),
(55, 117),
(56, 118),
(56, 119),
(57, 120),
(57, 121),
(58, 122),
(58, 123),
(59, 124),
(59, 125),
(60, 126),
(60, 127),
(61, 128),
(61, 129),
(62, 130),
(62, 131),
(63, 132),
(63, 133),
(64, 134),
(64, 135),
(65, 136),
(65, 137),
(66, 138),
(66, 139),
(67, 140),
(67, 141),
(68, 142),
(68, 143),
(69, 144),
(69, 145),
(70, 146),
(70, 147),
(71, 148),
(71, 149),
(72, 150),
(72, 151),
(73, 152),
(73, 153),
(74, 154),
(74, 155),
(75, 156),
(75, 157),
(76, 158),
(76, 159),
(77, 160),
(77, 161),
(78, 162),
(78, 163),
(79, 164),
(79, 165),
(80, 166),
(80, 167),
(81, 168),
(81, 169),
(82, 170),
(82, 171),
(83, 172),
(83, 173),
(84, 174),
(84, 175),
(85, 176),
(85, 177),
(86, 178),
(86, 179),
(87, 180),
(87, 181),
(88, 182),
(88, 183),
(89, 184),
(89, 185),
(90, 186),
(90, 187),
(91, 188),
(91, 189),
(92, 190),
(92, 191),
(93, 192),
(93, 193),
(94, 194),
(94, 195),
(95, 196),
(95, 197),
(96, 198),
(96, 199),
(97, 200),
(97, 201),
(98, 202),
(98, 203),
(99, 204),
(99, 205),
(100, 206),
(100, 207);

INSERT INTO juego_desarrollador (id_juego, id_desarrollador) VALUES
    (5, 1),  -- The Legend of Zelda: Breath of the Wild - Nintendo
    (6, 2),  -- God of War Ragnarök - Santa Monica Studio
    (8, 1),  -- Super Mario Odyssey - Nintendo
    (10, 3),  -- Hollow Knight - Team Cherry
    (11, 4),  -- Celeste - Maddy Makes Games
    (12, 5),  -- Cuphead - Studio MDHR
    (13, 6),  -- Stardew Valley - ConcernedApe
    (14, 7),  -- Uncharted 4: A Thief's End - Naughty Dog
    (16, 8),  -- Marvel's Spider-Man - Insomniac Games
    (18, 1),  -- Animal Crossing: New Horizons - Nintendo
    (19, 9),  -- The Witcher 3: Wild Hunt - CD Projekt Red
    (20, 10),  -- Fire Emblem: Three Houses - Intelligent Systems
    (21, 11),  -- Ori and the Will of the Wisps - Moon Studios
    (22, 12),  -- Monster Hunter: World - Capcom
    (23, 13),  -- Among Us - Innersloth
    (24, 14),  -- DOOM Eternal - id Software
    (25, 7),  -- The Last of Us Part II - Naughty Dog
    (26, 1),  -- Splatoon 3 - Nintendo
    (27, 15),  -- Hades - Supergiant Games
    (28, 16),  -- Disco Elysium - ZA/UM
    (29, 17),  -- Elden Ring - FromSoftware
    (30, 73),  -- Xenoblade Chronicles 3 - Monolith Soft
    (31, 18),  -- Minecraft Dungeons - Mojang Studios
    (32, 19),  -- Fall Guys - Mediatonic
    (33, 20),  -- Forza Horizon 4 - Playground Games
    (34, 74),  -- Rocket League - Psyonix
    (35, 64),  -- Journey - Thatgamecompany
    (36, 67),  -- Inside - Playdead
    (37, 33),  -- Little Nightmares - Tarsier Studios
    (38, 31),  -- Portal 2 - Valve
    (39, 24),  -- Final Fantasy VII Remake - Square Enix
    (40, 75),  -- Persona 5 Royal - Atlus
    (41, 68),  -- Tunic - Finji
    (42, 17),  -- Sekiro: Shadows Die Twice - FromSoftware
    (43, 70),  -- Yakuza Like a Dragon - Ryu Ga Gotoku Studio
    (44, 9),  -- Cyberpunk 2077 - CD Projekt Red
    (45, 76),  -- Dead Cells - Motion Twin
    (46, 63),  -- Outer Wilds - Mobius Digital
    (47, 28),  -- No Man's Sky - Hello Games
    (48, 17),  -- Bloodborne - FromSoftware
    (49, 77),  -- It Takes Two - Hazelight Studios
    (50, 1),  -- Mario Kart 8 Deluxe - Nintendo
    (51, 1),  -- Super Smash Bros. Ultimate - Nintendo
    (52, 78),  -- Apex Legends - Respawn Entertainment
    (53, 22),  -- Overwatch - Blizzard Entertainment
    (54, 23),  -- League of Legends - Riot Games
    (55, 79),  -- Fortnite - Epic Games
    (56, 23),  -- Valorant - Riot Games
    (57, 32),  -- Call of Duty: Modern Warfare - Infinity Ward
    (58, 12),  -- Resident Evil Village - Capcom
    (59, 1),  -- Metroid Dread - Nintendo
    (60, 8),  -- Ratchet & Clank: Rift Apart - Insomniac Games
    (61, 80),  -- Halo Infinite - 343 Industries
    (62, 66),  -- Returnal - Housemarque
    (63, 81),  -- Kena: Bridge of Spirits - Ember Lab
    (64, 60),  -- Psychonauts 2 - Double Fine Productions
    (65, 34),  -- Deathloop - Arkane Studios
    (3, 20),  -- Forza Horizon 5 - Playground Games
    (66, 12),  -- Resident Evil 4 Remake - Capcom
    (67, 82),  -- Hogwarts Legacy - Portkey Games
    (68, 83),  -- Starfield - Bethesda Game Studios
    (4, 1),  -- The Legend of Zelda: Tears of the Kingdom - Nintendo
    (69, 24),  -- Final Fantasy XVI - Square Enix
    (70, 12),  -- Street Fighter 6 - Capcom
    (71, 22),  -- Diablo IV - Blizzard Entertainment
    (72, 26),  -- Baldur's Gate III - Larian Studios
    (73, 25),  -- Assassin's Creed Mirage - Ubisoft
    (74, 84),  -- Alan Wake II - Remedy Entertainment
    (15, 8),  -- Marvel's Spider-Man 2 - Insomniac Games
    (75, 85),  -- EA Sports FC 24 - EA Sports
    (76, 32),  -- Call of Duty: Black Ops 6 - Infinity Ward
    (77, 17),  -- Elden Ring: Shadow of the Erdtree - FromSoftware
    (9, 15),  -- Hades II - Supergiant Games
    (78, 1),  -- Metroid Prime 4 - Nintendo
    (79, 20),  -- Fable - Playground Games
    (80, 83),  -- The Elder Scrolls VI - Bethesda Game Studios
    (81, 21),  -- Grand Theft Auto VI - Rockstar Games
    (82, 86),  -- Star Wars: Knights of the Old Republic Remake - Aspyr
    (17, 9),  -- The Witcher 4 - CD Projekt Red
    (83, 30),  -- Dragon Age: The Veilguard - BioWare
    (84, 87),  -- Perfect Dark - The Initiative
    (1, 3),  -- Hollow Knight: Silksong - Team Cherry
    (85, 36),  -- Avowed - Obsidian Entertainment
    (86, 88),  -- Hellblade II: Senua's Saga - Ninja Theory
    (87, 56),  -- Stalker 2: Heart of Chernobyl - GSC Game World
    (88, 34),  -- Redfall - Arkane Studios
    (89, 65),  -- Death Stranding - Kojima Productions
    (90, 35),  -- Stray - BlueTwelve Studio
    (91, 89),  -- Sifu - Sloclap
    (92, 90),  -- Kirby and the Forgotten Land - HAL Laboratory
    (93, 91),  -- Bayonetta 3 - PlatinumGames
    (94, 25),  -- Mario + Rabbids Sparks of Hope - Ubisoft
    (95, 92),  -- The Callisto Protocol - Striking Distance Studios
    (96, 61),  -- A Plague Tale: Requiem - Asobo Studio
    (97, 93),  -- Gotham Knights - WB Games Montréal
    (98, 94),  -- Dying Light 2 Stay Human - Techland
    (99, 95),  -- Ghostwire: Tokyo - Tango Gameworks
    (100, 96),  -- Triangle Strategy - Artdink
    (101, 24),  -- Live A Live - Square Enix
    (102, 29),  -- The Quarry - Supermassive Games
    (103, 46),  -- Cult of the Lamb - Massive Monster
    (104, 54),  -- Neon White - Angel Matrix
    (105, 11),  -- Ori and the Blind Forest - Moon Studios
    (106, 42),  -- Undertale - Toby Fox
    (107, 43),  -- The Witness - Jonathan Blow
    (108, 55),  -- Cocoon - Geometric Interactive
    (109, 49),  -- Super Meat Boy - Team Meat
    (110, 15),  -- Bastion - Supergiant Games
    (111, 67),  -- Limbo - Playdead
    (112, 39),  -- Shovel Knight - Yacht Club Games
    (113, 66),  -- Returnal - Housemarque
    (114, 37),  -- Slay the Spire - MegaCrit
    (115, 72),  -- Gris - Nomada Studio
    (116, 50),  -- Katana Zero - Askiisoft
    (117, 40),  -- The Binding of Isaac: Rebirth - Nicalis
    (118, 41),  -- Oxenfree - Night School Studio
    (119, 44),  -- Firewatch - Campo Santo
    (120, 45),  -- SOMA - Frictional Games
    (121, 2),  -- God of War - Santa Monica Studio
    (122, 48),  -- Shantae and the Seven Sirens - WayForward
    (123, 97),  -- Horizon Forbidden West - Guerrilla Games
    (124, 98),  -- Death's Door - Acid Nerve
    (125, 99),  -- Eastward - Pixpil
    (126, 69),  -- Chicory: A Colorful Tale - Greg Lobanov Studio
    (127, 100),  -- Luigi's Mansion 3 - Next Level Games
    (128, 47),  -- Papers, Please - Lucas Pope
    (129, 101),  -- Vampire Survivors - Luca Galante
    (130, 51),  -- Terraria - Re-Logic
    (131, 52),  -- Factorio - Wube Software
    (7, 70),  -- Like a Dragon Infinite Wealth - Ryu Ga Gotoku Studio
    (132, 59),  -- 13 Sentinels: Aegis Rim - Vanillaware
    (133, 21),  -- Red Dead Redemption II - Rockstar Games
    (136, 18),  -- Minecraft - Mojang Studios
    (138, 71),  -- A Hat in Time - Gears for Breakfast
    (139, 38),  -- Tinykin - Splashteam
    (140, 1),  -- Super Mario Bros. Wonder - Nintendo
    (141, 62),  -- Darkest Dungeon - Red Hook Studios
    (2, 24),  -- Final Fantasy VII Rebirth - Square Enix
    (142, 10),  -- Paper Mario: The Thousand-Year Door - Intelligent Systems
    (143, 53),  -- Satisfactory - Coffee Stain Studios
    (144, 95),  -- Hi-Fi RUSH - Tango Gameworks
    (145, 27),  -- Astro Bot - Team Asobi
    (146, 70),  -- Judgment - Ryu Ga Gotoku Studio
    (147, 75),  -- Metaphor: ReFantazio - Atlus
    (148, 24),  -- NieR: Automata - Square Enix
    (149, 1),  -- Pikmin 4 - Nintendo
    (150, 21);  -- Grand Theft Auto V - Rockstar Games
