
# CompleteInternship Migration Notes

## The current InternshipState s:

irb(main):007:0> puts InternshipState.all.map{|is|"#{is.id}: #{is.name}\n"}.join

1: passed
2: internship was abandoned because of the following reasons
3: the student still has to pass the following courses
4: waiting for AEP

## Zusammenfassung

Für die Migration kann einfach für alle "1: passed" aep und passed in
CompleteInternship auf true gesetzt werden.

2,3,4 - insbesondere 4 - sollten nochmal inhaltlich überprüft werden. 2&3 sind
jeweils 5 Fälle, auch nachsehen.

## Details


es sind alle vergeben:

irb(main):010:0> Internship.pluck(:internship_state_id).uniq
   (9.9ms)  SELECT "internships"."internship_state_id" FROM "internships"
=> [nil, 1, 4, 2, 3]

## 4 warten auf aep, da bitte mal reingucken was da los ist:

irb(main):021:0> Internship.where(internship_state_id: 4).count
   (5.3ms)  SELECT COUNT(*) FROM "internships" WHERE "internships"."internship_state_id" = $1  [["internship_state_id", 4]]
=> 3
irb(main):022:0> Internship.where(internship_state_id: 4).map{|i|i.semester.name}
  Internship Load (4.9ms)  SELECT "internships".* FROM "internships" WHERE "internships"."internship_state_id" = $1  [["internship_state_id", 4]]
  Semester Load (0.8ms)  SELECT  "semesters".* FROM "semesters" WHERE "semesters"."id" = $1 ORDER BY "semesters"."sid" DESC LIMIT $2  [["id", 120], ["LIMIT", 1]]
  Semester Load (0.9ms)  SELECT  "semesters".* FROM "semesters" WHERE "semesters"."id" = $1 ORDER BY "semesters"."sid" DESC LIMIT $2  [["id", 119], ["LIMIT", 1]]
  Semester Load (1.0ms)  SELECT  "semesters".* FROM "semesters" WHERE "semesters"."id" = $1 ORDER BY "semesters"."sid" DESC LIMIT $2  [["id", 120], ["LIMIT", 1]]
=> ["WS 18/19", "SS 18", "WS 18/19"]
irb(main):023:0>

irb(main):023:0> Internship.where(internship_state_id: 4).map{|i|i.id}
  Internship Load (5.8ms)  SELECT "internships".* FROM "internships" WHERE "internships"."internship_state_id" = $1  [["internship_state_id", 4]]
=> [522, 474, 509]
das ist falsch, sie stehen alle 3 in der aep liste vom wintersemester:
https://people.f4.htw-berlin.de/~weberwu/classes/HTW/AEP/imi-aep-praesenz-WS1819.shtml

## 2 & 3 ignorieren:
### 3: the student still has to pass the following courses
Es gibt 5:
Internship.where(internship_state_id: 3).count
=> 5

Und die sind recht alt:
irb(main):016:0> Internship.where(internship_state_id: 3).map{|i|i.semester.name}
=> ["WS 11/12", "SS 12", "SS 11", "SS 12", "SS 14"]

irb(main):030:0> Internship.where(internship_state_id: 3).map{|i| i.student.internships.map{|i| i.id}}
=> [[105], [121], [132], [165], [367]]

bei diesen gibt es keine neueren praktika. bitte mal per hand nachprüfen.

### 2: internship was abandoned because of the following reasons

irb(main):025:0> Internship.where(internship_state_id: 2).pluck(:id)
   (7.3ms)  SELECT "internships"."id" FROM "internships" WHERE "internships"."internship_state_id" = $1  [["internship_state_id", 2]]
=> [29, 195, 220, 222, 252]

252 - kein Visum, es gibt neueres: 276
für alle anderen auch:
222 - 243
220 - 223
195 - 141
29 - 126

irb(main):029:0> Internship.where(internship_state_id: 2).map{|i| i.student.internships.map{|i| i.id}}

=> [[29, 126], [195, 141], [220, 233], [222, 243], [252, 276]]

d.h. wenn wir den status von der jüngeren Internship übernehmen, ist alles ok.

Auch wenige und alt:

irb(main):018:0> Internship.where(internship_state_id: 2).count
   (7.0ms)  SELECT COUNT(*) FROM "internships" WHERE "internships"."internship_state_id" = $1  [["internship_state_id", 2]]
=> 5
irb(main):019:0> Internship.where(internship_state_id: 2).map{|i|i.semester.name}
  Internship Load (5.9ms)  SELECT "internships".* FROM "internships" WHERE "internships"."internship_state_id" = $1  [["internship_state_id", 2]]
  Semester Load (1.0ms)  SELECT  "semesters".* FROM "semesters" WHERE "semesters"."id" = $1 ORDER BY "semesters"."sid" DESC LIMIT $2  [["id", 2], ["LIMIT", 1]]
  Semester Load (1.1ms)  SELECT  "semesters".* FROM "semesters" WHERE "semesters"."id" = $1 ORDER BY "semesters"."sid" DESC LIMIT $2  [["id", 2], ["LIMIT", 1]]
  Semester Load (0.8ms)  SELECT  "semesters".* FROM "semesters" WHERE "semesters"."id" = $1 ORDER BY "semesters"."sid" DESC LIMIT $2  [["id", 102], ["LIMIT", 1]]
  Semester Load (0.8ms)  SELECT  "semesters".* FROM "semesters" WHERE "semesters"."id" = $1 ORDER BY "semesters"."sid" DESC LIMIT $2  [["id", 102], ["LIMIT", 1]]
  Semester Load (1.1ms)  SELECT  "semesters".* FROM "semesters" WHERE "semesters"."id" = $1 ORDER BY "semesters"."sid" DESC LIMIT $2  [["id", 103], ["LIMIT", 1]]
=> ["WS 12/13", "WS 12/13", "WS 13/14", "WS 13/14", "SS 14"]
