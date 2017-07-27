# ruby encoding: utf-8
PaymentState.where(name: "uncharted", name_de: "unbekannt").first_or_create
PaymentState.where(name: "cash benefit", name_de: "bezahlt").first_or_create
PaymentState.where(name: "noncash benefit", name_de: "geldlos vergütet").first_or_create
PaymentState.where(name: "no payment", name_de: "keine Bezahlung").first_or_create

RegistrationState.where(name: "not in examination office", name_de: "nicht beim Prüfungsamt").first_or_create
RegistrationState.where(name: "in examination office", name_de: "beim Prüfungsamt").first_or_create
RegistrationState.where(name: "accepted", name_de: "zugelassen").first_or_create
RegistrationState.where(name: "accepted, but passed courses are still missing", name_de: "zugelassen, aber bestandene Kurse nicht vorhanden").first_or_create
RegistrationState.where(name: "accepted, but contract is still missing", name_de: "zugelassen, aber Vertrag nicht vorhanden").first_or_create

ContractState.where(name: "missing", name_de: "nicht vorhanden").first_or_create
ContractState.where(name: "copy in the office", name_de: "Kopie vorhanden").first_or_create
ContractState.where(name: "original in examination office", name_de: "Original beim Prüfungsamt").first_or_create

ReportState.where(name: "missing", name_de: "nicht vorhanden").first_or_create
ReportState.where(name: "in the office", name_de: "vorhanden").first_or_create
ReportState.where(name: "read", name_de: "gelesen").first_or_create

CertificateState.where(name: "missing", name_de: "nicht vorhanden").first_or_create
CertificateState.where(name: "in the office", name_de: "vorhanden").first_or_create
CertificateState.where(name: "signed by professor in charge", name_de: "von zuständigem Professor unterschrieben").first_or_create
CertificateState.where(name: "signed by internship officer", name_de: "vom Praktikumsbeauftragten unterschrieben").first_or_create
CertificateState.where(name: "in examination office", name_de: "beim Prüfungsamt").first_or_create

InternshipState.where(name: "passed", name_de: "bestanden").first_or_create
InternshipState.where(name: "internship was abandoned because of the following reasons", name_de: "abgelehnt aus folgenden Gründen").first_or_create
InternshipState.where(name: "the student still has to pass the following courses", name_de: "Student hat die folgenden Kurse zu absolvieren").first_or_create
