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
        WHERE grade >= 2
          AND (mother_edu = 6 OR father_edu = 6);

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
DO $$
DECLARE
    sql_query TEXT;
    cur_estudantes REFCURSOR;
    v_id INT;
    v_grade INT;
    v_partner INT;

    contador_aprovados_sozinhos INT := 0;
BEGIN
    sql_query := 'SELECT id, grade, partner FROM estudantes WHERE grade >= 1 AND partner = 2';
    OPEN cur_estudantes FOR EXECUTE sql_query;

    LOOP
        FETCH cur_estudantes INTO v_id, v_grade, v_partner;
        EXIT WHEN NOT FOUND;

        contador_aprovados_sozinhos := contador_aprovados_sozinhos + 1;
    END LOOP;

    CLOSE cur_estudantes;
    IF contador_aprovados_sozinhos > 0 THEN
        RAISE NOTICE 'Total de alunos aprovados que estudam sozinhos: %', contador_aprovados_sozinhos;
    ELSE
        RAISE NOTICE 'Nenhum aluno aprovado que estuda sozinho. Valor retornado: -1';
    END IF;
END $$;


-- ----------------------------------------------------------------
-- 4 Salário versus estudos
--escreva a sua solução aqui
DO $$
DECLARE
    cur_salario_estudo CURSOR FOR
    SELECT ID
    FROM ESTUDANTES
    WHERE SALARY = 5
    AND PREP_STUDY = 2;

    v_estudante_id INT;
    v_count_estudante INT := 0;
    
BEGIN
    OPEN cur_salario_estudo;

    LOOP
        FETCH cur_salario_estudo INTO v_estudante_id;
        EXIT WHEN NOT FOUND;
        v_count_estudante := v_count_estudante + 1;
    END LOOP;

    CLOSE cur_salario_estudo;
    RAISE NOTICE 'Número de alunos com salário > 410 e preparação regular: %', v_count_estudante;

END $$;

-- ----------------------------------------------------------------
-- 5. Limpeza de valores NULL
--escreva a sua solução aqui

-- ----------------------------------------------------------------