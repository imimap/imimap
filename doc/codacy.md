# Codacy Checks

## Brakeman

### Ignoring False Positives
https://brakemanscanner.org/docs/ignoring_false_positives/

CompanyAddress.joins(internships: [{complete_internship: :student}]).where('students.id' => student.id)
