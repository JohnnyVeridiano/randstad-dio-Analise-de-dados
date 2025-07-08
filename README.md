# randstad-dio-Analise-de-dados

# 📘 Guia de Criação de Recursos de Teste no Azure Speech Studio e Language Studio

Este documento tem como objetivo orientar passo a passo como criar recursos de teste nos serviços **Speech Studio** e **Language Studio** da Microsoft Azure.  

---

## 🛠️ Pré-requisitos

Antes de começar, certifique-se de ter:

- Conta ativa no [Azure Portal](https://portal.azure.com)
- Assinatura válida do Azure (plano gratuito é suficiente para testes)
- Navegador atualizado
- Permissões para criar recursos no portal

---

## 🎤 Criando recurso de teste no Azure Speech Studio

### 1. Acessar o Speech Studio

Acesse o [Speech Studio](https://speech.microsoft.com/).

### 2. Criar um recurso de Fala (Speech)

1. Vá até o [Azure Portal](https://portal.azure.com).
2. Clique em **"Criar um recurso"**.
3. Procure por **Speech** ou **Fala**.
4. Clique em **"Criar"**.
5. Preencha os campos obrigatórios:
   - **Assinatura**: Selecione sua assinatura
   - **Grupo de recursos**: Crie um novo ou use um existente
   - **Nome da instância**: Ex: `speech-teste`
   - **Região**: Escolha a mesma do Language Studio, ex: `Brazil South`
   - **Tipo de preço**: F0 (gratuito) para testes
6. Clique em **"Revisar e Criar"**, depois em **"Criar"**.

### 3. Usar o recurso no Speech Studio

1. Retorne ao [Speech Studio](https://speech.microsoft.com/).
2. Faça login com a mesma conta usada no Azure.
3. Vá até o menu lateral e escolha funcionalidades como:
   - **Text-to-Speech**
   - **Speech-to-Text**
   - **Custom Voice**
4. Ao iniciar o uso, selecione o recurso criado anteriormente.

---

## 🧠 Criando recurso de teste no Azure Language Studio

### 1. Acessar o Language Studio

Acesse o [Language Studio](https://language.cognitive.azure.com/).

### 2. Criar um recurso de Linguagem (Language)

1. No [Azure Portal](https://portal.azure.com), clique em **"Criar um recurso"**.
2. Pesquise por **Language**.
3. Clique em **"Criar"**.
4. Preencha os campos:
   - **Assinatura**
   - **Grupo de recursos**
   - **Nome do recurso**: Ex: `language-teste`
   - **Região**: Igual ao recurso de fala
   - **Plano tarifário**: F0 (gratuito)
5. Clique em **"Revisar e Criar"** → **Criar**

### 3. Usar o recurso no Language Studio

1. Acesse o [Language Studio](https://language.cognitive.azure.com/).
2. Faça login e selecione o recurso criado.
3. Utilize as funcionalidades disponíveis, como:
   - **Análise de sentimento**
   - **Extração de frases-chave**
   - **Classificação de texto**
   - **Reconhecimento de entidades nomeadas (NER)**
4. Cada funcionalidade permite o uso com exemplos prontos ou dados personalizados.

---

