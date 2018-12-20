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

  def method_returning_params
    [1, 2, { a: :b }]
  end
  it 'calls method with variables' do
    a = [1, 2]
    h = { a: :b }
    params_to_pass = a << h
    params = the_method(*params_to_pass)
    expect(params[0]).to eq 1
    expect(params[1]).to eq 2
    expect(params[2]).to eq(a: :b)
  end

  it 'calls method with variables from a method' do
    params = the_method(*method_returning_params)
    expect(params[0]).to eq 1
    expect(params[1]).to eq 2
    expect(params[2]).to eq(a: :b)
  end

end
