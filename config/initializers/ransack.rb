Ransack.configure do |config|
  config.add_predicate 'date_equals',
  arel_predicate: 'eq',
  formatter: proc { |v| v.to_date },
  validator: proc { |v| v.present? },
  type: :string
end
Ransack::Adapters::ActiveRecord::Base.class_eval('remove_method :search')