# Codacy Checks

## Brakeman

### Ignoring False Positives

https://brakemanscanner.org/docs/ignoring_false_positives/

doesn't work as described

## Run Local Analysis before a commit:
https://github.com/codacy/codacy-analysis-cli#install

    codacy-analysis-cli analyse --tool brakeman --directory /Users/kleinen/mine/current/htw/imimap/code/imimap-05

 different results than just calling

      brakeman


- disabled "Reports models which have dangerous attributes defined under the attr_acc.." on https://app.codacy.com/manual/kleinen/imimap/patterns/list
