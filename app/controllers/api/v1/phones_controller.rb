module Api
  module V1
    class PhonesController < JSONAPI::ResourceController
      
      def index
        @error = check_params(params)
        if @error.nil?
          auth_key = params[:auth_key]
          limit = params[:limit]
          bpo_vender = authenticate(auth_key)
          if bpo_vender.is_a?(BpoVender)
            @phones = Phone.select(:id,:phone,:area_id).joins("LEFT JOIN bpo_venders_phones ON bpo_venders_phones.phone_id = phones.id").where("phone_id is null and registered=0 and okay=1").limit(limit)
            bpo_vender.phones += @phones
            @response = {:status => "success", :message => "#{@phones.length} phone numbers fetched successfully", :data => @phones}
          else
            @response = {:status => "failure", :message => "invalid auth key", :data => nil}
          end
        else
          @response = @error
        end
        render :json => @response
      end
      
      private
      
      def authenticate(auth_key)
        BpoVender.find_by_auth_key(auth_key) rescue nil
      end
      
      def check_params(params)
        #check parameters exist
        if params[:auth_key].present? and params[:limit].blank?
          return {:status => "failure", :message => "limit parameter is missing", :data => nil}
        elsif params[:auth_key].blank? and params[:limit].present?
          #check parameters format
          if params[:limit] =~ /^\d{1,4}$/
            return {:status => "failure", :message => "auth key parameter is missing", :data => nil}
          else
            return {:status => "failure", :message => "auth key parameter is missing and invalid limit (e.g enter limit between 1-9999)", :data => nil}
          end
        elsif params[:auth_key].blank? and params[:limit].blank?
          return {:status => "failure", :message => "auth key and limit parameters are missing", :data => nil}
        end
        
        if params[:auth_key].present? and params[:limit].present?
          #check parameters format
          if params[:limit] =~ /^\d{1,4}$/
            return nil
          else
            return {:status => "failure", :message => "invalid limit (e.g enter limit between 1-9999)", :data => nil}
          end
        end
      end
    end
  end
end