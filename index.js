// Função para validar URLs
function isValidUrl(url) {
  const pattern = /^https?:\/\/.+/i;
  return pattern.test(url);
}

function createOngCard(formData) {
  const cardDiv = document.createElement("div");
  cardDiv.className = "ong-card";

  // Crie o contêiner para o conteúdo (título, história e botão)
  const contentContainer = document.createElement("div");
  contentContainer.className = "content";

  // Crie o elemento de imagem
  const cardImage = document.createElement("img");
  cardImage.src = formData.imagemOng;
  cardImage.alt = "Logo da ONG"; // Adicione um texto alternativo para acessibilidade

  // Crie o título da ONG como um elemento h3
  const cardTitle = document.createElement("h3");
  cardTitle.innerText = formData.nomeOng;

  // Crie a história da ONG como um parágrafo
  const cardHistory = document.createElement("p");
  cardHistory.innerText = formData.historiaOng;

  // Crie o botão "Ajude aqui" como um link
  const cardButton = document.createElement("a");
  cardButton.href = formData.urlOng;
  cardButton.target = "_blank"; // Abre o link em uma nova janela
  cardButton.className = "help-button";
  cardButton.innerText = "Ajude aqui";

  contentContainer.appendChild(cardTitle);
  contentContainer.appendChild(cardHistory);
  contentContainer.appendChild(cardButton);

  cardDiv.appendChild(cardImage);
  cardDiv.appendChild(contentContainer);

  return cardDiv;
}

// Função para criar cartões com base nos dados do localStorage
function createOngCards() {
  const ongCardsContainer = document.getElementById("ongCards");

  // Limpar os cartões existentes
  ongCardsContainer.innerHTML = "";

  // Recuperar e exibir os dados do localStorage, se disponíveis
  const formDataArrayJSON = localStorage.getItem("formDataArray");
  if (formDataArrayJSON) {
    const formDataArray = JSON.parse(formDataArrayJSON);

    // Criar cartões a partir dos dados armazenados
    formDataArray.forEach(function (formData) {
      const cardDiv = createOngCard(formData);
      ongCardsContainer.appendChild(cardDiv);
    });
  }
}

// Chame a função para criar cartões quando a página é carregada
document.addEventListener("DOMContentLoaded", createOngCards);

// Função para atualizar o contador de caracteres em tempo real
function atualizarContador() {
  const textareaOng = document.getElementById("historiaOng");
  const contadorOng = document.getElementById("caracteresRestantes");
  const maxCaracteresOng = 300;

  if (contadorOng) {
    const caracteresDigitadosOng = textareaOng.value.length;
    const caracteresRestantesOng = maxCaracteresOng - caracteresDigitadosOng;

    contadorOng.textContent = caracteresRestantesOng + " caracteres restantes";
  }
}

// Adicione um ouvinte de evento de entrada aos campos de texto
document.getElementById("historiaOng").addEventListener("input", atualizarContador);

// Função para limpar todos os campos do formulário
function limparFormulario() {
  const textareaOng = document.getElementById("historiaOng");
  const nomeOng = document.getElementById("nomeOng");
  const imagemOng = document.getElementById("imagemOng");
  const urlOng = document.getElementById("urlOng");

  // Limpar os valores dos campos
  textareaOng.value = "";
  nomeOng.value = "";
  imagemOng.value = "";
  urlOng.value = "";

  // Atualizar o contador após limpar
  atualizarContador();
}

// Adicione um ouvinte de evento ao botão "Limpar Formulário"
document.getElementById("reset").addEventListener("click", function() {
  limparFormulario();
});

// Mova a definição da função submitForm para o escopo global
function submitForm(event) {
  event.preventDefault(); // Impede a recarga da página

  const nomeOng = document.getElementById("nomeOng").value;
  const historiaOng = document.getElementById("historiaOng").value;
  const urlOng = document.getElementById("urlOng").value;
  const imagemOngInput = document.getElementById("imagemOng");
  const imagemOngPath = URL.createObjectURL(imagemOngInput.files[0]);

  if (nomeOng === "" || historiaOng === "" || urlOng === "") {
    alert("Por favor, preencha todos os campos do formulário.");
    return;
  }

  // Adicionar validação de URL
  if (!isValidUrl(urlOng)) {
    alert("URL inválida. Insira uma URL válida.");
    return;
  }

  // Recuperar dados existentes do localStorage ou inicializar um array vazio
  const formDataArray = JSON.parse(localStorage.getItem("formDataArray")) || [];

  // Criar um objeto para representar os dados do formulário atual
  const formData = {
    nomeOng,
    historiaOng,
    urlOng,
    imagemOng: imagemOngPath,
  };

  const ongCardsContainer = document.getElementById("ongCards");
  const cardDiv = createOngCard(formData);
  ongCardsContainer.appendChild(cardDiv);

  // Adicionar os dados do formulário atual ao array
  formDataArray.push(formData);

  // Armazenar o array atualizado no localStorage
  try {
    localStorage.setItem("formDataArray", JSON.stringify(formDataArray));
    console.log("Formulário enviado com sucesso!");
  } catch (error) {
    console.error("Erro ao armazenar os dados no localStorage:", error);
    // Você pode adicionar tratamento de erros mais robusto aqui
  }

  // Limpar os campos do formulário
  document.getElementById("nomeOng").value = "";
  document.getElementById("historiaOng").value = "";
  document.getElementById("urlOng").value = "";
  document.getElementById("imagemOng").value = "";

  // Recarregue ou atualize a exibição dos cartões aqui, se necessário
  createOngCards();
}

function limparLocalStorage() {
  localStorage.removeItem("formDataArray");
}

document.addEventListener("DOMContentLoaded", function () {
  limparLocalStorage(); // Chame a função para limpar o localStorage quando a página é carregada
});