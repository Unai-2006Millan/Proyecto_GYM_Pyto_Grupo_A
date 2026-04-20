DROP DATABASE IF EXISTS gym_fitness;
CREATE DATABASE gym_fitness CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE gym_fitness;

CREATE TABLE usuario (
    dni             VARCHAR(15) PRIMARY KEY,
    nombre          VARCHAR(50) NOT NULL,
    apellido        VARCHAR(50) NOT NULL,
    email           VARCHAR(100) NOT NULL UNIQUE,
    password        VARCHAR(100) NOT NULL,
    fecha_alta      DATE NOT NULL,
    estado          ENUM('activo','baja','moroso') NOT NULL DEFAULT 'activo'
) ENGINE=InnoDB;

CREATE TABLE socio (
    dni_socio       VARCHAR(15) PRIMARY KEY,
    tipo_plan       ENUM('FULL','FLEX') NOT NULL,
    estado_socio    ENUM('activo','baja','moroso') NOT NULL,
    FOREIGN KEY (dni_socio) REFERENCES usuario(dni)
        ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE trabajador (
    dni_trabajador  VARCHAR(15) PRIMARY KEY,
    FOREIGN KEY (dni_trabajador) REFERENCES usuario(dni)
        ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE administrador (
    dni_admin VARCHAR(15) PRIMARY KEY,
    FOREIGN KEY (dni_admin) REFERENCES trabajador(dni_trabajador)
        ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE recepcionista (
    dni_recep VARCHAR(15) PRIMARY KEY,
    FOREIGN KEY (dni_recep) REFERENCES trabajador(dni_trabajador)
        ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE entrenador (
    dni_entrenador  VARCHAR(15) PRIMARY KEY,
    tipo_contrato   ENUM('TC','TP') NOT NULL,
    salario         DECIMAL(8,2) NULL,
    precio_hora     DECIMAL(6,2) NULL,
    FOREIGN KEY (dni_entrenador) REFERENCES trabajador(dni_trabajador)
        ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE sala (
    id_sala             INT AUTO_INCREMENT PRIMARY KEY,
    nombre              VARCHAR(50) NOT NULL UNIQUE,
    metros_cuadrados    INT NOT NULL,
    aforo               INT NOT NULL,
    tipo_sala           ENUM('NORMAL','ALMACEN') NOT NULL DEFAULT 'NORMAL'
) ENGINE=InnoDB;

CREATE TABLE actividad (
    id_actividad    INT AUTO_INCREMENT PRIMARY KEY,
    nombre          VARCHAR(50) NOT NULL,
    descripcion     TEXT,
    nivel           ENUM('bajo','medio','alto') NOT NULL DEFAULT 'medio'
) ENGINE=InnoDB;

CREATE TABLE actividad_programada (
    id_act_prog     INT AUTO_INCREMENT PRIMARY KEY,
    id_actividad    INT NOT NULL,
    id_sala         INT NOT NULL,
    dni_entrenador  VARCHAR(15) NOT NULL,
    fecha_inicio    DATETIME NOT NULL,
    fecha_fin       DATETIME NOT NULL,
    FOREIGN KEY (id_actividad) REFERENCES actividad(id_actividad),
    FOREIGN KEY (id_sala) REFERENCES sala(id_sala),
    FOREIGN KEY (dni_entrenador) REFERENCES entrenador(dni_entrenador)
) ENGINE=InnoDB;

CREATE TABLE maquinaria (
    num_serie               VARCHAR(30) PRIMARY KEY,
    tipo                    VARCHAR(50) NOT NULL,
    marca                   VARCHAR(50) NOT NULL,
    fecha_compra            DATE NOT NULL,
    fecha_ultimo_mantenimiento DATE NOT NULL,
    estado                  ENUM('OPERATIVA','REVISION','FUERA_SERVICIO') NOT NULL,
    id_sala                 INT NOT NULL,
    FOREIGN KEY (id_sala) REFERENCES sala(id_sala)
) ENGINE=InnoDB;

CREATE TABLE reserva (
    id_reserva      INT AUTO_INCREMENT PRIMARY KEY,
    id_act_prog     INT NOT NULL,
    dni_socio       VARCHAR(15) NOT NULL,
    fecha_reserva   DATETIME NOT NULL,
    FOREIGN KEY (id_act_prog) REFERENCES actividad_programada(id_act_prog),
    FOREIGN KEY (dni_socio) REFERENCES socio(dni_socio)
) ENGINE=InnoDB;

CREATE TABLE pago (
    id_pago         INT AUTO_INCREMENT PRIMARY KEY,
    dni_socio       VARCHAR(15) NOT NULL,
    id_act_prog     INT NULL,
    fecha           DATE NOT NULL,
    importe         DECIMAL(8,2) NOT NULL,
    tipo_pago       ENUM('CUOTA','ACTIVIDAD') NOT NULL,
    FOREIGN KEY (dni_socio) REFERENCES socio(dni_socio),
    FOREIGN KEY (id_act_prog) REFERENCES actividad_programada(id_act_prog)
) ENGINE=InnoDB;

CREATE TABLE nomina (
    id_nomina       INT AUTO_INCREMENT PRIMARY KEY,
    fecha           DATE NOT NULL,
    importe         DECIMAL(8,2) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE nomina_entrenador (
    id_nomina       INT PRIMARY KEY,
    dni_entrenador  VARCHAR(15) NOT NULL,
    FOREIGN KEY (id_nomina) REFERENCES nomina(id_nomina),
    FOREIGN KEY (dni_entrenador) REFERENCES entrenador(dni_entrenador)
) ENGINE=InnoDB;

CREATE TABLE actividad_entrenador (
    dni_entrenador  VARCHAR(15) NOT NULL,
    id_actividad    INT NOT NULL,
    PRIMARY KEY (dni_entrenador, id_actividad),
    FOREIGN KEY (dni_entrenador) REFERENCES entrenador(dni_entrenador),
    FOREIGN KEY (id_actividad) REFERENCES actividad(id_actividad)
) ENGINE=InnoDB;

CREATE TABLE actividad_sala (
    id_sala         INT NOT NULL,
    id_actividad    INT NOT NULL,
    PRIMARY KEY (id_sala, id_actividad),
    FOREIGN KEY (id_sala) REFERENCES sala(id_sala),
    FOREIGN KEY (id_actividad) REFERENCES actividad(id_actividad)
) ENGINE=InnoDB;

INSERT INTO usuario VALUES
('11111111A','Ana','López','ana@gym.com','pass','2024-01-10','activo'),
('22222222B','Bruno','Martín','bruno@gym.com','pass','2024-01-15','activo'),
('33333333C','Carla','Sanz','carla@gym.com','pass','2024-02-01','moroso'),
('44444444D','Diego','Ruiz','diego@gym.com','pass','2024-02-10','baja'),
('55555555E','Elena','Gil','elena@gym.com','pass','2024-03-01','activo'),
('66666666F','Fernando','Iglesias','fernando@gym.com','pass','2024-03-05','activo'),
('77777777G','Gema','Torres','gema@gym.com','pass','2024-01-05','activo'),
('88888888H','Hugo','Navarro','hugo@gym.com','pass','2024-01-05','activo'),
('99999999J','Iris','Pérez','iris@gym.com','pass','2024-01-05','activo'),
('10101010K','Kike','Soria','kike@gym.com','pass','2024-01-05','activo'),
('12121212L','Laura','Vega','laura@gym.com','pass','2024-01-05','activo'),
('13131313M','Mario','Campos','mario@gym.com','pass','2024-01-05','activo');

INSERT INTO socio VALUES
('11111111A','FULL','activo'),
('22222222B','FLEX','activo'),
('33333333C','FULL','moroso'),
('44444444D','FLEX','baja'),
('55555555E','FULL','activo'),
('66666666F','FLEX','activo');

INSERT INTO trabajador VALUES
('77777777G'),
('88888888H'),
('99999999J');

INSERT INTO administrador VALUES ('77777777G');
INSERT INTO recepcionista VALUES ('88888888H');
INSERT INTO entrenador VALUES
('99999999J','TP',NULL,20.00);

INSERT INTO sala (nombre, metros_cuadrados, aforo, tipo_sala) VALUES
('Sala Cardio',80,25,'NORMAL'),
('Sala Fuerza',100,20,'NORMAL'),
('Sala Yoga',60,15,'NORMAL'),
('Almacen',50,0,'ALMACEN'),
('Sala Funcional',90,18,'NORMAL');

INSERT INTO actividad (nombre, descripcion, nivel) VALUES
('Spinning','Ciclismo indoor','alto'),
('BodyPump','Entrenamiento con pesas','medio'),
('Yoga','Relajación y estiramientos','bajo'),
('HIIT','Alta intensidad','alto'),
('Pilates','Trabajo de core','medio');

INSERT INTO actividad_sala VALUES
(1,1),(2,2),(3,3),(2,4),(5,5),(5,4);

INSERT INTO actividad_entrenador VALUES
('99999999J',1),
('99999999J',4);

INSERT INTO actividad_programada (id_actividad,id_sala,dni_entrenador,fecha_inicio,fecha_fin) VALUES
(1,1,'99999999J','2025-04-21 09:00','2025-04-21 10:00'),
(4,2,'99999999J','2025-04-21 19:00','2025-04-21 19:45');

INSERT INTO maquinaria VALUES
('CARDIO-001','Bicicleta','BH','2023-01-10','2024-01-10','OPERATIVA',1),
('FUERZA-001','Multipower','Technogym','2022-05-20','2024-01-20','OPERATIVA',2);

INSERT INTO reserva (id_act_prog,dni_socio,fecha_reserva) VALUES
(1,'11111111A','2025-04-15 10:00'),
(1,'22222222B','2025-04-16 11:00');

INSERT INTO pago (dni_socio,id_act_prog,fecha,importe,tipo_pago) VALUES
('11111111A',NULL,'2025-04-01',40,'CUOTA'),
('22222222B',1,'2025-04-15',8,'ACTIVIDAD');

INSERT INTO nomina (fecha,importe) VALUES
('2025-03-31',900),
('2025-04-30',950);

INSERT INTO nomina_entrenador VALUES
(1,'99999999J'),
(2,'99999999J');



