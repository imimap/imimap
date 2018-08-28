# frozen_string_literal: true

class InternshipPdf < Prawn::Document
  def initialize(internship)
    super()
    @student = internship.student
    @company = internship.company_v2
    @internship = internship
    @company_address = internship.company_address
    @semester = internship.semester
    header
    student_data
    company_data
    internship_data
    additional_information
  end

  def header
    text 'Hochschule für Technik und Wirtschaft Berlin',
         style: :bold, size: 15
    stroke_horizontal_rule
    text "Registration for internship during #{@semester.name}",
         style: :bold,
         align: :center
  end

  def student_data
    move_down 20
    text 'Student data:', style: :bold
    text_box 'First name',
             at: [0, 650]
    text_box ":   #{@student.first_name}",
             at: [100, 650]
    text_box 'Last name',
             at: [250, 650]
    text_box ":   #{@student.last_name}",
             at: [350, 650]
    text_box 'Birthday',
             at: [0, 630]
    text_box ":   #{@student.birthday}",
             at: [100, 630]
    text_box 'Birthplace',
             at: [250, 630]
    text_box ":   #{@student.birthplace}",
             at: [350, 630]

    text_box 'Phone',
             at: [0, 600]
    text_box ":   #{@student.phone}",
             at: [100, 600]
    text_box 'Email',
             at: [250, 600]
    text_box ":   #{@student.email}",
             at: [350, 600]

    move_down 80
    text 'Address', style: :bold
    text_box 'Street',
             at: [0, 560]
    text_box ":   #{@student.street}",
             at: [100, 560]
    text_box 'Zip Code',
             at: [250, 560]
    text_box ":   #{@student.zip}",
             at: [350, 560]
    text_box 'City',
             at: [0, 540]
    text_box ":     #{@student.city}",
             at: [100, 540]
  end

  def company_data
    move_down 50
    text 'Company data:', style: :bold
    text_box 'Name',
             at: [0, 490]
    text_box ":   #{@company.name}",
             at: [100, 490]
    text_box 'Department',
             at: [250, 490]
    text_box ":   #{@company.industry}",
             at: [350, 490]

    move_down 30
    text 'Address',
         style: :bold
    text_box 'Street',
             at: [0, 450]
    text_box ":     #{@company_address.street}",
             at: [100, 450]
    text_box 'Zip Code',
             at: [250, 450]
    text_box ":     #{@company_address.zip}",
             at: [350, 450]
    text_box 'City ',
             at: [0, 430]
    text_box ":     #{@company_address.city}",
             at: [100, 430]
    text_box 'Country',
             at: [250, 430]
    text_box ":     #{@company_address.country}",
             at: [350, 430]

    move_down 45
    text 'Supervisor',
         style: :bold
    text_box 'Name ',
             at: [0, 390]
    text_box ":     #{@internship.supervisor_name}",
             at: [100, 390]
    text_box 'Email ',
             at: [250, 390]
    text_box ":     #{@internship.supervisor_email}",
             at: [350, 390]
  end

  def internship_data
    move_down 30
    text 'Internship Data :',
         style: :bold
    text_box 'Start date',
             at: [0, 340]
    text_box ":     #{@internship.start_date}",
             at: [100, 340]
    text_box 'End date ',
             at: [250, 340]
    text_box ":     #{@internship.end_date}",
             at: [350, 340]
    text_box 'Semester of Study',
             at: [0, 320]
    text_box ":     #{@semester.name}",
             at: [100, 320]
    text_box 'Reading professor',
             at: [0, 300]
    text_box ":     #{@internship.reading_prof.name}",
             at: [100, 300]
    text_box 'Work area',
             at: [0, 280]
    text_box ":     #{@internship.operational_area}",
             at: [100, 280]
    text_box 'Project/Tasks',
             at: [0, 260]
    text_box ":     #{@internship.tasks}",
             at: [100, 260]
  end

  def additional_information
    move_down 120
    text 'Admittance to internship semester:',
         style: :bold
    text '(Check the appropriate box courses and give the other data as needed)'
    bounding_box([0, 190], width: 20, height: 20) do
      stroke_bounds
    end
    text_box 'I have passed all of the courses that are prerequisites for admittance to the internship semester according to the internship rules for my program',
             at: [30, 190]
    bounding_box([0, 160], width: 20, height: 20) do
      stroke_bounds
    end
    text_box 'I am missing the following courses that are prerequisites for admittance to the internship semester according to the internship rules for my program',
             at: [30, 160]
    text_box 'Missing courses: ',
             at: [0, 130]
    text_box 'Registered?  YES/NO ',
             at: [200, 130]
    text_box 'Date and signature of the student:',
             at: [200, 100]

    move_down 60
    text 'To be filled out by the program internship officer',
         style: :bold
    text_box 'Prerequisites for admittance:     YES  NO',
             at: [0, 60]
    text_box 'Internship position suitable:     YES  NO',
             at: [0, 40]
    text_box 'Date and signature of program internship officer:',
             at: [200, 20]

    start_new_page
    text 'Ausfüllhinweise',
         style: :bold,
         align: :center
    text 'Für alles gilt: Bitte leserlich schreiben!',
         style: :bold

    move_down 20
    text 'Antrag',
         style: :bold

    move_down(10)
    text 'Studentendaten:',
         style: :bold
    text '- Matrikelnummer ist ohne s0 anzugeben.'
    text '- Geburtstag bitte in folgender Form TT.MM.JJ'

    move_down 10
    text 'Angaben zum Praktikumsbetrieb:',
         style: :bold
    text '- Im Feld für die Telefonnummer kann auch die Faxnummer, falls vorhanden, angegeben werden'
    text '- Sollte der Praktikumsbetrieb in Deutschland sein, muss ein besonderer Grund voeliegen.'
    text '  Es ist zum Beispiel erlaubt das Praktikum im Deutschland zu absolvieren, wenn der Student eine ausländische Hochschulzugangsberechtigung hat, diese ist dann in Kopie beizulegen'

    move_down 10
    text 'Angaben zum Praktikum:',
         style: :bold
    text '- Das Einsatzgebiet sollte nach Möglichkeit etwas genauer sein, als die Abteilung.'
    text '- Bitte die Aufgaben im Betrieb eintragen'
    text '- Gewünschten Hochschulbetreuer bitte unterstreichen. Es wird versucht den Wunsch zu berüchsichtigen.'

    move_down 10
    text 'Zulassung zum Praktikum:',
         style: :bold
    text '- Bitte ankreuzen, falls alle Leistungsnachweise vom 1. und 2. Semester erbracht worden sind.'
    text 'Unterschrift des Studenten hier nicht vergessen'

    move_down 20
    text 'Nachweis',
         style: :bold

    move_down 10
    text 'Praktikumszeugnis:',
         style: :bold
    text '- Hier muss die Firma unterschreiben!'

    move_down 10
    text 'Praxisbegleitende Lehrveranstaltungen:',
         style: :bold
    text '- Bitte eintragen, wann die Lehrveranstaltungen belegt worden sind, dafür Belege aus LSF ausdrucken.'
  end
end
