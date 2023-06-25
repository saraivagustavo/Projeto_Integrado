----------------------------------------------------------------------------------
-- Criação das tabela loja
-------------------------------------------------------------------------------
CREATE TABLE public.Loja (
                Recompensa_id NUMERIC(3) NOT NULL,
                Quantidade NUMERIC(10) NOT NULL,
                Valor NUMERIC(6,2) NOT NULL,
                Recompensas VARCHAR(255) NOT NULL,
  --
--  chave primaria
----------------------------------------------------------------------------------
                CONSTRAINT id_recompensa PRIMARY KEY (Recompensa_id)
);
----------------------------------------------------------------------------------
-- Comentarios da tabela
-------------------------------------------------------------------------------
COMMENT ON TABLE public.Loja IS 'Tabela referente ás recompensas obtidas';
COMMENT ON COLUMN public.Loja.Recompensa_id IS 'Identificador unico das recompensas';
COMMENT ON COLUMN public.Loja.Quantidade IS 'Quantidade de recompensas de cada produto';
COMMENT ON COLUMN public.Loja.Valor IS 'Valor da recompensa';
COMMENT ON COLUMN public.Loja.Recompensas IS 'Nome das recompensas';

----------------------------------------------------------------------------------
-- Criação das tabela funcionarios
-------------------------------------------------------------------------------

CREATE TABLE public.Funcionrios (
                cpf CHAR NOT NULL,
                Nome VARCHAR(255) NOT NULL,
                Cargo VARCHAR(255) NOT NULL,
                Nascimento DATE NOT NULL,
                Email VARCHAR(255) NOT NULL,
                Estado VARCHAR(255) NOT NULL,
                Pontos NUMERIC(12),
                Sexo VARCHAR(1) NOT NULL,
                Certificados VARCHAR(255),
    --
--  chave primaria
----------------------------------------------------------------------------------
                CONSTRAINT cpf PRIMARY KEY (cpf)
);
----------------------------------------------------------------------------------
-- Comentarios da tabela
-------------------------------------------------------------------------------
COMMENT ON TABLE public.Funcionrios IS 'Tabela que representa os funcionários usuários do site';
COMMENT ON COLUMN public.Funcionrios.cpf IS 'CPF do funcionario';
COMMENT ON COLUMN public.Funcionrios.Nome IS 'Nome do funcionário';
COMMENT ON COLUMN public.Funcionrios.Cargo IS 'Coluna referente ao cargo do funcionário';
COMMENT ON COLUMN public.Funcionrios.Nascimento IS 'Data de nascimento do funcionário';
COMMENT ON COLUMN public.Funcionrios.Email IS 'Email do funcionário';
COMMENT ON COLUMN public.Funcionrios.Estado IS 'Estado do Funcionário';
COMMENT ON COLUMN public.Funcionrios.Pontos IS 'Pontos obtidos pelo funcionário ao completar cursos';
COMMENT ON COLUMN public.Funcionrios.Sexo IS 'Sexo do funcionário';
COMMENT ON COLUMN public.Funcionrios.Certificados IS 'Certificado obtido pelo funcionário ao completar um curso';

----------------------------------------------------------------------------------
-- Criação das tabela curso
-------------------------------------------------------------------------------

CREATE TABLE public.Curso (
                Curso_id NUMERIC(2) NOT NULL,
                Duracao VARCHAR(255) NOT NULL,
                curso_nome VARCHAR(255) NOT NULL,
                cpf CHAR NOT NULL,
    --
--  chave primaria
----------------------------------------------------------------------------------
                CONSTRAINT curso_id PRIMARY KEY (Curso_id)
);
----------------------------------------------------------------------------------
-- Comentarios da tabela
-------------------------------------------------------------------------------
COMMENT ON TABLE public.Curso IS 'Tabela referente aos cursos disponiveis no site';
COMMENT ON COLUMN public.Curso.Curso_id IS 'Identificador unico do curso';
COMMENT ON COLUMN public.Curso.Duracao IS 'Duracao de um curso';
COMMENT ON COLUMN public.Curso.curso_nome IS 'nome do curso';
COMMENT ON COLUMN public.Curso.cpf IS 'CPF do funcionario';

----------------------------------------------------------------------------------
-- Criação das tabela jogos
-------------------------------------------------------------------------------

CREATE TABLE public.Jogos (
                Jogo_id NUMERIC(2) NOT NULL,
                nome_jogo VARCHAR(255) NOT NULL,
                Premio NUMERIC(4) NOT NULL,
                Curso_id NUMERIC(2) NOT NULL,
    --
--  chave primaria
----------------------------------------------------------------------------------
                CONSTRAINT jogo_id PRIMARY KEY (Jogo_id)
);
----------------------------------------------------------------------------------
-- Comentarios da tabela
-------------------------------------------------------------------------------
COMMENT ON TABLE public.Jogos IS 'Tabela referente aos jogos do site';
COMMENT ON COLUMN public.Jogos.Jogo_id IS 'Identificador unico do jogo';
COMMENT ON COLUMN public.Jogos.nome_jogo IS 'nome do jogo';
COMMENT ON COLUMN public.Jogos.Premio IS 'Premio do jogo em pontos';
COMMENT ON COLUMN public.Jogos.Curso_id IS 'Identificador unico do curso';

----------------------------------------------------------------------------------
-- Criação das tabela pontos de resgate
-------------------------------------------------------------------------------

CREATE TABLE public.Pontos_de_resgate (
                Loja_Recompensa_id NUMERIC(3) NOT NULL,
                cpf CHAR NOT NULL,
                Pontos NUMERIC(12),
    --
--  chave primaria
----------------------------------------------------------------------------------
                CONSTRAINT recompensa_id PRIMARY KEY (Loja_Recompensa_id, cpf)
);
----------------------------------------------------------------------------------
-- Comentarios da tabela
-------------------------------------------------------------------------------
COMMENT ON TABLE public.Pontos_de_resgate IS 'tabela referente aos pontos de resgate para loja';
COMMENT ON COLUMN public.Pontos_de_resgate.Loja_Recompensa_id IS 'Identificador unico das recompensas';
COMMENT ON COLUMN public.Pontos_de_resgate.cpf IS 'CPF do funcionário';
COMMENT ON COLUMN public.Pontos_de_resgate.Pontos IS 'Pontos para resgate das recompensas';

----------------------------------------------------------------------------------
-- Criação dos Check da tabela
-------------------------------------------------------------------------------
ALTER TABLE public.Pontos_de_resgate ADD CONSTRAINT loja_pontos_de_resgate_fk
FOREIGN KEY (Loja_Recompensa_id)
REFERENCES public.Loja (Recompensa_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Pontos_de_resgate ADD CONSTRAINT funcion_rios_pontos_de_resgate_fk
FOREIGN KEY (cpf)
REFERENCES public.Funcionrios (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Curso ADD CONSTRAINT funcionrios_curso_fk
FOREIGN KEY (cpf)
REFERENCES public.Funcionrios (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Jogos ADD CONSTRAINT curso_jogos_fk
FOREIGN KEY (Curso_id)
REFERENCES public.Curso (Curso_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Loja
ADD CONSTRAINT quantidade_non_negative CHECK (Quantidade >= 0),
ADD CONSTRAINT valor_non_negative CHECK (Valor >= 0);

ALTER TABLE public.Funcionários
ADD CONSTRAINT email_format_check CHECK (Email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');

ALTER TABLE public.Funcionários
ADD CONSTRAINT pontos_non_negative CHECK (Pontos >= 0);

ALTER TABLE public.Funcionários
ADD CONSTRAINT sexo_allowed_values CHECK (Sexo IN ('F', 'M'));

ALTER TABLE public.Curso
ADD CONSTRAINT duracao_format_check CHECK (Duracao ~ '^\d+ horas$');

ALTER TABLE public.Jogos
ADD CONSTRAINT premio_non_negative CHECK (Premio >= 0);

ALTER TABLE public.Pontos_de_resgate
ADD CONSTRAINT pontos_non_negative CHECK (Pontos >= 0);
