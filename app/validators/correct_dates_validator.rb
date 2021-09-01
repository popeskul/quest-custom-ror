class CorrectDatesValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, I18n.t('.invalid_date')) unless valid_date?(record)
  end

  def valid_date?(record)
    record.start_time && record.end_time && record.start_time <= record.end_time
  end
end
