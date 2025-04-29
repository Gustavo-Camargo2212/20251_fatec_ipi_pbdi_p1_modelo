-- ----------------------------------------------------------------
-- 1 Base de dados e criação de tabela
--escreva a sua solução aqui
CREATE TABLE ESTUDANTES (
    ID SERIAL PRIMARY KEY,
    MOTHER_EDU INT,
    FATHER_EDU INT,
    GRADE INT,
    PREP_STUDY INT,
    PARTNER INT,
    SALARY INT,
    PREP_EXAM INT
);


-- ----------------------------------------------------------------
-- 2 Resultado em função da formação dos pais
--escreva a sua solução aqui
DO $$
DECLARE
    cur_estudantes CURSOR FOR
        SELECT id, mother_edu, father_edu, grade FROM estudantes
        WHERE grade = 1
          AND (mother_edu = 1 OR father_edu = 1);

    v_id INT;
    v_mother_edu INT;
    v_father_edu INT;
    v_grade INT;

    contador_aprovados INT := 0;
BEGIN
    OPEN cur_estudantes;

    LOOP
        FETCH cur_estudantes INTO v_id, v_mother_edu, v_father_edu, v_grade;
        EXIT WHEN NOT FOUND;

        contador_aprovados := contador_aprovados + 1;
    END LOOP;

    CLOSE cur_estudantes;

    RAISE NOTICE 'Total de alunos aprovados com pelo menos um dos pais PhD: %', contador_aprovados;
END $$;


-- ----------------------------------------------------------------
-- 3 Resultado em função dos estudos
--escreva a sua solução aqui


-- ----------------------------------------------------------------
-- 4 Salário versus estudos
--escreva a sua solução aqui


-- ----------------------------------------------------------------
-- 5. Limpeza de valores NULL
--escreva a sua solução aqui

-- ----------------------------------------------------------------