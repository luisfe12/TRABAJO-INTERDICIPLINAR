DROP DATABASE  IF EXISTS TI2;
CREATE DATABASE TI2;
USE TI2; 

CREATE TABLE curso(
	cur_ide int PRIMARY KEY,
    cur_sem int,
    cur_credi int,
    cur_hor_teo int,
    cur_hora_pra int,
    cur_hor_lab int,
    cur_nom varchar(50),
    cur_sum varchar(50),
    cur_hor_tot int,
    cur_fund varchar(100),
    cur_cod int,
    cur_sem_anual int,
    cur_dur int
);

CREATE TABLE sumilla(
	sum_ide int PRIMARY KEY,
    sum_fundamentacion VARCHAR(200),
    cur_ide int,
    FOREIGN KEY (cur_ide) REFERENCES curso(cur_ide)
);

CREATE TABLE competencia(
	com_ide int PRIMARY KEY,
    com_niv int,
    com_nom VARCHAR(50),
    com_des VARCHAR(100)
);

CREATE TABLE sumilla_competencia(
	sum_com_ide int PRIMARY KEY,
    com_ide int,
    sum_ide int,
    FOREIGN KEY (com_ide) REFERENCES competencia(com_ide),
    FOREIGN KEY (sum_ide) REFERENCES sumilla(sum_ide)
);

CREATE TABLE resultados_estudiante(
	res_est_ide int PRIMARY KEY,
    res_est_cod int,
    res_est_nom VARCHAR(50),
    rest_est_des VARCHAR(100)
);

CREATE TABLE sumilla_resultado(
	sum_res_ide INT PRIMARY KEY,
    sum_res_niv int,
    sum_ide int,
    res_est_ide int,
    FOREIGN KEY (sum_ide) REFERENCES sumilla(sum_ide),
    FOREIGN KEY (res_est_ide) REFERENCES resultados_estudiante(res_est_ide)
);

CREATE TABLE prerequisitos(
	prere_ide INT PRIMARY KEY,
    cur_ide int,
    cur_ide_pre int,
    FOREIGN KEY (cur_ide) REFERENCES curso(cur_ide),
    FOREIGN KEY (cur_ide_pre) REFERENCES curso(cur_ide)
);

CREATE TABLE unidad_academica(
	uni_aca_ide int PRIMARY KEY,
    com_ide int,
    uni_aca_hor int,
    sum_ide int,
    FOREIGN KEY (sum_ide) REFERENCES sumilla(sum_ide)
);

CREATE TABLE topico(
	top_ide INT PRIMARY KEY,
    TOP_DES VARCHAR(50),
    uni_aca_ide INT,
    FOREIGN KEY (uni_aca_ide) REFERENCES unidad_academica(uni_aca_ide)
);

CREATE TABLE bibliografia(
	bib_ide INT PRIMARY KEY,
    bib_nom VARCHAR(50),
    bib_edi VARCHAR(50),
    bib_editorial VARCHAR(50),
    bib_anio date
);

CREATE TABLE autor(
	aut_ide INT PRIMARY KEY,
    aut_nom VARCHAR(50),
    aut_ape VARCHAR(50)
);

CREATE TABLE autor_bibliografia(
	aut_bib_ide INT PRIMARY KEY,
    aut_ide INT,
    bib_ide INT,
    FOREIGN KEY (aut_ide) REFERENCES autor(aut_ide),
    FOREIGN KEY (bib_ide) REFERENCES bibliografia(bib_ide)
);

CREATE TABLE bibliografia_unidad(
	bib_uni_ide INT PRIMARY KEY,
    uni_aca_ide INT,
    bib_ide INT,
    FOREIGN KEY (uni_aca_ide) REFERENCES unidad_academica(uni_aca_ide),
    FOREIGN KEY (bib_ide) REFERENCES bibliografia(bib_ide)
);

CREATE TABLE silabo(
	sil_ide INT PRIMARY KEY,
    sil_sem INT,
    sil_inst_eva INT,
    sil_per_aca INT,
    sil_fun VARCHAR(100),
    sil_sum VARCHAR(100),
    sil_req_apr VARCHAR(100),
    cur_ide INT,
    FOREIGN KEY (cur_ide) REFERENCES curso(cur_ide)
);

CREATE TABLE bibliografia_silabo(
	bib_sil_ide INT PRIMARY KEY,
    sil_ide INT,
    bib_ide INT,
    FOREIGN KEY (sil_ide) REFERENCES silabo(sil_ide),
    FOREIGN KEY (bib_ide) REFERENCES bibliografia(bib_ide)
);

CREATE TABLE resultado_silabo(
	res_sil_ide INT PRIMARY KEY,
    sil_ide INT,
    res_est_ide INT,
    FOREIGN KEY (sil_ide) REFERENCES silabo(sil_ide),
    FOREIGN KEY (res_est_ide) REFERENCES resultados_estudiante(res_est_ide)
);

CREATE TABLE estra_eva(
	id_estra_eva INT PRIMARY KEY,
    eva_continua int,
    eva_periodica int,
    tipo_eva  VARCHAR(50),
    instr_eva VARCHAR(50),
    sil_ide INT,
    FOREIGN KEY (sil_ide) REFERENCES silabo(sil_ide)
);

CREATE TABLE crono_eva(
	cro_eva_ide INT PRIMARY KEY,
    evaluacion VARCHAR(50),
    fecha date,
    examen_teorico  int,
    examen_continua int,
    id_estra_eva INT,
    FOREIGN KEY (id_estra_eva) REFERENCES estra_eva(id_estra_eva)
);

CREATE TABLE estrategia_aprendizaje(
	estr_ide INT PRIMARY KEY,
    est_tip VARCHAR(50),
    est_desc VARCHAR(50)
);

CREATE TABLE silabo_estrategia_apren(
	sil_est_apren int PRIMARY KEY,
    estr_ide INT,
    sil_ide INT,
    FOREIGN KEY (sil_ide) REFERENCES silabo(sil_ide),
    FOREIGN KEY (estr_ide) REFERENCES estrategia_aprendizaje(estr_ide)
);

CREATE TABLE departamento_academico(
	dep_ide INT PRIMARY KEY,
    dep_nom VARCHAR(50)
);

CREATE TABLE docente(
	doc_ide INT PRIMARY KEY,
    doc_nom VARCHAR(50),
    doc_ape_mat VARCHAR(50),
    doc_ape_pat VARCHAR(50),
    doc_grad_aca VARCHAR(50),
    dep_ide INT,
    FOREIGN KEY (dep_ide) REFERENCES departamento_academico(dep_ide)
);

CREATE TABLE silabo_docente(
	sil_doc_ide INT PRIMARY KEY,
    doc_ide INT,
    sil_ide INT,
    FOREIGN KEY (doc_ide) REFERENCES docente(doc_ide),
    FOREIGN KEY (sil_ide) REFERENCES silabo(sil_ide)
);

CREATE TABLE horario(
	hor_ide INT PRIMARY KEY,
    grupo VARCHAR(1),
    hora_entrada time,
    hora_salida time,
    tipo_clase VARCHAR(50),
    aula VARCHAR(50),
    dia VARCHAR(15),
    doc_ide INT,
    sil_ide INT,
    FOREIGN KEY (doc_ide) REFERENCES docente(doc_ide),
    FOREIGN KEY (sil_ide) REFERENCES silabo(sil_ide)
);

CREATE TABLE usuario(
	usu_ide INT PRIMARY KEY,
    usu_user VARCHAR(50),
    usu_pass VARCHAR(50),
    doc_ide INT,
    foreign key (doc_ide) references docente(doc_ide)
);

CREATE TABLE usuario_comun(
	usu_ide INT PRIMARY KEY,
    FOREIGN KEY (usu_ide) REFERENCES usuario(usu_ide)
);

CREATE TABLE usuario_administrador(
	usu_ide INT PRIMARY KEY,
    FOREIGN KEY (usu_ide) REFERENCES usuario(usu_ide)
);

