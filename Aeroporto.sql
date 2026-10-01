CREATE TABLE aeronaves (
	id SERIAL PRIMARY KEY,
	modelo VARCHAR(100) not null,
	codigo_cauda VARCHAR(10) UNIQUE not null,
	capacidade int not null check (capacidade > 0)

);

CREATE TABLE pilotos (
	id SERIAL PRIMARY KEY,
	nome VARCHAR(100) not null,
	codigo_anac VARCHAR(6) UNIQUE not null,
	horas_voo INT DEFAULT 0 check (horas_voo >= 0)
);

CREATE TABLE voos (
	id SERIAL PRIMARY KEY,
	aeronaves_id INT not null,
	pilotos_id INT not null,
	numero_voo VARCHAR(100) not null,
	origem VARCHAR(100) not null,
	destino VARCHAR(100) not null,
	data_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	status VARCHAR(20) DEFAULT 'Agendado' check (status IN ('Agendado', 'Em Voo', 'Concluido', 'Cancelado')),
	
	FOREIGN KEY (aeronaves_id)
	REFERENCES aeronaves(id),

	FOREIGN KEY (pilotos_id)
	REFERENCES pilotos(id)

);

CREATE TABLE passageiros (
	id SERIAL PRIMARY KEY,
	nome VARCHAR(100) not null,
	cpf VARCHAR(11) UNIQUE not null,
	email VARCHAR(100) UNIQUE not null
);

CREATE TABLE passagens (
	id SERIAL PRIMARY KEY,
	voos_id INT not null,
	passageiros_id INT not null,
	assento VARCHAR(4) not null,
	classe VARCHAR(20) DEFAULT 'Economica' check (classe IN ('Economica', 'Executiva')),
	valor NUMERIC(10,2) check (valor > 0),


	FOREIGN KEY (voos_id)
	REFERENCES voos(id),

	FOREIGN KEY (passageiros_id)
	REFERENCES passageiros(id)
	
);

INSERT INTO aeronaves (modelo, codigo_cauda, capacidade) VALUES
('Boing 737', 'ABC-123', 180),
('Avião Dourado', 'DEF-456', 181),
('Jatinho', 'GHI-789', 182),
('Tuki Tuki', 'JKL-123', 183),
('Avião Hibrido', 'MNO-456', 184),

INSERT INTO pilotos (nome, codigo_anac, horas_voo) VALUES
('Nicolas Marques', '123456', 1500),
('Guilherme Ribeiro', '654321', 1501),
('Lucca Felicio', '112233', 1502),
('Davi Peidinho', '445566', 1503),
('Manuela Urbano', '778899', 1504);

INSERT INTO passageiros (nome, cpf, email) VALUES
('Nicolas Junior', '12345678910', 'nicolasmarques@gmail.com'),
('Willer Barros', '12345678911', 'ruancarlos@hotmail.com'),
('Tulinho Maravilha', '12345678912', 'tuliomaravilha@gmail.com'),
('Neymar Junior', '12345678913', 'neymarjunior@hotmail.com'),
('Roberto Carlos', '12345678914', 'robertocarlos@gmail.com');

INSERT INTO voos (aeronaves_id, pilotos_id, numero_voo, origem, destino, status) VALUES
(1, 1, 'ABC123', 'Florianópolis', 'São Paulo', 'Agendado'),
(2, 2, 'DEF345', 'Florianópolis', 'Brasilia', 'Em Voo'),
(3, 3, 'GHI678', 'Florianópolis', 'Porto Alegre', 'Concluido'),
(4, 4, 'JKL910', 'Florianópolis', 'Miami', 'Agendado'),
(5, 5, 'MNO123', 'Florianópolis', 'Salvador', 'Cancelado');

INSERT INTO passagens (voos_id, passageiros_id, assento, classe, valor) VALUES
(1, 1, '13A', 'Economica', 350.00),
(1, 2, '13A', 'Executiva', 500.00),
(2, 3, '22C', 'Executiva', 500.00),
(3, 4, '22F', 'Economica', 350.00),
(4, 5, '14B', 'Executiva', 500.00);

SELECT 
	voos.numero_voo, 
	voos.origem, 
	voos.destino, 
	aeronaves.modelo, 
	pilotos.nome
FROM voos 
JOIN aeronaves ON voos.aeronaves_id = aeronaves.id 
JOIN pilotos ON voos.pilotos_id = pilotos.id 

-- Não consegui fazer a consulta final para filtrar somente pelo status na questão ACIMA

SELECT 
	classe, 
	SUM(valor) AS total_arrecadado 
FROM passagens
GROUP BY classe;

-- Não consegui fazer a terceira (Q3)

SELECT * from vw_painel_aeroporto AS
SELECT 
voos.numero_voo, 
voos.data_hora, 
voos.origem, 
voos.destino, 
aeronaves.modelo, 
aeronaves.codigo_cauda, 
voos.status 
FROM voos 
JOIN aeronaves ON voos.aeronave_id = aeronaves.id;

-- Não consegui fazer a segunda view
