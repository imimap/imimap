var count = 0;

function radios_activated(internship_id) {
  var checkboxId = "radio_contract_" + internship_id;
  var contract = "contract_" + internship_id;
  var radioOriginalId = "original_" + internship_id;
  var radioCopyId = "copy_" + internship_id;
  var cb = document.getElementById(checkboxId);
  var icon_ok = document.getElementById(contract);
  var rd_original = document.getElementById(radioOriginalId);
  var rd_copy = document.getElementById(radioCopyId);
  if (rd_original.checked == true || rd_copy.checked == true) {
    cb.checked = true;
    icon_ok.classList.remove('d-none');
    icon_ok.classList.add('d-block');
    icon_ok.style.display = "block";
  }
}

function fill_popup(internship_id, title, companyname) {
  count = 0;
  popup_title(title, companyname);
  insert_info("lsf_", internship_id, "lsf_ausdruck");
  insert_info("student_", internship_id, "pers_det");
  insert_info("company_", internship_id, "company_det");
  insert_info("internship_", internship_id, "internship_det");
  set_message();
  contract_info(internship_id);
}

function popup_title(title_parcial, companyname) {
  var title = document.getElementById("missing_information_title");
  title.textContent = title_parcial + companyname;
}

function insert_info(id_parcial, internship_id, element_id) {
  var checkboxId = id_parcial + internship_id;
  var cb = document.getElementById(checkboxId);
  var list_item = document.getElementById(element_id);
  if (cb.checked == true) {
    list_item.style.display = "none";
    count += 1;
  } else list_item.style.display = "block";
}

function set_message() {
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

function contract_info(internship_id) {
  var radioId = "original_" + internship_id;
  var rb = document.getElementById(radioId);
  var item = document.getElementById("no_original");
  var clear = document.getElementById("clear");
  if (rb.checked == true) {
    item.style.display = "none";
    clear.style.display = "block";
  } else {
    item.style.display = "block";
    clear.style.display = "none";
  }
}
