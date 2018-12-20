# frozen_string_literal: true

# this is a method call api tryout to figure out how to pass the
# parameter list to permit_params() in active admin
# see
# https://coderwall.com/p/g4al5g/strong-parameters-with-has_and_belongs_to_many
# and especially
# https://github.com/activeadmin/activeadmin/blob/master/docs/
# 2-resource-customization.md#setting-up-strong-parameters
describe 'method call with array and hash' do
  def the_method(*params)
    params
  end
  NESTED_ATTRIBUTES = { programming_language_ids: [] }.freeze
  def method2_returning_params
    a = [1, 2]
    a << NESTED_ATTRIBUTES
    a
  end
  it 'calls method with variables from a method 2' do
    params = the_method(*method2_returning_params)
    expect(params[0]).to eq 1
    expect(params[1]).to eq 2
    expect(params[2]).to eq(programming_language_ids: [])
  end
end
