module Api
  module V1
    class PhoneResource < JSONAPI::Resource
      attributes :phone, :area_id
    end
  end
end