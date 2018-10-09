COMPLETE_INTERNSHIP_MEMBERS = %i[first_name
                                   last_name
                                   enrolment_number
                                   company
                                   city
                                   country
                                   start_date
                                   end_date
                                   internship_state
                                   contract_state
                                   registration_state
                                   certificate_state].freeze
CompleteInternship = Struct.new(*COMPLETE_INTERNSHIP_MEMBERS)
