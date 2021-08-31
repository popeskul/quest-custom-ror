class CorrectDatesValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if record.starttime && record.endtime
      record.errors.add(attribute, 'must be a valid date') if record.starttime > record.endtime
    end
  end
end
