# Projeto Adventure Works - Data Warehouse e Dashboard de Vendas

## Objetivo do Projeto

O objetivo deste projeto é estruturar os dados da base **Adventure Works** utilizando o **DBT Cloud** e o **Databricks**, com a finalidade de criar um **modelo de dados eficiente** para possibilitar a análise de vendas, clientes, produtos e promoções. As análises são realizadas por meio de um **dashboard interativo no Power BI**, com o foco em fornecer **insights financeiros** essenciais para a empresa.

## Estruturação do Projeto

O projeto foi estruturado com as seguintes etapas:

1. **Identificação das fontes de dados**: Inicialmente, foram analisadas as tabelas brutas que seriam utilizadas para formar as dimensões e a tabela de fato.
2. **Criação das Tabelas Dimensões e Tabela Fato**: Definimos as dimensões essenciais como **clientes**, **produtos**, **tempo** e **territórios**. A tabela fato foi criada com o grão no nível de item do pedido, incorporando métricas como **vendas brutas** e **vendas líquidas**.
3. **Transformação de Dados**: Usando o **DBT Cloud**, realizamos as transformações de dados, criando tabelas de staging e processando os dados para formatação e padronização.
4. **Aplicação de Testes**: Testes de **not_null**, **unique** e **relationships** foram aplicados nas dimensões e na tabela de fato para garantir a qualidade dos dados.
5. **Criação do Dashboard**: O dashboard foi desenvolvido no **Power BI**, contendo gráficos interativos e KPIs (Indicadores Chave de Desempenho), como **ticket médio**, **vendas líquidas**, **vendas brutas**, **top produtos**, e **desempenho por região**.

## Etapas de Desenvolvimento

1. **Conexão com o Databricks**: A base de dados foi clonada para o **Databricks**, utilizando a tabela de **Adventure Works**. Os notebooks SQL foram usados para visualizar e entender as tabelas antes de seguir para a modelagem.
2. **Configuração do DBT Cloud**: O **DBT Cloud** foi configurado para se conectar ao **Databricks** e possibilitar a interação com o banco de dados. Um repositório no **GitHub** foi criado para versionamento do código e governança dos dados.
3. **Criação das Tabelas de Fato e Dimensões**: A tabela de fato **fct_sales** foi criada a partir das tabelas de vendas, e as dimensões foram estruturadas para fornecer a categorização necessária para as análises.
4. **Testes e Validação**: Foi realizada uma validação das métricas e a integridade dos dados foi verificada com os testes aplicados nas fontes e nas tabelas.
5. **Integração com o Power BI**: A integração entre o **Power BI** e o **Databricks** foi configurada, permitindo a visualização dos dados de forma interativa.

## Estrutura do Banco de Dados

### Tabela Fato: `fct_sales`

A **tabela fato** `fct_sales` armazena as métricas de vendas no nível de item de pedido. As principais métricas incluem **vendas brutas** e **vendas líquidas**, com cálculos como:

- **gross_sales**: Valor bruto das vendas, calculado como `unitprice * orderqty`.
- **net_sales**: Valor líquido das vendas após aplicação do desconto, calculado como `unitprice * orderqty * (1 - unitpricediscount)`.

### Tabelas Dimensões

- **`dim_cliente`**: Contém informações sobre os clientes, como `customerid`, `full_name`, `emailaddress`.
- **`dim_produto`**: Contém detalhes dos produtos, como `productid`, `name`, `listprice`, `safetystocklevel`.
- **`dim_tempo`**: Contém dados temporais, como `orderdate`, `ano`, `mes`, `trimestre`.
- **`dim_territorio`**: Contém informações sobre os territórios de vendas, como `territoryid`, `territory_name`.

### Arquivos de Documentação

O projeto conta com **documentação detalhada** de cada modelo e coluna no formato **YML**. Os arquivos YML incluem a **descrição** de cada tabela e **testes de qualidade** como `not_null`, `unique`, e `relationships` entre as tabelas.

## Métricas Criadas

As principais **métricas de análise** no **Power BI** incluem:

- **Valor Líquido**: Calculado com base no preço unitário, quantidade e desconto aplicado.
- **Venda Bruta**: Valor total sem desconto, calculado como `unitprice * orderqty`.
- **Desconto do Produto**: Valor do desconto concedido, calculado como `(unitprice * orderqty) * unitpricediscount`.
- **Ticket Médio**: Média do valor das vendas por transação.
- **Quantidade Vendida**: Soma de unidades vendidas.
- **Número de Pedidos**: Quantidade total de transações realizadas.

## Resultados Esperados

O projeto proporcionará uma **visão estratégica das vendas**, incluindo análises de:

- **Crescimento de vendas** e **desempenho por produto**.
- **Impacto das promoções** nas vendas líquidas.
- **Desempenho por região** geográfica.
- **Análises financeiras** sobre o **ticket médio** e a **quantidade vendida**.

## Como Rodar o Projeto

Para rodar o projeto localmente, siga os passos abaixo:

1. Clone o repositório:
   ```bash
   git clone https://github.com/JeffersonOtharan/dbt-databricks-academy.git
   
2. Configure o DBT Cloud para se conectar ao Databricks.

Execute os modelos com o comando:

dbt run

3. Execute os testes de qualidade de dados:

dbt test

4. Abra o Power BI para visualizar o dashboard interativo.
