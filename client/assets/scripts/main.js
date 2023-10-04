//#region ENTRY

//#region ENTRY FORM

const sendUserDataBtn = document.querySelector("#sendUserData");
const sendVisitBtn = document.querySelector("#sendVisit");
const scanBtn = document.querySelector("#scanBtn");
const validateScanReturnBtn = document.querySelector("#validateScanReturn");
const emailFormBtn = document.querySelector("#emailFormBtn");

const chooseFormCont = document.querySelector("#chooseFormCont");
const chooseSessPers = document.querySelector("#choose-session-personnel");
const visitReason = document.querySelector("#visitReason");
const visitorCard = document.querySelector("#visitorCard");
const cameraSelector = document.querySelector("#cameraSelector");
const visitorEmail = document.querySelector("#visitorEmail");

const root = `http://localhost/visit-formation/`;

let formVisitorData = {},
	visitorId,
	visitId;

async function getVisitorId(formData) {
	let id;
	let url = `${root}visiteurs/AND/matches/email/${formData.email}`;
	let response = await fetch(url);
	let data = await response.json();
	id = data.content[0].id_visiteur;
	return id;
}
async function getSessionId(dateToday, id_formation) {
	let url = `${root}sessions/${dateToday}/${id_formation}`;
	if (visitReason.value === "formations") {
		const response = await fetch(url);
		const data = await response.json();
		if (data.content[0] != "") {
			return data.content[0].id_session;
		} else {
			return null;
		}
	} else {
		return null;
	}
}

sendUserDataBtn.addEventListener("click", e => {
	e.preventDefault();
	formVisitorData = {
		prenom: document.querySelector("#firstname").value,
		nom: document.querySelector("#lastname").value,
		email: document.querySelector("#email").value,
	};

	let url = `${root}visiteurs`;
	if (formVisitorData.prenom && formVisitorData.nom && formVisitorData.email) {
		fetch(url, {
			method: "POST",
			headers: {
				"Content-Type": "application/json",
			},
			body: JSON.stringify(formVisitorData),
		})
			.then(response => {
				return response.json();
			})
			.then(async data => {
				visitorId = await getVisitorId(formVisitorData);
			});
		chooseFormCont.style.display = "block";
	} else {
		alert(
			'Tous les champs du formulaires "Données du visiteur" doivent être remplis'
		);
	}
});

function showFormationList(route) {
	chooseSessPers.innerHTML = `<option value="0">-</option>`;
	let url = `${root}${route}`;
	fetch(url)
		.then(response => {
			return response.json();
		})
		.then(data => {
			for (const row of data.content) {
				let option = document.createElement("option");
				if (route === "formations") {
					option.innerText = row.intitule;
					option.value = row.id_formation;
				} else {
					option.innerText = `${row.nom} ${row.prenom}`;
					option.value = `${row.id_personnel}`;
				}
				chooseSessPers.appendChild(option);
			}
		});
}

visitReason.addEventListener("change", () => {
	showFormationList(visitReason.value);
});
showFormationList(visitReason.value);

async function ifIsFormation(sessionId) {
	if (sessionId == null) {
		alert("Pas de session trouvée pour votre visite aujoud'hui");
	} else {
		stagiaires_sessions = {
			id_session: sessionId,
			id_visiteur: visitorId,
			object_visite: "formations",
		};
		let url = `${root}stagiaires_sessions`;
		fetch(url, {
			method: "POST",
			headers: {
				"Content-Type": "application/json",
			},
			body: JSON.stringify(stagiaires_sessions),
		}).then(response => response.json());
	}
}

async function postVisitHistory(isFormation, sessionId) {
	let history = {
		id_visiteur: visitorId,
		id_session: sessionId,
		id_personnel: !isFormation ? +chooseSessPers.value : null,
		date_entree: getNowDate(),
		date_sortie: null,
		objet_visite: isFormation ? "formation" : "visite_personnel",
	};

	let url = `${root}historique_visites`;
	fetch(url, {
		method: "POST",
		headers: {
			"Content-Type": "application/json",
		},
		body: JSON.stringify(history),
	}).then(response => response.json());
}

async function getVisitId() {
	let id;
	let url = `${root}historique_visites/AND/matches/date_entree/${getTodayDate()}/id_visiteur/${visitorId}`;

	let response = await fetch(url);
	let data = await response.json();
	id = data.content[0].id_visite;
	return id;
}

async function getCardData(isFormation, visitId, sessionId) {
	if (isFormation) {
		url = `${root}visiteur_session_info/AND/matches/id_session/${sessionId}/id_visiteur/${visitorId}`;
	} else {
		url = `${root}visiteur_personnel_info/AND/matches/id_visite/${visitId}/id_visiteur/${visitorId}`;
	}

	let response = await fetch(url);
	let data = await response.json();
	return data.content[0];
}

sendVisitBtn.addEventListener("click", async e => {
	e.preventDefault();
	let isFormation = visitReason.value === "formations";
	let sessionId = await getSessionId(getTodayDate(), +chooseSessPers.value);

	if (isFormation) {
		await ifIsFormation(sessionId);
	}
	await postVisitHistory(isFormation, sessionId);
	visitId = await getVisitId();
	let tempCardData = await getCardData(isFormation, visitId, sessionId);
	let cardData = {};

	for (const key in tempCardData) {
		if (isNaN(parseInt(key))) {
			cardData[key] = tempCardData[key];
		}
	}
	let ul = visitorCard.querySelector("ul");
	for (const [key, value] of Object.entries(cardData)) {
		let li = document.createElement("li");
		li.innerHTML = `<b>${key}</b>: ${value}`;
		ul.appendChild(li);
	}
	genQrCode("qrcode", JSON.stringify({ visitId, visitorId }), 320);

	visitorCard.style.display = "block";
});

//#region FUNCTION GET DATE TODAY
function getTodayDate() {
	const today = new Date();
	const year = today.getFullYear();
	const month = String(today.getMonth() + 1).padStart(2, "0");
	const day = String(today.getDate()).padStart(2, "0");

	return `${year}-${month}-${day}`;
}
//#endregion

//#region FUNCTION GET DATE NOW
function getNowDate() {
	const today = new Date();
	const year = today.getFullYear();
	const month = String(today.getMonth() + 1).padStart(2, "0");
	const day = String(today.getDate()).padStart(2, "0");

	// Capture time details
	const hours = String(today.getHours()).padStart(2, "0");
	const minutes = String(today.getMinutes()).padStart(2, "0");
	const seconds = String(today.getSeconds()).padStart(2, "0");

	return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
}
//#endregion

//#region FUNCTION GEN QRCODE
function genQrCode(qrCodeNode, text, size = 320) {
	let qrcode = new QRCode(document.getElementById(qrCodeNode), {
		text,
		width: size,
		height: size,
	});
	return qrcode;
}

validateScanReturnBtn.addEventListener("click", e => {
	e.preventDefault();
	chooseFormCont.style.display = "block";
});

function showConfirmationCard(data) {
	let confirmationCard = document.querySelector("#confirmationCard");
	let ul = confirmationCard.querySelector("ul");
	data = data.content[0];

	formVisitorData = {
		nom: data.nom,
		prenom: data.prenom,
		email: data.email,
		id: data.id_visiteur,
	};

	visitorId = formVisitorData.id;

	for (let [key, value] of Object.entries(formVisitorData)) {
		let li = document.createElement("li");
		li.innerHTML = `<b>${key}:</b> ${value}`;
		ul.appendChild(li);
	}

	confirmationCard.style.display = "block";
}

emailFormBtn.addEventListener("click", e => {
	e.preventDefault();
	let email = visitorEmail.value;
	let url = `${root}visiteurs/AND/matches/email/${email}`;

	fetch(url)
		.then(response => response.json())
		.then(data => {
			showConfirmationCard(data);
		});
});

//#endregion

//#region QRCODE

// TODO: Manage entries by QRCodes

async function getVisitorData(scannedVisitorId) {
	let url = `${root}visiteurs/AND/matches/id_visiteur/${scannedVisitorId}`;

	fetch(url)
		.then(response => response.json())
		.then(data => {
			showConfirmationCard(data);
		});
}

Html5Qrcode.getCameras()
	.then(devices => {
		if (devices && devices.length) {
			devices.forEach(camera => {
				let option = document.createElement("option");
				option.innerText = camera.label;
				option.value = camera.id;
				cameraSelector.appendChild(option);
			});
		}
	})
	.catch(e => {
		console.error(e);
	});

scanBtn.addEventListener("click", e => {
	e.preventDefault();
	let scanAttempts = 0;
	const html5QrCode = new Html5Qrcode("reader");

	function onScanSuccess(decodedText, decodedResult) {
		let jsonDecode = JSON.parse(decodedText);
		getVisitorData(jsonDecode.visitorId);
		html5QrCode.stop();
	}

	function onScanFailure(errorMessage) {
		if (scanAttempts == 0) console.groupCollapsed("Scan Attempts");
		scanAttempts++;
		if (scanAttempts > 600) {
			html5QrCode.stop();
			console.groupEnd("Scan Attempts");
		}
		console.error(errorMessage);
	}

	html5QrCode
		.start(
			cameraSelector.value,
			{
				fps: 10,
				qrbox: { width: 320, height: 320 },
			},
			onScanSuccess,
			onScanFailure
		)
		.catch(err => {
			console.error(`Failed to start scanning: ${err}`);
		});
});

//#endregion
