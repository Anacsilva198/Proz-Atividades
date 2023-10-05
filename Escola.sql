CREATE TABLE aluno (
  id SERIAL PRIMARY KEY,
  nome VARCHAR (20) NOT NULL,
  matricula INT NOT NULL,
  email VARCHAR (20) NOT NULL,
  endereco VARCHAR (20) NOT NULL,
  telefone VARCHAR (14)
)

INSERT INTO aluno (nome, matricula, email, endereco, telefone) VALUES
('João Carlos', 1234, 'Jcarlos@gmail.com', 'Rua 13 de maio', '(11)7825-4489'),
('José Vitor', 2345, 'Jvitor@gmail.com', 'Rua da Saudade', '(11)7825-6589'),
('Paulo André', 3456, 'Pandr@gmail.com', 'Rua do Sol', '(11)7825-4495')

SELECT * FROM aluno
