# frozen_string_literal: true

FactoryBot.define do
  factory :payment_state do
    name { 'payment state name' }
    name_de { 'payment state name_de' }
  end

  factory :paid, class: PaymentState do
    name { 'paid' }
    name_de { 'paid_de' }
  end

  factory :unpaid, class: PaymentState do
    name { 'unpaid' }
    name_de { 'unpaid_de' }
  end
end
