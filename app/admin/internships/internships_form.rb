# frozen_string_literal: true

ActiveAdmin.register Internship do
  form do |f|
    inputs 'CompleteInternship' do
      f.input :complete_internship_id,
              as: :select,
              collection: CompleteInternship
                .all
                .collect { |cs| [student_selector(student: cs.student), cs.id] }
      # .order(:last_name)
      # .collect { |s| [student_selector(student: s), s.id] }
      f.semantic_errors :student
    end
    inputs 'CompanyAddress' do
      f.input :company_address_id,
              as: :select,
              collection: CompanyAddress
                .joins(:company)
                .order('companies.name')
                .pluck(:name, :street, :city, :country, :id)
                .map { |name, street, city, country, id|
                            [
                              "#{name},
                               #{street},
                               #{city},
                                #{country}", id
                            ]
                          }
    end

    f.inputs 'Internship' do
      f.input :start_date, as: :datepicker,
                           datepicker_options: {
                             min_date: '2010-01-01',
                             max_date: '2050-01-01'
                           }
      f.input :end_date, as: :datepicker,
                         datepicker_options: {
                           min_date: '2010-01-01',
                           max_date: '2050-01-01'
                         }
      f.input :operational_area
      f.input :tasks
      f.input :supervisor_name
      f.input :supervisor_email
      f.input :supervisor_phone
      f.input :programming_languages
      f.input :orientation
    end
    f.inputs 'Administration' do
      f.input :semester_id,
              label: 'Semester',
              as: :select,
              collection: Semester.order(:name)
                                  .collect { |s| [s.name, s.id] }
      f.input :registration_state_id,
              label: 'Registration',
              as: :select,
              collection: RegistrationState.order(:name)
                                           .collect { |rs| [rs.name, rs.id] }
      f.input :payment_state_id,
              label: 'Payment',
              as: :select,
              collection: PaymentState.order(:name)
                                      .collect { |ps| [ps.name, ps.id] }
      f.input :contract_state_id,
              label: 'Contract',
              as: :select,
              collection: ContractState.order(:name)
                                       .collect { |cs| [cs.name, cs.id] }
      f.input :report_state_id,
              label: 'Report',
              as: :select,
              collection: ReportState.order(:name)
                                     .collect { |rs| [rs.name, rs.id] }
      f.input :certificate_state_id,
              label: 'Certificate',
              as: :select,
              collection: CertificateState.order(:name)
                                          .collect { |cs| [cs.name, cs.id] }
      f.input :reading_prof_id,
              label: 'Certficate reading prof',
              as: :select,
              collection: ReadingProf.order(:name)
                                     .collect { |p| [p.name, p.id] }
      f.input :certificate_to_prof, as: :date_picker
      f.input :certificate_signed_by_prof, as: :date_picker
      f.input :certificate_signed_by_internship_officer, as: :date_picker
      f.input :internship_state,
              as: :select,
              collection: InternshipState.order(:name)
                                         .collect { |is| [is.name, is.id] }
      f.input :comment
      f.actions
    end
  end
end
