# frozen_string_literal: true

FactoryBot.define do
  factory :internship_state do
    name { 'passed' }
    name_de { 'bestanden' }
  end
  factory :internship_state_passed, class: InternshipState do
    name { 'passed' }
    name_de { 'bestanden' }
  end
  factory :internship_state_aep, class: InternshipState do
    name { 'waiting for AEP' }
    name_de { 'wartet auf AEP' }
  end
end
# von Production, die States die es gibt:
# irb(main):001:0> InternshipState.all
#   InternshipState Load (0.9ms)  SELECT  "internship_states".* FROM "internship_states" LIMIT $1  [["LIMIT", 11]]
# => #<ActiveRecord::Relation [#<InternshipState id: 1, name: "passed", name_de: "bestanden", created_at: "2013-07-11 17:04:50", updated_at: "2013-07-11 17:04:50">, #<InternshipState id: 2, name: "internship was abandoned because of the following ...", name_de: "abgelehnt aus folgenden Gründen", created_at: "2013-07-11 17:04:50", updated_at: "2013-07-11 17:04:50">, #<InternshipState id: 3, name: "the student still has to pass the following course...", name_de: "Student hat die folgenden Kurse zu absolvieren", created_at: "2013-07-11 17:04:50", updated_at: "2013-07-11 17:04:50">, #<InternshipState id: 4, name: "waiting for AEP", name_de: "wartet auf AEP", created_at: "2017-03-17 19:55:01", updated_at: "2017-03-17 19:55:01">]>
