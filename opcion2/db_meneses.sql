CREATE TABLE `p_centro` (
  `id_centro` integer PRIMARY KEY AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `ap_pat` varchar(255) NOT NULL,
  `ap_mat` varchar(255),
  `cargo` ENUM ('coordinador', 'seguridad', 'administrativo'),
  `usuario` varchar(255) UNIQUE NOT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100)
);

CREATE TABLE `p_externo` (
  `id_externo` integer PRIMARY KEY AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `ap_pat` varchar(255) NOT NULL,
  `ap_mat` varchar(255),
  `universidad` varchar(255),
  `usuario` varchar(255) UNIQUE NOT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100)
);

CREATE TABLE `area` (
  `id_area` integer PRIMARY KEY AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `id_centro` integer
);

CREATE TABLE `participaciones` (
  `id_partip` integer PRIMARY KEY AUTO_INCREMENT,
  `id_externo` integer NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  `aport` varchar(255),
  `tipo` ENUM ('servicio_social', 'voluntariado', 'practica_profesional', 'proyecto_inv', 'materia_inmersion') NOT NULL
);

CREATE TABLE `proyecto` (
  `id_proyecto` integer PRIMARY KEY AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date,
  `antecedentes` varchar(255),
  `objetivos` varchar(255),
  `repo` varchar(255),
  `prioritario` bool,
  `alcance` varchar(255),
  `evaluacion` varchar(255)
);

CREATE TABLE `rol_proyecto_centro` (
  `id_centro` integer,
  `id_proyecto` integer,
  `rol` ENUM ('lider', 'participante') NOT NULL,
  PRIMARY KEY (`id_centro`, `id_proyecto`)
);

CREATE TABLE `rol_proyecto_externo` (
  `id_partip` integer,
  `id_proyecto` integer,
  `rol` ENUM ('lider', 'participante') NOT NULL,
  PRIMARY KEY (`id_partip`, `id_proyecto`)
);

CREATE TABLE `proyecto_area` (
  `id_proyecto` integer,
  `id_area` integer,
  PRIMARY KEY (`id_proyecto`, `id_area`)
);

CREATE TABLE `proyecto_colonia` (
  `id_proyecto` integer,
  `id_colonia` integer,
  PRIMARY KEY (`id_colonia`, `id_proyecto`)
);

CREATE TABLE `historial_proyecto` (
  `id_historial` integer PRIMARY KEY AUTO_INCREMENT,
  `id_proyecto` integer NOT NULL,
  `fecha` timestamp NOT NULL,
  `comentario` varchar(255)
);

CREATE TABLE `caso` (
  `id_caso` integer PRIMARY KEY AUTO_INCREMENT,
  `init` date NOT NULL,
  `tipo` ENUM ('medica', 'psicopedagogica', 'acomp_psicosocial', 'juridico', 'nutricion') NOT NULL,
  `estado` ENUM ('activo', 'cerrado')
);

CREATE TABLE `caso_paciente` (
  `id_caso` integer,
  `id_comunidad` integer,
  PRIMARY KEY (`id_caso`, `id_comunidad`)
);

CREATE TABLE `seguimiento_caso` (
  `id_seguimiento_caso` integer PRIMARY KEY AUTO_INCREMENT,
  `id_caso` integer NOT NULL,
  `fecha` timestamp NOT NULL,
  `nota` text
);

CREATE TABLE `seguimiento_centro` (
  `id_centro` integer,
  `id_seguimiento_caso` integer,
  PRIMARY KEY (`id_centro`, `id_seguimiento_caso`)
);

CREATE TABLE `seguimiento_externo` (
  `id_partip` integer,
  `id_seguimiento_caso` integer,
  PRIMARY KEY (`id_partip`, `id_seguimiento_caso`)
);

CREATE TABLE `caso_motivo` (
  `id_caso` integer,
  `id_padec_caso` integer,
  PRIMARY KEY (`id_caso`, `id_padec_caso`)
);

CREATE TABLE `list_padec_caso` (
  `id_padec_caso` integer PRIMARY KEY AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL
);

CREATE TABLE `colonia` (
  `id_colonia` integer PRIMARY KEY AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `viviendas` integer,
  `adultos` integer,
  `ninos` integer,
  `riesgo` integer,
  `poblacion_total` integer
);

CREATE TABLE `list_padec_colonia` (
  `id_padec_colonia` integer PRIMARY KEY AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL
);

CREATE TABLE `padec_colonia` (
  `id_padec_colonia` integer,
  `id_colonia` integer,
  PRIMARY KEY (`id_colonia`, `id_padec_colonia`)
);

CREATE TABLE `espacio_hist` (
  `id_esp_hist` integer PRIMARY KEY AUTO_INCREMENT,
  `id_colonia` integer,
  `nombre` varchar(255)
);

CREATE TABLE `p_comunidad` (
  `id_comunidad` integer PRIMARY KEY AUTO_INCREMENT,
  `id_colonia` integer,
  `nombre` varchar(255) NOT NULL,
  `ap_pat` varchar(255) NOT NULL,
  `ap_mat` varchar(255),
  `rango_edad` varchar(255),
  `genero` ENUM ('masculino', 'femenino', 'otro'),
  `nv_escolar` ENUM ('primaria', 'secundaria', 'preparatoria', 'universidad', 'tecnica', 'otro')
);

CREATE TABLE `taller` (
  `id_taller` integer PRIMARY KEY AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `init` date NOT NULL,
  `estado` ENUM ('activo', 'pausado', 'cancelado'),
  `alcance` varchar(255),
  `evaluacion` varchar(255),
  `objetivos` varchar(255)
);

CREATE TABLE `taller_gen` (
  `id_taller_gen` integer PRIMARY KEY AUTO_INCREMENT,
  `id_taller` integer NOT NULL,
  `fecha_inicio` date,
  `fecha_fin` date
);

CREATE TABLE `tallerista_centro` (
  `id_taller_gen` integer,
  `id_centro` integer,
  PRIMARY KEY (`id_centro`, `id_taller_gen`)
);

CREATE TABLE `tallerista_externo` (
  `id_taller_gen` integer,
  `id_partip` integer,
  PRIMARY KEY (`id_partip`, `id_taller_gen`)
);

CREATE TABLE `taller_grupos` (
  `id_taller_gen` integer,
  `id_comunidad` integer,
  PRIMARY KEY (`id_comunidad`, `id_taller_gen`)
);

ALTER TABLE `area` ADD FOREIGN KEY (`id_centro`) REFERENCES `p_centro` (`id_centro`) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE `participaciones` ADD FOREIGN KEY (`id_externo`) REFERENCES `p_externo` (`id_externo`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `proyecto_area` ADD FOREIGN KEY (`id_proyecto`) REFERENCES `proyecto` (`id_proyecto`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `proyecto_area` ADD FOREIGN KEY (`id_area`) REFERENCES `area` (`id_area`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `historial_proyecto` ADD FOREIGN KEY (`id_proyecto`) REFERENCES `proyecto` (`id_proyecto`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `seguimiento_caso` ADD FOREIGN KEY (`id_caso`) REFERENCES `caso` (`id_caso`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `caso_motivo` ADD FOREIGN KEY (`id_caso`) REFERENCES `caso` (`id_caso`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `caso_motivo` ADD FOREIGN KEY (`id_padec_caso`) REFERENCES `list_padec_caso` (`id_padec_caso`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `espacio_hist` ADD FOREIGN KEY (`id_colonia`) REFERENCES `colonia` (`id_colonia`) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE `padec_colonia` ADD FOREIGN KEY (`id_colonia`) REFERENCES `colonia` (`id_colonia`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `padec_colonia` ADD FOREIGN KEY (`id_padec_colonia`) REFERENCES `list_padec_colonia` (`id_padec_colonia`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `proyecto_colonia` ADD FOREIGN KEY (`id_colonia`) REFERENCES `colonia` (`id_colonia`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `proyecto_colonia` ADD FOREIGN KEY (`id_proyecto`) REFERENCES `proyecto` (`id_proyecto`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `p_comunidad` ADD FOREIGN KEY (`id_colonia`) REFERENCES `colonia` (`id_colonia`) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE `taller_gen` ADD FOREIGN KEY (`id_taller`) REFERENCES `taller` (`id_taller`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `tallerista_centro` ADD FOREIGN KEY (`id_taller_gen`) REFERENCES `taller_gen` (`id_taller_gen`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `tallerista_centro` ADD FOREIGN KEY (`id_centro`) REFERENCES `p_centro` (`id_centro`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `tallerista_externo` ADD FOREIGN KEY (`id_taller_gen`) REFERENCES `taller_gen` (`id_taller_gen`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `taller_grupos` ADD FOREIGN KEY (`id_comunidad`) REFERENCES `p_comunidad` (`id_comunidad`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `taller_grupos` ADD FOREIGN KEY (`id_taller_gen`) REFERENCES `taller_gen` (`id_taller_gen`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `rol_proyecto_centro` ADD FOREIGN KEY (`id_proyecto`) REFERENCES `proyecto` (`id_proyecto`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `rol_proyecto_externo` ADD FOREIGN KEY (`id_proyecto`) REFERENCES `proyecto` (`id_proyecto`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `rol_proyecto_centro` ADD FOREIGN KEY (`id_centro`) REFERENCES `p_centro` (`id_centro`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `caso_paciente` ADD FOREIGN KEY (`id_caso`) REFERENCES `caso` (`id_caso`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `caso_paciente` ADD FOREIGN KEY (`id_comunidad`) REFERENCES `p_comunidad` (`id_comunidad`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `tallerista_externo` ADD FOREIGN KEY (`id_partip`) REFERENCES `participaciones` (`id_partip`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `rol_proyecto_externo` ADD FOREIGN KEY (`id_partip`) REFERENCES `participaciones` (`id_partip`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `seguimiento_centro` ADD FOREIGN KEY (`id_centro`) REFERENCES `p_centro` (`id_centro`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `seguimiento_externo` ADD FOREIGN KEY (`id_seguimiento_caso`) REFERENCES `seguimiento_caso` (`id_seguimiento_caso`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `seguimiento_centro` ADD FOREIGN KEY (`id_seguimiento_caso`) REFERENCES `seguimiento_caso` (`id_seguimiento_caso`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `seguimiento_externo` ADD FOREIGN KEY (`id_partip`) REFERENCES `participaciones` (`id_partip`) ON DELETE RESTRICT ON UPDATE CASCADE;
