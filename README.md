# 🏆 FIFA World Cup 2026 — Analytics & Scout Dashboard

---

## 📝 Sobre o Projeto
Este projeto foi desenvolvido de ponta a ponta para resolver o desafio de consolidação de grandes volumes de dados esportivos. O objetivo principal foi centralizar, modelar e analisar estatísticas de performance de atletas para gerenciamento de scout técnico visando a **Copa do Mundo de 2026**.

O painel permite que analistas de mercado e comissões técnicas identifiquem de forma cirúrgica e ágil quais atacantes possuem a maior eficiência física, letalidade em finalizações e inteligência tática sob pressão (Métricas Clutch).

---

## 🛠️ Stack Tecnológica
* **Engine de Banco de Dados:** MySQL Local (Carga de dados, modelagem lógica e otimização).
* **Linguagem de Manipulação:** SQL Avançado (Views, Funções de Janela, Agregações Dinâmicas).
* **Business Intelligence:** Power BI Desktop (Modelagem dimensional, Expressões DAX, UI/UX Design).
* **Conector:** MySQL Native Database Connector.

---

## 📐 Engenharia de Dados & Estrutura SQL
Toda a inteligência de negócios e cálculos pesados foram processados diretamente no servidor **MySQL** sobre uma base histórica robusta de mais de **54.000 registros**, poupando memória de processamento do Power BI. 

Abaixo está o exemplo real de como as **Window Functions (`DENSE_RANK`)** foram empregadas na camada de banco para estruturar o índice competitivo dos atletas mais decisivos:

```sql
CREATE OR REPLACE VIEW vw_top_jogadores_clutch AS 
SELECT 
    jogador,
    selecao,
    nota_media,
    espirito_clutch,
    DENSE_RANK() OVER (ORDER BY espirito_clutch DESC) as ranking_clutch
FROM portfolio_fifa2026_vw
WHERE espirito_clutch IS NOT NULL;
