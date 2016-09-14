class ApiController < ApplicationController
	def sync_master
    error = sync_master_check_params(params)
    if error.nil?
      auth_key = params[:auth_key]
      model = params[:model]
      id = params[:id]
      bpo_vender = authenticate_1point1(auth_key)
      if bpo_vender.is_a?(BpoVender)
        case model
        when "category"
          result = Category.unscoped.select(:id,:title).where("id > ?",id) rescue nil
        when "emp_type"
          result = EmpType.unscoped.select(:id,:title).where("id > ?",id) rescue nil
        when "location"
          result = Location.unscoped.select(:id,:location).where("id > ?",id) rescue nil
        when "area"
          result = Area.unscoped.select(:id,:area).where("id > ?",id) rescue nil
        when "education"
          result = Education.select(:id,:education).unscoped.where("id > ?",id) rescue nil
        end
        if result.nil?
          message = "[api controller][sync master] - error: model - #{model}, id - #{id}"
          UnnatiMailer.delay(run_at: 10.seconds.from_now, queue: 'email').system_notification(message,"Admin")
          response = {:status => "failure", :message => "internal system error", :data => nil}
        else
          response = {:status => "success", :message => "#{result.length} records fetched successfully", :data => result}
        end        
      else
        response = {:status => "failure", :message => "invalid auth key", :data => nil}
      end
    else
      response = error
    end
    render :json => response
  end
  
  def pull_phone_numbers
    @error = pull_phone_numbers_check_params(params)
    if @error.nil?
      auth_key = params[:auth_key]
      limit = params[:limit]
      bpo_vender = authenticate_1point1(auth_key)
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
  #1point1 authentication
  def authenticate_1point1(auth_key)
    BpoVender.find_by_auth_key(auth_key) rescue nil
  end
  #1point1 sync master check parameters
  def sync_master_check_params(params)
    if params[:auth_key].blank?
      message = "[api controller][sync master check params] - auth key is missing"
      UnnatiMailer.delay(run_at: 10.seconds.from_now, queue: 'email').system_notification(message,"Admin")
      return {:status => "failure", :message => "auth key is missing", :data => nil}
    end
    if params[:model].blank?
      message = "[api controller][sync master check params] - model is missing"
      UnnatiMailer.delay(run_at: 10.seconds.from_now, queue: 'email').system_notification(message,"Admin")
      return {:status => "failure", :message => "model is missing", :data => nil}
    else
      unless ["category","emp_type","location","area","education"].include?(params[:model])
        message = "[api controller][sync master check params] - #{params[:model]} - model not found"
        UnnatiMailer.delay(run_at: 10.seconds.from_now, queue: 'email').system_notification(message,"Admin")
        return {:status => "failure", :message => "model not found", :data => nil}
      end
    end
    if params[:id].blank?
      message = "[api controller][sync master check params] - id is missing"
      UnnatiMailer.delay(run_at: 10.seconds.from_now, queue: 'email').system_notification(message,"Admin")
      return {:status => "failure", :message => "id is missing", :data => nil}
    else
      unless params[:id] =~ /^\d+$/
        message = "[api controller][sync master check params] - #{params[:id]} - invalid id"
        UnnatiMailer.delay(run_at: 10.seconds.from_now, queue: 'email').system_notification(message,"Admin")
        return {:status => "failure", :message => "#{params[:id]} - invalid id", :data => nil}
      end
    end
  end
  #1point1 pull phone numbers check parameters 
  def pull_phone_numbers_check_params(params)
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
