const root = `http://localhost/visit-formation/`;

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
		console.log(e);
	});

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

function registerLeaving(visitId) {
	let url = `${root}historique_visites`;

	let payload = { id: visitId, date_sortie: getNowDate() };

	fetch(url, {
		method: "PUT",
		headers: { "Content-Type": "application/json" },
		body: JSON.stringify(payload),
	})
		.then(response => response.json())
		.then(data => {
			console.log(data);
			let confirmationCard = document.querySelector("#confirmationCard");
			confirmationCard.style.display = "block";
		})
		.catch(e => console.log(e));
}

scanBtn.addEventListener("click", e => {
	e.preventDefault();
	let scanAttempts = 0;
	const html5QrCode = new Html5Qrcode("reader");

	function onScanSuccess(decodedText, decodedResult) {
		let jsonDecode = JSON.parse(decodedText);
		console.log(jsonDecode);
		registerLeaving(+jsonDecode.visitId);
		html5QrCode.stop();
	}

	function onScanFailure(errorMessage) {
		if (scanAttempts == 0) console.groupCollapsed("Scan Attempts");
		scanAttempts++;
		console.log(scanAttempts);
		if (scanAttempts > 600) {
			html5QrCode.stop();
			console.groupEnd("Scan Attempts");
		}
		console.log(errorMessage);
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
