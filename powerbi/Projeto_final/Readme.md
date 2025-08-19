# Guia de Configuração: MySQL no Azure + Integração com Power BI

Este guia descreve o passo a passo para:
1. Criar uma instância MySQL no **Azure**.
2. Criar o banco de dados usando o script SQL fornecido.
3. Integrar o **Power BI** ao MySQL hospedado no Azure.

---

## 1. Criação de uma instância no Azure para MySQL

### Passo 1 – Acessar o Portal Azure
- Entre em [https://portal.azure.com](https://portal.azure.com) com sua conta Microsoft.

### Passo 2 – Criar o recurso MySQL
1. No painel inicial, clique em **Criar um recurso**.
2. Pesquise por **Banco de dados MySQL** e selecione **Banco de dados MySQL – Servidor Único** ou **Servidor Flexível** (recomendado).
3. Clique em **Criar**.

### Passo 3 – Configurações básicas
- **Assinatura**: selecione sua assinatura ativa.
- **Grupo de recursos**: crie um novo ou use um existente.
- **Nome do servidor**: defina um nome único.
- **Região**: escolha a mais próxima de você.
- **Versão do MySQL**: escolha 8.0 (recomendado).
- **Usuário administrador**: defina um nome e senha fortes.
- **Computação + Armazenamento**: configure de acordo com sua necessidade (plano Básico já é suficiente para testes).

### Passo 4 – Configurações de rede
- Em **Acesso de rede**, habilite **Permitir acesso de qualquer endereço IP** ou adicione manualmente seu IP atual.
- Ative **SSL** se necessário (o Power BI pode exigir).

### Passo 5 – Revisar e criar
- Clique em **Revisar + criar** → **Criar**.
- Aguarde até a implantação ser concluída.

---

## 2. Criar o Banco de Dados a partir do script do GitHub

### Passo 1 – Baixar o script
- Baixe o arquivo SQL do link:  
  [script_bd_company.sql](https://github.com/julianazanelatto/power_bi_analyst/blob/main/M%C3%B3dulo%203/Desafio%20de%20Projeto/script_bd_company.sql)

> 💡 No GitHub, clique em **Raw** e salve o conteúdo como `script_bd_company.sql`.

### Passo 2 – Conectar-se ao MySQL no Azure
Você pode usar:
- **MySQL Workbench** (recomendado)
- **Azure Cloud Shell**
- **Linha de comando MySQL**

Exemplo usando MySQL Workbench:
1. Abra o Workbench → clique em **+** para criar nova conexão.
2. Em **Hostname**, coloque o endereço do servidor (ex.: `meuservidor.mysql.database.azure.com`).
3. **Porta**: 3306  
4. **Usuário**: admin definido na criação.
5. Marque **Use SSL** se configurado.
6. Teste e salve a conexão.

### Passo 3 – Executar o script
1. No Workbench, conecte-se ao servidor.
2. Abra o arquivo `script_bd_company.sql`.
3. Execute o script para criar as tabelas e popular o banco.

---

## 3. Integração do Power BI com MySQL no Azure

### Pré-requisito:
- Instalar o **MySQL Connector/ODBC** no computador:  
  [Download do MySQL Connector](https://dev.mysql.com/downloads/connector/odbc/)

### Passo 1 – Abrir o Power BI Desktop
- Vá em **Obter Dados** → **Banco de dados MySQL**.

### Passo 2 – Configurar a conexão
- **Servidor**: coloque o host do Azure (ex.: `meuservidor.mysql.database.azure.com`).
- **Banco de Dados**: nome do banco criado (ex.: `company`).
- Porta padrão: 3306.

### Passo 3 – Autenticação
- Método: **Nome de usuário e senha**.
- **Usuário**: `usuario@nomedoservidor` (no Azure é necessário o sufixo `@servidor`).
- Senha: senha definida na criação.
- Marque **Conexão criptografada** se SSL estiver habilitado.

### Passo 4 – Carregar os dados
- Escolha as tabelas desejadas.
- Clique em **Carregar** para importar para o Power BI.

### Passo 5 – Criar relatórios
- Use os campos importados para criar visuais e dashboards.
- Publique no **Power BI Service** se desejar compartilhar.

---

## Observações
- **Firewall**: caso o Power BI não consiga se conectar, adicione o IP da sua máquina nas regras de firewall do servidor MySQL no Azure.
- **SSL**: para conexões seguras, baixe o certificado SSL no portal Azure e configure no MySQL Workbench e no Power BI.
- **Custos**: o Azure cobra por hora e armazenamento; lembre-se de pausar ou excluir o recurso se não for mais utilizá-lo.

---
# Documentação do Processo no Power BI – Base `azure_company`

Este documento descreve todas as etapas realizadas no Power BI para o tratamento e preparação da base de dados **azure_company**.

---

##  1. Verificação dos cabeçalhos e tipos de dados
- Todos os cabeçalhos das tabelas foram revisados.  
- Ajustamos os **tipos de dados** (texto, número inteiro, número decimal, data) conforme a natureza de cada coluna para evitar inconsistências no modelo.

---

##  2. Ajuste de valores monetários
- As colunas de **salários e valores financeiros** foram convertidas para o tipo **Decimal Number (Double Precisão)**.  
- Isso assegura cálculos corretos em somas, médias e agregações.

---

##  3. Verificação de valores nulos
- Foi realizada análise de **valores nulos** em todas as tabelas.  
- A decisão de tratamento foi:  
  - Manter nulos que possuem contexto (ex.: `Super_ssn` para indicar ausência de gerente direto).  
  - Remover colunas/linhas apenas quando os nulos representavam dados irrelevantes ou inconsistentes.

---

##  4. Funcionários sem gerente
- Verificado que os **employees com `Super_ssn = NULL`** são, na verdade, **gerentes**.  
- Nenhum colaborador ficou sem gerente associado.

---

##  5. Departamentos sem gerente
- Foi analisado se todos os departamentos possuíam gerente definido (`Mgr_ssn`).  
- Identificado que todos os departamentos estão associados a um gerente.

---

##  6. Preenchimento de lacunas
- Caso houvesse algum departamento sem gerente, seria preenchido manualmente (simulação).  
- Neste caso, **não foi necessário** inserir dados fictícios, pois todos os registros estavam completos.

---

##  7. Verificação das horas em projetos
- Foi realizada análise da tabela `Works_on` para validar **horas atribuídas por funcionário em projetos**.  
- Nenhum valor inconsistente foi encontrado (ex.: horas negativas ou acima de limites esperados).

---

##  8. Separação de colunas complexas
- Foram tratadas colunas compostas (ex.: endereço completo).  
- As informações foram **divididas em colunas distintas** para facilitar análises (Rua, Cidade, Estado, CEP).

---

##  9. Mescla Employee + Department
- As tabelas `Employee` e `Department` foram mescladas.  
- Chave utilizada: `Dno` (número do departamento).  
- Tipo de junção: **Left Join**, mantendo todos os employees e apenas departamentos correspondentes.  
- Essa etapa permitiu associar **cada colaborador ao seu respectivo departamento**.

---

##  10. Eliminação de colunas desnecessárias
- Foram removidas colunas redundantes ou que não seriam utilizadas no relatório, garantindo **maior clareza e performance** do modelo.  

---

##  11. Junção de colaboradores e gerentes
- Foi realizada a mescla da tabela `Employee` consigo mesma:  
  - `Employee.Ssn` ↔ `Employee.Super_ssn`  
- Essa relação permitiu associar **cada colaborador ao nome do seu gerente**.  

---

## 12. Mescla Nome + Sobrenome

Criada coluna calculada Nome Completo mesclando Fname + Minit + Lname.

O mesmo foi feito para gerentes.

---

## 13. Mescla Departamento + Localização

Colunas DepartmentName e Location foram mescladas em uma nova coluna Departamento_Local.

Isso garante que cada combinação seja única, o que será essencial para construção futura do modelo estrela.
---
## 14.	Explique por que, neste caso supracitado, podemos apenas utilizar o mesclar e não o atribuir. 
- Neste caso, utilizamos Mesclar (Merge) em vez de Atribuir (Append), porque precisamos relacionar os colaboradores aos respectivos gerentes por meio da chave (Super_ssn → Ssn).
 O Mesclar funciona como um JOIN no SQL, permitindo trazer o nome do gerente para a tabela de colaboradores. Já o Atribuir apenas empilharia registros, o que não faria sentido, pois colaboradores e gerentes não devem ser apenas concatenados, mas sim relacionados.


 ## Como plus, criei um dashboard simples com os seguintes indicadores:

Card com total de funcionários

Barras → Funcionários por Gerente

Colunas → Funcionários por Departamento

Treemap → Projetos por Departamento

Colunas empilhadas → Horas por Projeto 

Mapa→ Funcionários por Local