# frozen_string_literal: true

# Generates PDF for Internship Application
class InternshipPdf < Prawn::Document
  def initialize(internship)
      super(page_size: 'A4')
      @student = internship.student
      @company = internship.company_v2
      @internship = internship
      @programming_languages = @internship.programming_languages.map { |x| x.name }.join(', ')
      @company_address = internship.company_address
      @semester = internship.semester
      @htw_logo = 'app/assets/images/S04_HTW_Berlin_Logo_pos_FARBIG_RGB.jpg'
      font_size 11
      header
      student_data
      company_data
      internship_data
      additional_information
      internship_officer_section
      notes_on_filling_in
    end

    # horizontal spacing:
    #  1st label - 15 , usually 1st field - 110
    # vertical spacing:
    #  start 645, immer -18 zur nächsten zeile, label koordinate immer 3 kleiner als textbox, immer -40 zwischen teilen mit überschrift

    def header
      indent(10) do
        text 'Hochschule für Technik und Wirtschaft Berlin'
        text 'Internationaler Studiengang Medieninformatik', style: :bold, size: 12
      end
      float do
        image @htw_logo, at: [440, 780], width: 80
      end
      stroke_horizontal_rule
    end

  def student_data
    move_down 10
    indent(10) do
      text "Anmeldung zum Praktikum für das #{@semester.name}"
    end
    move_down 5

    indent(10) do
      text 'Persönliche Daten', style: :bold, size: 12
    end

    text_box 'Matrikelnummer',
             at: [15, 697]
    bounding_box([110, 700], :width => 170, :height => 15) do
      move_down 3
      draw_text "#{@student.enrolment_number}", at: [bounds.left+2, bounds.top-11]
      stroke_bounds
    end

    text_box 'Vorname',
             at: [15, 679]
    bounding_box([110, 682], :width => 170, :height => 15) do
      move_down 3
      draw_text "#{@student.first_name}", at: [bounds.left+2, bounds.top-11]
      stroke_bounds
    end
    text_box 'Nachname',
             at: [290, 679]
    bounding_box([350, 682], :width => 170, :height => 15) do
      move_down 3
      draw_text "#{@student.last_name}", at: [bounds.left+2, bounds.top-11]
      stroke_bounds
    end

    text_box 'Geburtsdatum',
             at: [15, 661]
    bounding_box([110, 664], :width => 170, :height => 15) do
      move_down 3
      draw_text I18n.l(@student.birthday, format: :default).to_s, at: [bounds.left+2, bounds.top-11]
      stroke_bounds
    end
    text_box 'Geburtsort',
             at: [290, 661]
    bounding_box([350, 664], :width => 170, :height => 15) do
      move_down 3
      draw_text "#{@student.birthplace}", at: [bounds.left+2, bounds.top-11]
      stroke_bounds
    end

    text_box 'E-Mail',
             at: [15, 643]
    bounding_box([110, 646], :width => 410, :height => 15) do
      move_down 3
      draw_text "#{@student.email}", at: [bounds.left+2, bounds.top-11]
      stroke_bounds
    end
  end

  def company_data
    move_down 10
    indent(10) do
      text 'Angaben zum Praktikumsbetrieb',
        style: :bold, size: 12
    end

    text_box 'Firma',
             at: [15, 602]
    bounding_box([110, 605], :width => 410, :height => 15) do
      move_down 3
      draw_text "#{@company.try(:name)}", at: [bounds.left+2, bounds.top-11]
      stroke_bounds
    end

    text_box 'Straße',
             at: [15, 584]
    bounding_box([110, 587], :width => 410, :height => 15) do
      move_down 3
      draw_text "#{@company_address.try(:street)}", at: [bounds.left+2, bounds.top-11]
      stroke_bounds
    end

    text_box 'Postleitzahl',
             at: [15, 566]
    bounding_box([110, 569], :width => 80, :height => 15) do
      move_down 3
      draw_text "#{@company_address.try(:zip)}", at: [bounds.left+2, bounds.top-11]
      stroke_bounds
    end
    text_box 'Stadt',
             at: [200, 566]
    bounding_box([235, 569], :width => 120, :height => 15) do
      move_down 3
      draw_text "#{@company_address.try(:city)}", at: [bounds.left+2, bounds.top-11]
      stroke_bounds
    end
    text_box 'Land',
             at: [365, 566]
    bounding_box([400, 569], :width => 120, :height => 15) do
      move_down 3
      draw_text "#{@company_address.try(:country)}", at: [bounds.left+2, bounds.top-11]
      stroke_bounds
    end

    text_box 'Betriebliche_r Betreuer_in',
             at: [15, 548]
    bounding_box([145, 551], :width => 375, :height => 15) do
      move_down 3
      draw_text "#{@internship.try(:supervisor_name)}", at: [bounds.left+2, bounds.top-11]
      stroke_bounds
    end

    text_box 'E-Mail',
             at: [15, 530]
    bounding_box([145, 533], :width => 375, :height => 15) do
      move_down 3
      draw_text "#{@internship.try(:supervisor_email)}", at: [bounds.left+2, bounds.top-11]
      stroke_bounds
    end

    text_box 'Telefon',
             at: [15, 512]
    bounding_box([145, 515], :width => 375, :height => 15) do
      move_down 3
      draw_text "#{@internship.try(:supervisor_phone)}", at: [bounds.left+2, bounds.top-11]
      stroke_bounds
    end
  end

  def internship_data
    move_down 10
    indent(10) do
      text 'Angaben zum Praktikum',
            style: :bold, size: 12
    end

    text_box 'Praktikumsbeginn',
             at: [15, 471]
    bounding_box([110, 474], :width => 100, :height => 15) do
      move_down 3
      if @internship.start_date.present?
        draw_text I18n.l(@internship.start_date, format: :default).to_s, at: [bounds.left+2, bounds.top-11]
      end
      stroke_bounds
    end
    text_box 'Praktikumsende',
             at: [220, 471]
    bounding_box([310, 474], :width => 100, :height => 15) do
      move_down 3
      if @internship.end_date.present?
        draw_text I18n.l(@internship.end_date, format: :default).to_s, at: [bounds.left+2, bounds.top-11]
      end
      stroke_bounds
    end
    text_box 'Fachsemester',
             at: [420, 471]
    bounding_box([500, 474], :width => 20, :height => 15) do
      move_down 3
      draw_text "#{@internship.complete_internship.semester_of_study}", at: [bounds.left+2, bounds.top-11]
      stroke_bounds
    end

    text_box 'Einsatzgebiet',
             at: [15, 453]
    bounding_box([110, 456], :width => 410, :height => 15) do
      move_down 3
      draw_text "#{@internship.operational_area}", at: [bounds.left+2, bounds.top-11]
      stroke_bounds
    end

    text_box 'Thema/Aufgabe',
             at: [15, 435]
    bounding_box([110, 438], :width => 410, :height => 60) do
      move_down 3
      text "#{@internship.tasks}"
      stroke_bounds
    end

    text_box 'Pragrammiersprache(n)',
             at: [15, 372]
    bounding_box([140, 375], :width => 380, :height => 15) do
      move_down 3
      draw_text "#{@programming_languages}", at: [bounds.left+2, bounds.top-11]
      stroke_bounds
    end
  end

  def additional_information
    move_down 10
    indent(10) do
      text 'Zulassung zum Praktikum',
            style: :bold, size: 12
    end

    bounding_box([15, 334], width: 10, height: 10) do
      stroke_bounds
    end
    text_box 'Alle Leistungsnachweise, die laut Studienordnung Vorraussetzung für die Zulassung zum praktischen Studiensemester sind, wurden erbracht.',
             at: [30, 334]

    bounding_box([15, 308], width: 10, height: 10) do
      stroke_bounds
    end
    text_box 'Fehlende Leistungsnachweise: ',
             at: [30, 306]
    text_box '1. ',
             at: [190, 306]
    bounding_box([205, 308], :width => 210, :height => 15) do
      stroke_bounds
    end
    text_box '2. ',
            at: [190, 288]
    bounding_box([205, 290], :width => 210, :height => 15) do
      stroke_bounds
    end
    text_box '3. ',
            at: [190, 270]
    bounding_box([205, 272], :width => 210, :height => 15) do
      stroke_bounds
    end
    text_box 'Belegung:',
            at: [420, 306]
    bounding_box([480, 308], :width => 40, :height => 15) do
      stroke_bounds
    end
    bounding_box([480, 290], :width => 40, :height => 15) do
      stroke_bounds
    end
    bounding_box([480, 272], :width => 40, :height => 15) do
      stroke_bounds
    end

    text_box 'Zum Zeitpunkt der Anmeldung des Praktikums liegt der Praktikumsvertrag vor',
             at: [15, 250]
    bounding_box([15, 235], width: 10, height: 10) do
      stroke_bounds
    end


    text_box 'als Original',
             at: [30, 235]
    bounding_box([15, 220], width: 10, height: 10) do
      if !@internship.contract_original.nil? && @internship.contract_original
        draw_text "x", at: [bounds.left+2, bounds.top+7]
      end
      stroke_bounds
    end

    text_box 'als Kopie (Mir ist bewußt, dass die Anmeldung bis zur Vorlage/Übersendung des handschriftlich unterschriebenen Originalvertrages unvollständig ist und auch keine Anerkennung des Praktikums ohne diesen erfolgen kann)',
             at: [30, 220]
    bounding_box([15, 205], width: 10, height: 10) do
      if !@internship.contract_original.nil? && !@internship.contract_original
          draw_text "x", at: [bounds.left+2, bounds.top+7]
      end
    end
    move_down 65
    indent(300) do
      stroke_horizontal_rule


      move_down 5
      text 'Datum, Unterschrift der/des Studierenden', size: 9
    end
  end


  def internship_officer_section
    dash(3, space: 3, phase: 3)
    stroke_horizontal_line 0, 525, at: 115
    dash(1, space: 0, phase: 1)
    move_down 15
    indent(10) do
      text 'Von der/dem Praktikumsbeauftragten auszufüllen',
            style: :bold, size: 12
    end
    text_box 'ja',
         at: [230, 85]
    text_box 'nein',
         at: [255, 85]
    text_box 'Zulassungsvorraussetzungen erfüllt:',
         at: [15, 70]
    bounding_box([230, 70], width: 10, height: 10) do
      stroke_bounds
    end
    bounding_box([260, 70], width: 10, height: 10) do
      stroke_bounds
    end
    text_box 'Eignung des Praktikumsplatzes:',
         at: [15, 55]
    bounding_box([230, 55], width: 10, height: 10) do
      stroke_bounds
    end
    bounding_box([260, 55], width: 10, height: 10) do
      stroke_bounds
    end

    move_down 15
    indent(300) do
      stroke_horizontal_rule
      move_down 5
      text 'Datum, Unterschrift der/des Praktikumsbeauftragten', size: 9
    end
end

def notes_on_filling_in
    start_new_page
    header
    indent(10) do
      move_down 25
      text 'Ausfüllhinweise',
            style: :bold,
            size: 18
      move_down 25
      text 'Für alles gilt: Bitte leserlich schreiben!',
            style: :bold

      move_down 25
      text 'Antrag',
            style: :bold,
            size: 15

      move_down 15
      text 'Persönliche Daten',
            style: :bold
      move_down 3
      indent(5) do
        text '- Matrikelnummer ist ohne s0 anzugeben.'
        text '- Geburtstag bitte in folgender Form TT.MM.JJ oder JJJJ-MM-TT'
      end

      move_down 15
      text 'Angaben zum Praktikumsbetrieb',
            style: :bold
      move_down 3
      indent(5) do
        text '- Sollte der Praktikumsbetrieb in Deutschland sein, muss ein besonderer Grund vorliegen. Es ist zum Beispiel erlaubt das Praktikum im Deutschland zu absolvieren, wenn die/der Studierende eine ausländische Hochschulzugangsberechtigung hat. Diese ist dann in Kopie beizulegen.'
      end

      move_down 15
      text 'Angaben zum Praktikum',
            style: :bold
      move_down 3
      indent(5) do
        text '- Bitte die Aufgaben im Betrieb eintragen'
      end

      move_down 15
      text 'Zulassung zum Praktikum',
            style: :bold
      move_down 3
      indent(5) do
        text '- Bitte ankreuzen, falls alle Leistungsnachweise vom 1. und 2. Semester erbracht worden sind.'
        text '- Der Praktikumsvertrag muss für eine vollständige Anmeldung im Original vorliegen. Ein Original ist eine von beiden Vertragspartner_innen im Original unterschriebene Version. Ist mindestens eine der beiden Unterschriften nicht im original vorhanden bestätigen Sie mit Ihrer Unterschrift, dass Sie den Vertrag so bald wie möglich in der Originalversion nachreichen.'
      end

      move_down 10
      text 'Mit Ihrer Unterschrift bestätigen Sie die Richtigkeit aller von Ihnen gemachten Angaben und gegebenenfalls die zur Kenntnisnahme der Notwendigkeit Originaldokumente nachzureichen.'

      move_down 25
      text 'Nachweis',
            style: :bold,
            size: 15

      move_down 15
      text 'Praktikumszeugnis',
            style: :bold
      move_down 3
      text '- Hier muss die Firma unterschreiben!'

      move_down 15
      text 'Praxisbegleitende Lehrveranstaltungen',
            style: :bold
      move_down 3
      text '- Bitte eintragen, wann die Lehrveranstaltungen belegt worden sind und dafür Belege aus dem LSF ausdrucken.'
    end
  end
end
