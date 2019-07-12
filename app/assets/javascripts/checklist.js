var count = 0;

function popupTitle(titleParcial, companyName) {
  var title = document.getElementById("missing_information_title");
  title.textContent = titleParcial + companyName;
}

function insertInfo(idParcial, internshipId, elementId) {
  var checkboxId = idParcial + internshipId;
  var cb = document.getElementById(checkboxId);
  var listItem = document.getElementById(elementId);
  if (cb.checked === true) {
    listItem.style.display = "none";
    count += 1;
  } else {
    listItem.style.display = "block";
  }
}

function setMessage() {
  var missing1 = document.getElementById("missing1");
  var missing2 = document.getElementById("missing2");
  var clear = document.getElementById("clear");
  if (count >= 3) {
    missing1.style.display = "none";
    missing2.style.display = "none";
    clear.style.display = "block";
  } else {
    missing1.style.display = "block";
    missing2.style.display = "block";
    clear.style.display = "none";
  }
}

function contractInfo(internshipId) {
  var radioId = "original_" + internshipId;
  var rb = document.getElementById(radioId);
  var item = document.getElementById("no_original");
  var clear = document.getElementById("clear");
  if (rb.checked === true) {
    item.style.display = "none";
    clear.style.display = "block";
  } else {
    item.style.display = "block";
    clear.style.display = "none";
  }
}

function radiosActivated(internshipId) {
  var checkboxId = "radio_contract_" + internshipId;
  var contract = "contract_" + internshipId;
  var radioOriginalId = "original_" + internshipId;
  var radioCopyId = "copy_" + internshipId;
  var cb = document.getElementById(checkboxId);
  var iconOk = document.getElementById(contract);
  var rdOriginal = document.getElementById(radioOriginalId);
  var rdCopy = document.getElementById(radioCopyId);
  if (rdOriginal.checked === true || rdCopy.checked === true) {
    cb.checked = true;
    iconOk.classList.remove("d-none");
    iconOk.classList.add("d-block");
    iconOk.style.display = "block";
  }
}

function fillPopup(internshipId, title, companyName) {
  count = 0;
  popupTitle(title, companyName);
  insertInfo("lsf_", internshipId, "lsf_ausdruck");
  insertInfo("student_", internshipId, "pers_det");
  insertInfo("company_", internshipId, "company_det");
  insertInfo("internship_", internshipId, "internship_det");
  setMessage();
  contractInfo(internshipId);
}
