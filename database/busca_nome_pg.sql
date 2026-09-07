-- Estrutura da tabela
CREATE TABLE IF NOT EXISTS clientes (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    status VARCHAR(20) DEFAULT 'ATIVO'
);

-- Incere cliente na tabela
TRUNCATE TABLE clientes;

INSERT INTO clientes (nome, email) VALUES 
('João Silva', 'joao@email.com'),
('Maria Silva Oliveira', 'maria@email.com'),
('Carlos Souza', 'carlos@email.com'),
('SILVANA COSTA', 'silvana@email.com');

-- Função de busca por nome do cliente 
CREATE OR REPLACE FUNCTION fn_buscar_clientes_por_nome(p_termo VARCHAR)
RETURNS TABLE (
    id INT,
    nome VARCHAR,
    email VARCHAR,
    status VARCHAR
) 
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT 
        c.id,
        c.nome,
        c.email,
        c.status
    FROM clientes c
    WHERE c.nome ILIKE '%' || p_termo || '%';
END;
$$;

-- Exemplo para testar a função de busca
-- SELECT * FROM fn_buscar_clientes_por_nome('silv');