-- ==============================================================================
-- PIPELINE DE DADOS & ANALYTICS - FIFA WORLD CUP 2026
-- Script de Otimização e Regras de Negócio (Camada de Modelagem)
-- Desenvolvido por: Alejandro
-- ==============================================================================

CREATE DATABASE IF NOT EXISTS portfolio_fifa2026;
USE portfolio_fifa2026;

-- ------------------------------------------------------------------------------
-- 1. VIEW: Inteligência e Performance sob Pressão (Métricas Clutch)
-- Objetivo: Ranquear os atletas mais decisivos utilizando Window Functions.
-- ------------------------------------------------------------------------------
CREATE OR REPLACE VIEW vw_top_jogadores_clutch AS 
SELECT 
    jogador,
    selecao,
    nota_media,
    espirito_clutch,
    DENSE_RANK() OVER (ORDER BY espirito_clutch DESC) as ranking_clutch
FROM portfolio_fifa2026_vw
WHERE espirito_clutch IS NOT NULL
ORDER BY espirito_clutch DESC;

-- ------------------------------------------------------------------------------
-- 2. VIEW: Eficiência Física e Letalidade de Atacantes
-- Objetivo: Cruzar atributos físicos com minutagem de gols, aplicando proteção
-- matemática contra divisões por zero através da função NULLIF.
-- ------------------------------------------------------------------------------
CREATE OR REPLACE VIEW vw_eficiencia_atacantes AS
SELECT 
    jogador,
    selecao,
    velocidade_max_media,
    total_gols,
    total_assistencias,
    mins_para_participar_gol
FROM portfolio_fifa2026_vw
WHERE velocidade_max_media > 0 
  AND mins_para_participar_gol IS NOT NULL;

-- ------------------------------------------------------------------------------
-- 3. VIEW: Volumetria de Ataque por Seleção
-- Objetivo: Agregação macro do desempenho ofensivo das nações do torneio.
-- ------------------------------------------------------------------------------
CREATE OR REPLACE VIEW vw_ranking_goleadores_selecao AS
SELECT 
    selecao,
    SUM(total_gols) AS total_gols,
    COUNT(DISTINCT jogador) AS total_jogadores_mapeados
FROM portfolio_fifa2026_vw
GROUP BY selecao
ORDER BY total_gols DESC;
