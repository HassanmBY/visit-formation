const whosThere = document.querySelector("#whosThere");
const root = `http://localhost/visit-formation/`;

if (typeof EventSource !== "undefined") {
	let source = new EventSource(`/visit-formation/sse.php`);
	source.addEventListener("message", e => {
		let tb = whosThere.querySelector("tbody");
		tb.innerHTML = "";
		let data = JSON.parse(e.data);
		for (const row of data) {
			let tr = document.createElement("tr");
			tr.innerHTML = `<td>${row.nom}</td> <td>${row.prenom}</td> <td><a class="underline text-blue-600 hover:text-blue-800 visited:text-purple-600" href="mailto:${row.email}">${row.email}</a></td>`;

			tb.appendChild(tr);
		}
	});
} else {
	let errorBox = document.querySelector("#errorBox");
	errorBox.style.display = "block";
	errorBox.innerHTML = "No support for the SSE API";
}

const formateursList = document.querySelector("#formateurs");
const adminsList = document.querySelector("#admins");

function updateFonction(id, fonction) {
	let url = `${root}personnel`;

	let data = {
		id: +id,
		fonction: fonction,
	};

	console.log(data);

	fetch(url, {
		method: "PUT",
		headers: {
			"Content-Type": "application/json",
		},
		body: JSON.stringify(data),
	})
		.then(response => response.json())
		.then(data => console.log(data))
		.catch(e => console.error(e));
}

const listContainers = document.querySelectorAll(".listContainers");

for (const container of listContainers) {
	container.addEventListener("dragover", e => {
		e.preventDefault();
		let draggable = document.querySelector(".dragging");
		container.appendChild(draggable);
	});
}

function getPersonnelList() {
	let url = `${root}personnel`;
	fetch(url)
		.then(response => response.json())
		.then(data => {
			data = data.content;

			for (const row of data) {
				let li = document.createElement("li");
				li.innerText = `${row.nom} ${row.prenom}`;
				li.setAttribute("draggable", true);
				li.classList.add("draggable");
				li.dataset.id = row.id_personnel;
				li.dataset.fonction = row.fonction;

				li.addEventListener("dragstart", () => {
					li.classList.add("dragging");
				});

				li.addEventListener("dragend", e => {
					li.classList.remove("dragging");
					let container = e.target.parentNode.dataset.container;
					updateFonction(li.dataset.id, container);
					console.log(container);
				});

				if (row.fonction == "formateur") {
					formateursList.appendChild(li);
				} else {
					adminsList.appendChild(li);
				}
			}
		});
}

getPersonnelList();

const date = document.querySelector("#date");
const historique = document.querySelector("#historique");

function updateHistorique() {
	let filterDate = date.value;
	let url = `${root}visite_details/AND/contains/entree/${filterDate}`;
	fetch(url)
		.then(response => response.json())
		.then(data => {
			let tb = historique.querySelector("tbody");

			for (const row of data.content) {
				let tr = document.createElement("tr");
				let tableData = {
					v_nom: row.nom_visiteur,
					v_prenom: row.prenom_visiteur,
					email: row.email,
					entree: row.entree,
					sortie: row.sortie || "Pas de sortie enregistrée",
					objet: row.objet,
					p_nom: row.nom_personnel,
					p_prenom: row.prenom_personnel,
				};

				for (const [key, value] of Object.entries(tableData)) {
					let td = document.createElement("td");
					td.innerHTML = value;
					tr.appendChild(td);
				}

				tb.appendChild(tr);
			}
		});
}

date.addEventListener("change", () => {
	updateHistorique();
});

//#region Modifier les données
//#region Modifier formateur
const personnelContainer = document.querySelector("#personnelContainer");

function loadPersonnel() {
	let url = `${root}personnel`;
	fetch(url)
		.then(response => response.json())
		.then(data => {
			data = data.content;
			let select = personnelContainer.querySelector("select");
			let hiddenField = personnelContainer.querySelector("#p_id");
			hiddenField.value = 1;
			for (const row of data) {
				let option = document.createElement("option");
				option.value = row.id_personnel;
				option.innerText = `${row.nom} ${row.prenom}`;
				select.appendChild(option);
			}
		});
}
loadPersonnel();

let formateursListSelect = document.querySelector("#formateursList");
const formFields = {
	nom: document.querySelector("#p_nom"),
	prenom: document.querySelector("#p_prenom"),
	fonction: document.querySelector("#selectFonction"),
	local: document.querySelector("#local"),
	tel: document.querySelector("#phone"),
	hidden: document.querySelector("#p_id"),
};

function onListUpdate() {
	let personnel_id = !formateursListSelect.value
		? 1
		: formateursListSelect.value;
	let url = `${root}personnel/AND/matches/id_personnel/${+personnel_id}`;
	fetch(url)
		.then(response => response.json())
		.then(data => {
			data = data.content[0];
			formFields.nom.value = data.nom;
			formFields.prenom.value = data.prenom;
			formFields.fonction.value = data.fonction;
			formFields.local.value = data.local;
			formFields.tel.value = data.tel_interne;
			formFields.hidden.value = +data.id_personnel;
		});
}

formateursListSelect.addEventListener("change", () => {
	onListUpdate();
});

onListUpdate();

const majPersoBtn = document.querySelector("#majPerso");

majPersoBtn.addEventListener("click", e => {
	e.preventDefault();
	let dataToSend = {
		nom: document.querySelector("#p_nom").value,
		prenom: document.querySelector("#p_prenom").value,
		fonction: document.querySelector("#selectFonction").value,
		local: document.querySelector("#local").value,
		tel_interne: document.querySelector("#phone").value,
		id: document.querySelector("#p_id").value,
	};
	let url = `${root}personnel`;
	fetch(url, {
		method: "PUT",
		headers: {
			"Content-Type": "application/json",
		},
		body: JSON.stringify(dataToSend),
	})
		.then(response => response.json())
		.then(data => location.reload())
		.catch(e => console.log(e));
});
//#endregion

//#region Modifier Formation

const majFormaBtn = document.querySelector("#majForma");

function getFormationsList() {
	let url = `${root}formations`;
	fetch(url)
		.then(response => response.json())
		.then(data => {
			data = data.content;
			let select = document.querySelector("#formationsList");

			for (const row of data) {
				let option = document.createElement("option");
				option.value = row.id_formation;
				option.innerText = row.intitule;
				select.appendChild(option);
			}
		});
}

getFormationsList();

majFormaBtn.addEventListener("change", e => {
	e.preventDefault();
});

//#endregion

//#endregion
